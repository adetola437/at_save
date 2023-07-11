import 'dart:convert';
import 'dart:developer';

import 'package:at_save/model/savings_goal.dart';
import 'package:at_save/shared_preferences/session_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../model/budget.dart';
import '../model/expense.dart';
import '../model/savings_transaction.dart';
import '../model/user.dart';

class RemoteDatabase {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  SessionManager manager = SessionManager();
//Get the current logged in user
  Future<User> getUser() async {
    String? userId = await manager.getUid();
    try {
      DocumentSnapshot document = await usersCollection.doc(userId).get();
      if (document.exists) {
        // Convert Firestore data to User object
        User user = User.fromJson(document.data() as Map<String, dynamic>);
        return user;
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('User not found');
    }
  }

//Create a new goal
  Future saveGoal(SavingsGoal goal) async {
    String? uid = await manager.getUid();
    try {
      final CollectionReference transactionCollection =
          FirebaseFirestore.instance.collection('goals');

      final CollectionReference snapshot = FirebaseFirestore.instance
          .collection('goals')
          .doc(uid)
          .collection('my_goals');

      final DocumentReference userDocument = transactionCollection.doc(uid);

      final CollectionReference userTransactionCollection =
          userDocument.collection('my_goals');

      final docRef = await userTransactionCollection.add(goal.toJson());

      await addToUserTotalSavingsBalance(goal.currentAmount);

      var addGoalId = snapshot.doc(docRef.id);
      await addGoalId.update({'id': docRef.id});
      await removeFromWalletBalance(goal.currentAmount);
      SavingsTransaction transaction = SavingsTransaction(
          id: '',
          amount: goal.currentAmount,
          date: DateTime.now(),
          note: 'Wallet Created',
          savingsGoalId: docRef.id);
      await createSavingsTransaction(transaction);

      print('Transaction saved successfully!');
    } catch (error) {
      print('Error saving transaction: $error');
    }
  }

  Future addToUserTotalSavingsBalance(double amount) async {
    try {
      String? uid = await manager.getUid();
      final userSnapshot =
          FirebaseFirestore.instance.collection('users').doc(uid);
      final snapshot = await userSnapshot.get();
      final senderData = snapshot.data();
      if (senderData != null) {
        double userBalance = senderData['savings_balance'].toDouble();
        double currentAmount = userBalance + amount;
        await userSnapshot.update({'savings_balance': currentAmount});
      }
    } catch (e) {
      print(e);
    }
  }

  Future removeFromUserTotalSavingsBalance(double amount) async {
    try {
      String? uid = await manager.getUid();
      final userSnapshot =
          FirebaseFirestore.instance.collection('users').doc(uid);
      final snapshot = await userSnapshot.get();
      final senderData = snapshot.data();
      if (senderData != null) {
        double userBalance = senderData['savings_balance'].toDouble();
        double currentAmount = userBalance - amount;
        await userSnapshot.update({'savings_balance': currentAmount});
      }
    } catch (e) {
      print(e);
    }
  }

//Method to add money to savings
  Future addToSavingsBalance(double amount, String id) async {
    try {
      String? uid = await manager.getUid();
      final userSnapshot = FirebaseFirestore.instance
          .collection('goals')
          .doc(uid)
          .collection('my_goals')
          .doc(id);
      final snapshot = await userSnapshot.get();
      final savingsData = snapshot.data();
      if (savingsData != null) {
        double userBalance = savingsData['current_amount'].toDouble();
        double currentAmount = userBalance + amount;
        await userSnapshot.update({'current_amount': currentAmount});
      }
    } catch (e) {
      print(e);
    }
  }

  Future removeFromSavingsBalance(double amount, String id) async {
    try {
      String? uid = await manager.getUid();
      final userSnapshot = FirebaseFirestore.instance
          .collection('goals')
          .doc(uid)
          .collection('my_goals')
          .doc(id);
      final snapshot = await userSnapshot.get();
      final savingsData = snapshot.data();
      if (savingsData != null) {
        print(savingsData.runtimeType);
        // print(savingsData['id']);
        double userBalance = savingsData['current_amount'].toDouble();

        double currentAmount = userBalance - amount;
        await userSnapshot.update({'current_amount': currentAmount});
      }
    } catch (e) {
      print(e);
    }
  }

  Future addToWalletBalance(double amount, String id) async {
    try {
      String? uid = await manager.getUid();
      final userSnapshot =
          FirebaseFirestore.instance.collection('users').doc(uid);
      final snapshot = await userSnapshot.get();
      final savingsData = snapshot.data();
      if (savingsData != null) {
        double userBalance = savingsData['wallet_balance'].toDouble();
        double currentAmount = userBalance + amount;
        await userSnapshot.update({'wallet_balance': currentAmount});
      }
    } catch (e) {
      print(e);
    }
  }

  Future removeFromWalletBalance(double amount) async {
    try {
      String? uid = await manager.getUid();
      final userSnapshot =
          FirebaseFirestore.instance.collection('users').doc(uid);
      final snapshot = await userSnapshot.get();
      final savingsData = snapshot.data();
      if (savingsData != null) {
        double userBalance = savingsData['wallet_balance'].toDouble();
        double currentAmount = userBalance - amount;
        await userSnapshot.update({'wallet_balance': currentAmount});
      }
    } catch (e) {
      print(e);
    }
  }

//Fetching the list goals
  Future<List<SavingsGoal>> getGoals() async {
    String? uid = await manager.getUid();
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('goals')
          .doc(uid)
          .collection('my_goals')
          .get();

      final List<SavingsGoal> goals = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>?;

        if (data != null) {
          return SavingsGoal.fromJson(data);
        } else {
          throw Exception('No data available for the document');
        }
      }).toList();
      return goals;
    } catch (e) {
      print(e);
      return [];
    }
  }

  //Add funds to savings
  Future addMoney(String id, double amount) async {
    // log(id);
    String? uid = await manager.getUid();
    String? token = await manager.getMessagingToken();
    final userRef = FirebaseFirestore.instance
        .collection('goals')
        .doc(uid)
        .collection('my_goals')
        .doc(id);
    final userSnapshot =
        FirebaseFirestore.instance.collection('users').doc(uid);

    final snapshot = await userSnapshot.get();
    final savingsSnapshot = await userRef.get();
    final senderData = snapshot.data();
    final savingsData = savingsSnapshot.data();
    if (senderData != null && savingsData != null) {
      double userBalance = senderData['savings_balance'].toDouble();
      double userTargetBlanace = savingsData['target_amount'].toDouble();
      double savingsBalance = savingsData['current_amount'].toDouble();
      String title = savingsData['title'];
      double currentAmount = userBalance + amount;

      if (currentAmount >= userTargetBlanace) {
        changeSavingsStatus(id, 'Completed');
        sendPushNotification(token!, 'Congratulations!!!',
            'You have Successfully completed your savings for $title');
      }

      double currentSavings = savingsBalance + amount;
      print(currentAmount);

      await userRef.update({'current_amount': currentSavings});
      await userSnapshot.update({'savings_balance': currentAmount});
      await removeFromWalletBalance(amount);
    }
  }

  Future deleteAllTransactions(String id) async {
    String? uid = await manager.getUid();
    try {
      final QuerySnapshot query = await FirebaseFirestore.instance
          .collection('transactions')
          .doc(uid)
          .collection('savings_transactions')
          .where('savingsGoalId', isEqualTo: id)
          .get();
      for (final doc in query.docs) {
        await doc.reference.delete();
      }
    } catch (e) {}
  }

  Future changeSavingsStatus(String id, String status) async {
    try {
      String? uid = await manager.getUid();
      final userSnapshot = FirebaseFirestore.instance
          .collection('goals')
          .doc(uid)
          .collection('my_goals')
          .doc(id);

      await userSnapshot.update({'status': status});
    } catch (e) {
      print(e);
    }
  }

  Future breakSavings(String id, double amount) async {
    try {
      await removeFromSavingsBalance(amount, id);
      await removeFromUserTotalSavingsBalance(amount);
      changeSavingsStatus(id, 'Terminated');
      await addToWalletBalance(amount, id);
    } catch (e) {
      print(e);
    }
  }

  Future deleteGoal(String id, double amount) async {
    try {
      await breakSavings(id, amount);
      String? uid = await manager.getUid();
      final DocumentReference goalRef = FirebaseFirestore.instance
          .collection('goals')
          .doc(uid)
          .collection('my_goals')
          .doc(id);

      await goalRef.delete();
      await deleteAllTransactions(id);
      print('Goal deleted successfully!');
    } catch (e) {
      print('Error Deleting goal');
    }
  }

  Future createSavingsTransaction(
    SavingsTransaction transaction,
  ) async {
    String? uid = await manager.getUid();

    try {
      final CollectionReference transactionCollection =
          FirebaseFirestore.instance.collection('transactions');

      final CollectionReference snapshot = FirebaseFirestore.instance
          .collection('transactions')
          .doc(uid)
          .collection('savings_transactions');

      final DocumentReference userDocument = transactionCollection.doc(uid);

      final CollectionReference userTransactionCollection =
          userDocument.collection('savings_transactions');

      final docRef = await userTransactionCollection.add(transaction.toJson());

      var addTransactionId = snapshot.doc(docRef.id);
      await addTransactionId.update({'id': docRef.id});

      print('Transaction saved successfully!');
    } catch (error) {
      print('Error saving transaction: $error');
    }
  }

  Future<List<SavingsTransaction>> getSavingsTransactions() async {
    String? uid = await manager.getUid();
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('transactions')
          .doc(uid)
          .collection('savings_transactions')
          .get();

      final List<SavingsTransaction> transactions = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>?;

        if (data != null) {
          return SavingsTransaction.fromJson(data);
        } else {
          throw Exception('No data available for the document');
        }
      }).toList();
      return transactions;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future updateSavings(String id, String title, String description,
      double targetAmount, DateTime date) async {
    try {
      String? uid = await manager.getUid();
      final userSnapshot = FirebaseFirestore.instance
          .collection('goals')
          .doc(uid)
          .collection('my_goals')
          .doc(id);

      await userSnapshot.update({
        'title': title,
        'description': description,
        'target_amount': targetAmount,
        'target_date': formatDateToString(date)
      });
    } catch (e) {
      print(e);
    }
  }

  String formatDateToString(DateTime dateTime) {
    DateFormat dateFormat = DateFormat("dd MMMM yyyy");
    return dateFormat.format(dateTime);
  }

  Future createBudget(Budget budget) async {
    String? uid = await manager.getUid();
    print('creating');
    try {
      final CollectionReference reference =
          FirebaseFirestore.instance.collection('budgets');
      await reference
          .doc(uid)
          .collection('my_budgets')
          .doc(budget.name)
          .set(budget.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<List<Budget>> getBudgets() async {
    String? uid = await manager.getUid();
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('budgets')
          .doc(uid)
          .collection('my_budgets')
          .get();

      final List<Budget> budgets = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>?;
        if (data != null) {
          return Budget.fromJson(data);
        } else {
          throw Exception('No data available for the document');
        }
      }).toList();
      // log(budgets.toString(), name: 'data budget');

      return budgets;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future createExpensesTransaction(
    Expense expense,
  ) async {
    String? uid = await manager.getUid();

    try {
      final CollectionReference transactionCollection =
          FirebaseFirestore.instance.collection('transactions');

      final CollectionReference snapshot = FirebaseFirestore.instance
          .collection('transactions')
          .doc(uid)
          .collection('expenses_transactions');

      final DocumentReference userDocument = transactionCollection.doc(uid);

      final CollectionReference userTransactionCollection =
          userDocument.collection('expenses_transactions');

      final docRef = await userTransactionCollection.add(expense.toJson());

      var addTransactionId = snapshot.doc(docRef.id);
      await addTransactionId.update({'id': docRef.id});

      if (expense.transactionType == 'withdraw') {
        await removeFromWalletBalance(expense.amount);
        await addMoneyToBudget(expense.amount, expense.category);
      } else {
        await addToWalletBalance(expense.amount, '');
      }

      print('Expense saved successfully!');
    } catch (error) {
      print('Error saving transaction: $error');
    }
  }

  Future<List<Expense>> getExpensesTransactions() async {
    String? uid = await manager.getUid();
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('transactions')
          .doc(uid)
          .collection('expenses_transactions')
          .get();

      final List<Expense> transactions = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>?;

        if (data != null) {
          return Expense.fromJson(data);
        } else {
          throw Exception('No data available for the document');
        }
      }).toList();
      return transactions;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future addMoneyToBudget(double amount, String budgetName) async {
    // log(id);
    String? uid = await manager.getUid();
    try {
      final userRef = FirebaseFirestore.instance
          .collection('budgets')
          .doc(uid)
          .collection('my_budgets')
          .doc(budgetName);

      final savingsSnapshot = await userRef.get();

      final savingsData = savingsSnapshot.data();
      if (savingsData != null) {
        double budgetBalance = savingsData['currentAmount'].toDouble();

        double currentBalance = budgetBalance + amount;

        await userRef.update({'currentAmount': currentBalance});
      }
    } catch (e) {}
  }

  Future<void> sendPushNotification(
      String deviceToken, String title, String body) async {
    const url =
        'https://fcm.googleapis.com/v1/projects/atsave-29469/messages:send';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ya29.a0AbVbY6O5hRbnF1yTuhbYcTIQhTIkiVCHkJ3dYcYcJo7WSf2PC9YBSyL_nDvH3bwjgG-acF-ZEur1UDOypz7ivHZborDSOeOsmwVul7PT_IOTrbhhYF5iA64ag30k33Kaax1Inv80Cte1msnEIQjw1WqPHe2XZMkaCgYKASoSARASFQFWKvPlqOfeBLNY530lNo82hSae9A0166',
    };

    final message = {
      'message': {
        'token': deviceToken,
        'notification': {
          'title': title,
          'body': body,
        },
      },
    };

    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(message));

    if (response.statusCode == 200) {
      print('Push notification sent successfully.');
    } else {
      print('Failed to send push notification. Error: ${response.body}');
    }
  }

// ...

// Future<void> sendPushNotification(
//   String deviceToken,
//   String title,
//   String body,
// ) async {
//   final refreshToken = 'your-refresh-token';
//   final clientId = 'your-client-id';
//   final clientSecret = 'your-client-secret';

//   final interceptor = TokenRefreshInterceptor(
//     refreshToken: refreshToken,
//     clientId: clientId,
//     clientSecret: clientSecret,
//   );

//   final client = InterceptedClient.build(interceptors: [interceptor]);

//   const url = 'https://fcm.googleapis.com/v1/projects/bankpick-1a20b/messages:send';

//   final headers = {
//     'Content-Type': 'application/json',
//     'Authorization': 'Bearer your-access-token',
//   };

//   final message = {
//     'message': {
//       'token': deviceToken,
//       'notification': {
//         'title': title,
//         'body': body,
//       },
//     },
//   };

//   final response = await client.post(Uri.parse(url), headers: headers, body: jsonEncode(message));

//   if (response.statusCode == 200) {
//     print('Push notification sent successfully.');
//   } else {
//     print('Failed to send push notification. Error: ${response.body}');
//   }
// }
}
