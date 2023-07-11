import 'package:at_save/model/savings_transaction.dart';

import 'Database/local_database.dart';
import 'Database/remote_database.dart';
import 'model/budget.dart';
import 'model/expense.dart';
import 'model/savings_goal.dart';
import 'model/user.dart';

class Repository {
  //Get the instance of the dB
  final LocalDatabase localDatabase = LocalDatabase();
  final RemoteDatabase remoteDatabase = RemoteDatabase();
//GET THE USERS FROM FIREBASE AND ISAR TO COMPARE
  Future<User?> localUsers() => localDatabase.fetchUser();
  Future<User> remoteUsers() => remoteDatabase.getUser();

  //Compares firebase data with local and updates the local db
  Future populateUser(User user) => localDatabase.populateUser(user);
  Future populateGoals(List<SavingsGoal> goals) =>
      localDatabase.populateGoals(goals);

  Future populateSavingsTransactions(List<SavingsTransaction> transactions) =>
      localDatabase.populateSavingsTransaction(transactions);

  Future<List<Budget>> populateBudgets(List<Budget> budgets) async {
    return await localDatabase.populateBudget(budgets);
  }

  //Create a new saving goal
  Future createGoal(SavingsGoal goal) async {
    return await remoteDatabase.saveGoal(goal);
  }

  //Fetch all user goals from the server\
  Future<List<SavingsGoal>> getGoals() async {
    return await remoteDatabase.getGoals();
  }

  Future<List<SavingsGoal>> getLocalGoals() async {
    return await localDatabase.fetchGoals();
  }

  Future<List<SavingsTransaction>> getTransactions() async {
    return await remoteDatabase.getSavingsTransactions();
  }

  Future<List<SavingsTransaction>> getLocalTransactions() async {
    return await localDatabase.fetchTransactions();
  }

  Future<List<Expense>> getLocalExpenses() async {
    return await localDatabase.fetchExpensesTransactions();
  }

  Future populateExpensesTransactions(List<Expense> expenses) async {
    await localDatabase.populateExpensesTransaction(expenses);
  }

  Future createExpenses(Expense expense) async {
    await remoteDatabase.createExpensesTransaction(expense);
  }

  Future<List<Expense>> getRemoteExpense() async {
    return await remoteDatabase.getExpensesTransactions();
  }

  Future<List<Budget>> getLocalBudgets() async {
    return await localDatabase.fetchBudgets();
  }

  Future<List<Budget>> getRemoteBudgets() async {
    return await remoteDatabase.getBudgets();
  }

  //Add money to savings account
  Future addToSavings(String id, double amount) async {
    await remoteDatabase.addMoney(id, amount);
  }

  Future breakSavings(String id, double amount) async {
    await remoteDatabase.breakSavings(id, amount);
  }

  Future deleteGoal(String id, double amount) async {
    print('repo delete');
    await remoteDatabase.deleteGoal(id, amount);
  }

  Future createTransaction(SavingsTransaction transaction) async {
    await remoteDatabase.createSavingsTransaction(transaction);
  }

  Future updateSavingsGoal(String id, String description, String title,
      double targetAmount, DateTime date) async {
    await remoteDatabase.updateSavings(
        id, title, description, targetAmount, date);
  }

  Future createBudget(Budget budget) async {
    await remoteDatabase.createBudget(budget);
  }

  Future addMoneyToBudget(String budgetName, double amount) async {
    await remoteDatabase.addMoneyToBudget(amount, budgetName);
  }

  Future addMoneyToLocalBudget(String budgetName, double amount) async {
    await localDatabase.addMoneyToBudget(amount, budgetName);
  }
}
