import 'dart:developer';

import 'package:at_save/model/savings_goal.dart';
import 'package:at_save/shared_preferences/session_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

      await addToUserBalance(goal.currentAmount);

      var addGoalId = snapshot.doc(docRef.id);
      await addGoalId.update({'id': docRef.id});

      print('Transaction saved successfully!');
    } catch (error) {
      print('Error saving transaction: $error');
    }
  }

  Future addToUserBalance(double amount) async {
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
    log(id);
    String? uid = await manager.getUid();
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
      double savingsBalance = savingsData['current_amount'].toDouble();
      double currentAmount = userBalance + amount;
      double currentSavings = savingsBalance + amount;
      print(currentAmount);

      await userRef.update({'current_amount': currentSavings});
      await userSnapshot.update({'savings_balance': currentAmount});
    }
  }
}
