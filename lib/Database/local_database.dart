import 'package:at_save/model/budget.dart';
import 'package:at_save/model/expense.dart';
import 'package:at_save/model/savings_goal.dart';
import 'package:at_save/model/savings_transaction.dart';
import 'package:at_save/model/user.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class LocalDatabase {
  static final LocalDatabase _instance = LocalDatabase._internal();

  factory LocalDatabase() {
    return _instance;
  }

  LocalDatabase._internal();

  static Isar? _isar;

  static openIsar() async {
    //var currentUser = await SessionManager().loggedIn();
    _isar = await Isar.open([
      ExpenseSchema,
      SavingsGoalSchema,
      UserSchema,
      SavingsTransactionSchema,
      BudgetSchema
    ],
        // name: currentUser.toString(),
        directory: (await getApplicationSupportDirectory()).path);
  }

  Future<User?> fetchUser() async {
    return _isar!.writeTxn(() async {
      return _isar!.users.where().findFirst();
    });
  }

  Future populateUser(User user) async {
    return _isar!.writeTxn(() async {
      await _isar!.users.clear();

      return _isar!.users.put(user);
    });
  }

  Future populateGoals(List<SavingsGoal> goals) async {
    return _isar!.writeTxn(() async {
      await _isar!.savingsGoals.clear();

      return _isar!.savingsGoals.putAll(goals);
    });
  }

  Future<List<SavingsGoal>> fetchGoals() async {
    return _isar!.writeTxn(() async {
      return _isar!.savingsGoals.where().findAll();
    });
  }

  Future<List<SavingsTransaction>> fetchTransactions() async {
    return _isar!.writeTxn(() async {
      return _isar!.savingsTransactions.where().findAll();
    });
  }

  Future populateSavingsTransaction(
      List<SavingsTransaction> transactions) async {
    return _isar!.writeTxn(() async {
      await _isar!.savingsTransactions.clear();

      return _isar!.savingsTransactions.putAll(transactions);
    });
  }

  Future<void> saveGoal(SavingsGoal goal) async {
    return _isar!.writeTxn(() async {
      final goalBox = _isar!.savingsGoals;
      await goalBox.put(goal);
    });
  }

  Future<void> addToUserTotalSavingsBalance(double amount) async {
    return _isar!.writeTxn(() async {
      final userBox = _isar!.users;
      final user = await userBox.get(1);
      user!.savingsBalance = (user.savingsBalance ?? 0) + amount;
      await userBox.put(user);
    });
  }

  Future<void> removeFromUserTotalSavingsBalance(double amount) async {
    return _isar!.writeTxn(() async {
      final userBox = _isar!.users;
      final user = await userBox.get(1);
      user!.savingsBalance = (user.savingsBalance ?? 0) - amount;
      await userBox.put(user);
    });
  }

  Future<void> addToSavingsBalance(String id, double amount) async {
    return _isar!.writeTxn(() async {
      final savingsGoalBox = _isar!.savingsGoals;

      // Query the savings goals collection in Isar for the goal with the matching Firebase ID
      final savingsGoals =
          await savingsGoalBox.filter().idEqualTo(id).findAll();

      final savingsGoal = savingsGoals[0];
      savingsGoal.currentAmount += amount;
      await savingsGoalBox.put(savingsGoal);
    });
  }

  Future<void> removeFromSavingsBalance(double amount, String id) async {
    return _isar!.writeTxn(() async {
      final goalBox = _isar!.savingsGoals;
      final savingsGoals = await goalBox.filter().idEqualTo(id).findAll();

      if (savingsGoals.isNotEmpty) {
        final savingsGoal = savingsGoals[0];
        savingsGoal.currentAmount -= amount;
        await goalBox.put(savingsGoal);
      }
    });
  }

  Future<void> addToWalletBalance(double amount, String id) async {
    return _isar!.writeTxn(() async {
      final userBox = _isar!.users;
      final user = await userBox.get(1);
      user!.walletBalance = (user.walletBalance ?? 0) + amount;
      await userBox.put(user);
    });
  }

  Future<void> removeFromWalletBalance(double amount) async {
    return _isar!.writeTxn(() async {
      final userBox = _isar!.users;
      final user = await userBox.get(1);
      user!.walletBalance = (user.walletBalance ?? 0) - amount;
      await userBox.put(user);
    });
  }

  Future<void> addMoney(String id, double amount) async {
    return _isar!.writeTxn(() async {
      await addToSavingsBalance(id, amount);
      await addToUserTotalSavingsBalance(amount);
      await removeFromWalletBalance(amount);
    });
  }

  Future<void> deleteAllTransactions(String id) async {
    return _isar!.writeTxn(() async {
      final transactionBox = _isar!.savingsTransactions;
      final transactions =
          await transactionBox.filter().savingsGoalIdEqualTo(id).findAll();
      List<int> transactionsIdToDelete = [];
      for (final transact in transactions) {
        transactionsIdToDelete.add(transact.myId!);
      }
      await transactionBox.deleteAll(transactionsIdToDelete);
    });
  }

  Future<void> changeSavingsStatus(String id, String status) async {
    return _isar!.writeTxn(() async {
      final goalBox = _isar!.savingsGoals;
      final goal = await goalBox.filter().idEqualTo(id).findFirst();
      if (goal != null) {
        goal.status = status;
        await goalBox.put(goal);
      }
    });
  }

  Future<void> breakSavings(String id, double amount) async {
    await removeFromSavingsBalance(amount, id);
    await removeFromUserTotalSavingsBalance(amount);
    await changeSavingsStatus(id, 'Terminated');
    await addToWalletBalance(amount, id);
  }

  Future<void> deleteGoal(String id, double amount) async {
    await breakSavings(id, amount);
    return _isar!.writeTxn(() async {
      final goalBox = _isar!.savingsGoals;
      final goal = await goalBox.filter().idEqualTo(id).findFirst();
      if (goal != null) {
        await goalBox.delete(goal.myId!);
      }
      await deleteAllTransactions(id);
    });
  }

  Future<void> createSavingsTransaction(SavingsTransaction transaction) async {
    return _isar!.writeTxn(() async {
      final transactionBox = _isar!.savingsTransactions;
      await transactionBox.put(transaction);
    });
  }

  Future<void> updateSavings(
    String id,
    String title,
    String description,
    double targetAmount,
    DateTime date,
  ) async {
    return _isar!.writeTxn(() async {
      final goalBox = _isar!.savingsGoals;
      SavingsGoal? goal = await goalBox.filter().idEqualTo(id).findFirst();
      if (goal != null) {
        goal.title = title;
        goal.description = description;
        goal.targetAmount = targetAmount;
        goal.targetDate = date;
        await goalBox.put(goal);
      }
    });
  }

  Future<void> createBudget(Budget budget) async {
    return _isar!.writeTxn(() async {
      final goalBox = _isar!.budgets;
      await goalBox.put(budget);
    });
  }

  Future<List<Budget>> populateBudget(List<Budget> budgets) async {
    return _isar!.writeTxn(() async {
      await _isar!.budgets.clear();
      await _isar!.budgets.putAll(budgets);
      return await _isar!.budgets.where().findAll();
    });
  }

  Future<List<Budget>> fetchBudgets() async {
    return _isar!.writeTxn(() async {
      return _isar!.budgets.where().findAll();
    });
  }

  Future<void> createExpenseTransaction(Expense expense) async {
    return _isar!.writeTxn(() async {
      final goalBox = _isar!.expenses;
      await goalBox.put(expense);
    });
  }

  Future<List<Expense>> populateExpensesTransaction(
      List<Expense> expenses) async {
    return _isar!.writeTxn(() async {
      await _isar!.expenses.clear();
      await _isar!.expenses.putAll(expenses);
      return await _isar!.expenses.where().findAll();
    });
  }

  Future<List<Expense>> fetchExpensesTransactions() async {
    return _isar!.writeTxn(() async {
      return _isar!.expenses.where().findAll();
    });
  }

  Future<void> addMoneyToBudget(double amount, String budgetname) async {
    return _isar!.writeTxn(() async {
      final myBudgets = _isar!.budgets;
      Budget? budget =
          await myBudgets.filter().nameEqualTo(budgetname).findFirstSync();
      if (budget != null) {
        budget.currentAmount = amount + budget.currentAmount!;
        await myBudgets.put(budget);
      }
    });
  }
}
