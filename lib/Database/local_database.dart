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
//opens isar
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

// This fetchest the only user in the database
  Future<User?> fetchUser() async {
    return _isar!.writeTxn(() async {
      return _isar!.users.where().findFirst();
    });
  }

// this method takes a user object to add to the database
  Future populateUser(User user) async {
    return _isar!.writeTxn(() async {
      await _isar!.users.clear();

      return _isar!.users.put(user);
    });
  }

  /// Adds a list of all savings goals to he isar database, mostly used wwhen synchronnizing with firebase.
  Future populateGoals(List<SavingsGoal> goals) async {
    return _isar!.writeTxn(() async {
      await _isar!.savingsGoals.clear();

      return _isar!.savingsGoals.putAll(goals);
    });
  }

  ///Fetches all the available goals in the databse and saves it in a list to be returned
  Future<List<SavingsGoal>> fetchGoals() async {
    return _isar!.writeTxn(() async {
      return _isar!.savingsGoals.where().findAll();
    });
  }

  /// Fetches all the available savings transactions, ie all money added to a savings.
  Future<List<SavingsTransaction>> fetchTransactions() async {
    return _isar!.writeTxn(() async {
      return _isar!.savingsTransactions.where().findAll();
    });
  }

//Stores a list of savings transaction to be returned
  Future populateSavingsTransaction(
      List<SavingsTransaction> transactions) async {
    return _isar!.writeTxn(() async {
      await _isar!.savingsTransactions.clear();

      return _isar!.savingsTransactions.putAll(transactions);
    });
  }

  ///This method takes a Saving goal objects to be saved in the database.
  Future<void> saveGoal(SavingsGoal goal) async {
    return _isar!.writeTxn(() async {
      final goalBox = _isar!.savingsGoals;
      await goalBox.put(goal);
    });
  }

  ///This method saves an amount saed to the total saving amount of a user in the user object.
  Future<void> addToUserTotalSavingsBalance(double amount) async {
    return _isar!.writeTxn(() async {
      final userBox = _isar!.users;
      final user = await userBox.get(1);
      user!.savingsBalance = (user.savingsBalance ?? 0) + amount;
      await userBox.put(user);
    });
  }

  ///This method removes an amount saved to the total saving amount of a user in the user object.
  Future<void> removeFromUserTotalSavingsBalance(double amount) async {
    return _isar!.writeTxn(() async {
      final userBox = _isar!.users;
      final user = await userBox.get(1);
      user!.savingsBalance = (user.savingsBalance ?? 0) - amount;
      await userBox.put(user);
    });
  }

  ///Saves an amount to the specific goal targeted
  Future<void> addToLocalSavingsBalance(String id, double amount) async {
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

  /// removes a certain amount from a targeted saving goal by its unique id
  Future<void> removeFromLocalSavingsBalance(double amount, String id) async {
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

  ///Adds money to the wallet balance of the user
  Future<void> addToLocalWalletBalance(double amount) async {
    return _isar!.writeTxn(() async {
      final userBox = _isar!.users;
      final user = await userBox.get(1);
      user!.walletBalance = (user.walletBalance ?? 0) + amount;
      await userBox.put(user);
    });
  }

  ///Removes a certain amount of nobey from the wallet balance of the user
  Future<void> removeFromLocalWalletBalance(double amount) async {
    return _isar!.writeTxn(() async {
      final userBox = _isar!.users;
      final user = await userBox.get(1);
      user!.walletBalance = (user.walletBalance ?? 0) - amount;
      await userBox.put(user);
    });
  }

  // Future<void> addMoney(String id, double amount) async {
  //   return _isar!.writeTxn(() async {
  //     await addToLocalSavingsBalance(id, amount);
  //     await addToUserTotalSavingsBalance(amount);
  //     await removeFromLocalWalletBalance(amount);
  //   });
  // }

//Deletes all the savings transactions associated to a certail user.
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

  ///changes the status of a goal
  Future<void> changeLocalSavingsStatus(String id, String status) async {
    return _isar!.writeTxn(() async {
      final goalBox = _isar!.savingsGoals;
      final goal = await goalBox.filter().idEqualTo(id).findFirst();
      if (goal != null) {
        goal.status = status;
        await goalBox.put(goal);
      }
    });
  }

  

  // Future<void> breakSavings(String id, double amount) async {
  //   await removeFromSavingsBalance(amount, id);
  //   await removeFromUserTotalSavingsBalance(amount);
  //   await changeSavingsStatus(id, 'Terminated');
  //   await addToWalletBalance(amount, id);
  // }

  Future<bool> deleteLocalGoal(String id, double amount) async {
    //
    return _isar!.writeTxn(() async {
      final goalBox = _isar!.savingsGoals;
      final goal = await goalBox.filter().idEqualTo(id).findFirst();
      if (goal != null) {
        await goalBox.delete(goal.myId!);
        // await deleteAllTransactions(id);
        return true;
      } else {
        return false;
      }
    });
  }

  ///creates a new savings tranaction whena deposit is made to a specifcgoal.
  Future<void> createSavingsTransaction(SavingsTransaction transaction) async {
    return _isar!.writeTxn(() async {
      final transactionBox = _isar!.savingsTransactions;
      await transactionBox.put(transaction);
    });
  }

  ///Updates certain data of the goal.
  Future<void> updateLocalSavings(
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

  /// this is used to add a list of budget to isar
  Future<List<Budget>> populateBudget(List<Budget> budgets) async {
    return _isar!.writeTxn(() async {
      await _isar!.budgets.clear();
      await _isar!.budgets.putAll(budgets);
      return await _isar!.budgets.where().findAll();
    });
  }

  ///This method gets a list of budgets and returns it as a string
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

  /// This is used to add all expense transaction to the isar database
  Future<List<Expense>> populateExpensesTransaction(
      List<Expense> expenses) async {
    return _isar!.writeTxn(() async {
      await _isar!.expenses.clear();
      await _isar!.expenses.putAll(expenses);
      return await _isar!.expenses.where().findAll();
    });
  }

//fetches a list of expenses to be returned as a list
  Future<List<Expense>> fetchExpensesTransactions() async {
    return _isar!.writeTxn(() async {
      return _isar!.expenses.where().findAll();
    });
  }

//Adds a particular amount to a budget by its budget name.
  Future<void> addMoneyToBudget(double amount, String budgetname) async {
    return _isar!.writeTxn(() async {
      final myBudgets = _isar!.budgets;
      Budget? budget =
          myBudgets.filter().nameEqualTo(budgetname).findFirstSync();
      if (budget != null) {
        budget.currentAmount = amount + budget.currentAmount!;
        await myBudgets.put(budget);
      }
    });
  }
    Future<void> deleteAllExpenses() async {
    await _isar!.writeTxn(() async {
      await _isar!.expenses.clear();
    });
  }
    Future<void> deleteUser() async {
    await _isar!.writeTxn(() async {
      await _isar!.users.clear();
    });
  }
    Future<void> deleteSavingsGoals() async {
    await _isar!.writeTxn(() async {
      await _isar!.savingsGoals.clear();
    });
  }
    Future<void> deleteSavingstransactions() async {
    await _isar!.writeTxn(() async {
      await _isar!.savingsTransactions.clear();
    });
}
  Future<void> deleteBudgets() async {
    await _isar!.writeTxn(() async {
      await _isar!.budgets.clear();
    });
  }

}
