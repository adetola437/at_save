import 'package:at_save/model/savings_transaction.dart';
import 'package:at_save/shared_preferences/session_manager.dart';

import '../Database/local_database.dart';
import '../Database/remote_database.dart';
import '../model/budget.dart';
import '../model/expense.dart';
import '../model/savings_goal.dart';
import '../model/user.dart';

class Repository {
  //Get the instance of the dB
  final LocalDatabase localDatabase = LocalDatabase();
  final RemoteDatabase remoteDatabase = RemoteDatabase();
  final SessionManager manager = SessionManager();
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
  Future<bool> createGoal(SavingsGoal goal) async {
    return await remoteDatabase.saveGoal(goal);
  }

  Future createLocalGoal(SavingsGoal goal) async {
    return await localDatabase.saveGoal(goal);
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
    // print('repo delete');
    await remoteDatabase.deleteGoal(id, amount);
  }

  Future createTransaction(SavingsTransaction transaction) async {
    await remoteDatabase.createSavingsTransaction(transaction);
  }

  Future<bool> updateSavingsGoal(String id, String description, String title,
      double targetAmount, DateTime date) async {
    return await remoteDatabase.updateSavings(
        id, title, description, targetAmount, date);
  }

  Future createBudget(Budget budget) async {
    await remoteDatabase.createBudget(budget);
  }

  Future createLocalBudget(Budget budget) async {
    await localDatabase.createBudget(budget);
  }

  Future addMoneyToBudget(String budgetName, double amount) async {
    await remoteDatabase.addMoneyToBudget(amount, budgetName);
  }

  Future addMoneyToLocalBudget(String budgetName, double amount) async {
    await localDatabase.addMoneyToBudget(amount, budgetName);
  }

  Future updateLocalGoal(String id, String title, String description,
      double targetAmount, DateTime date) async {
    await localDatabase.updateLocalSavings(
        id, title, description, targetAmount, date);
  }

  Future addToLocalGoal(String id, double amount) async {
    await localDatabase.addToLocalSavingsBalance(id, amount);
  }

  Future removeFromLocalWallet(double amount) async {
    await localDatabase.removeFromLocalWalletBalance(amount);
  }

  Future<bool> deleteLocalGoal(String id, double amount) async {
    return await localDatabase.deleteLocalGoal(id, amount);
  }

  Future addToLocalWalletbalance(double amount) async {
    await localDatabase.addToLocalWalletBalance(amount);
  }

  Future changeLocalStatus(String id, String status) async {
    await localDatabase.changeLocalSavingsStatus(id, status);
  }

  Future removeFromLocalSavings(double amount, String id) async {
    await localDatabase.removeFromLocalSavingsBalance(amount, id);
  }

  Future signOut() async {
    await localDatabase.deleteAllExpenses();
    await localDatabase.deleteUser();
    await localDatabase.deleteBudgets();
    await localDatabase.deleteSavingsGoals();
    await localDatabase.deleteSavingstransactions();
  
    //await manager.clearSharedPreferences();
  }
}
