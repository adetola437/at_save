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
      SavingsTransactionSchema
    ],
        // name: currentUser.toString(),
        directory: (await getApplicationSupportDirectory()).path);
  }


}
