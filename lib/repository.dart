import 'Database/local_database.dart';
import 'Database/remote_database.dart';
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

  //Create a new saving goal
  Future createGoal(SavingsGoal goal) async {
    return await remoteDatabase.saveGoal(goal);
  }

  //Fetch all user goals from the server\
  Future<List<SavingsGoal>> getGoals() async {
    return await remoteDatabase.getGoals();
  }

  //Add money to savings account
  Future addToSavings(String id, double amount) async {
    await remoteDatabase.addMoney(id, amount);
  }
}
