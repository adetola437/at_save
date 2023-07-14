import 'package:at_save/model/savings_transaction.dart';
import 'package:at_save/shared_preferences/session_manager.dart';
import 'package:cron/cron.dart';

import '../Database/local_database.dart';
import '../Database/remote_database.dart';
import '../model/budget.dart';
import '../model/expense.dart';
import '../model/savings_goal.dart';
import '../model/user.dart';

/// This is the class that interacts with the server and local database
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

  ///update the list of savings goal in the local database
  Future populateGoals(List<SavingsGoal> goals) =>
      localDatabase.populateGoals(goals);

///Updates the list of savings transactions in the local database
  Future populateSavingsTransactions(List<SavingsTransaction> transactions) =>
      localDatabase.populateSavingsTransaction(transactions);

///Updates the list of budgets in the local database
  Future<List<Budget>> populateBudgets(List<Budget> budgets) async {
    return await localDatabase.populateBudget(budgets);
  }

  //Create a new saving goal and saves it to firebase
  Future<bool> createGoal(SavingsGoal goal) async {
    return await remoteDatabase.saveGoal(goal);
  }

///creates a lsavings goal in the local database
  Future createLocalGoal(SavingsGoal goal) async {
    return await localDatabase.saveGoal(goal);
  }

  //Fetch all user goals from the server\
  Future<List<SavingsGoal>> getGoals() async {
    return await remoteDatabase.getGoals();
  }

//fetches all the savings goal in the local database
  Future<List<SavingsGoal>> getLocalGoals() async {
    return await localDatabase.fetchGoals();
  }

//gets all the savings transactions by id from the firebase
  Future<List<SavingsTransaction>> getTransactions() async {
    return await remoteDatabase.getSavingsTransactions();
  }

//gets all of teh savings transactions in the local database
  Future<List<SavingsTransaction>> getLocalTransactions() async {
    return await localDatabase.fetchTransactions();
  }

//gets the list of budget expenses from the local database
  Future<List<Expense>> getLocalExpenses() async {
    return await localDatabase.fetchExpensesTransactions();
  }

//uodates the list of expense transactions in the local databse
  Future populateExpensesTransactions(List<Expense> expenses) async {
    await localDatabase.populateExpensesTransaction(expenses);
  }

//creates an expense transaction and saves it to firebase
  Future createExpenses(Expense expense) async {
    await remoteDatabase.createExpensesTransaction(expense);
  }

///gets the list of expense transaction from firebase
  Future<List<Expense>> getRemoteExpense() async {
    return await remoteDatabase.getExpensesTransactions();
  }

/// 
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

/// This is the method that checks each goal transaction and sends a push notificatiom
  void checkTargetDatesAndSendNotifications() async {
    String? token = await manager.getMessagingToken();
    final savings = await localDatabase
        .fetchGoals(); // Replace with your actual method to get savings goals from Isar database

    final currentDate = DateTime.now();

    for (final goal in savings) {
      if (currentDate.isAfter(goal.targetDate) &&
          goal.currentAmount < goal.targetAmount) {
        remoteDatabase.sendPushNotification(token!, 'Target Date Reached',
            'Your target date for ${goal.title} has reached.');
      }
    }
  }

  /// Method to trigger daily schedule
  void scheduleSavingsNotifications() {
  final cron = Cron();

  // Schedule the task to run daily at a specific time (e.g., 9:00 AM)
  cron.schedule(Schedule.parse('0 9 * * *'), () {
    checkTargetDatesAndSendNotifications();
  });
}

}
