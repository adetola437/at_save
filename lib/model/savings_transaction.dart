
import 'package:isar/isar.dart';
part 'savings_transaction.g.dart';
@Collection()
class SavingsTransaction {
   Id? myId;  //isar auto id
   String id;  //Unique id for the goal from firebase
   double amount;  //amount added to the savings
   DateTime date;  //target date of the savings
   String note; //description of the savings trasnaction
   String savingsGoalId;  //unique id of the goal attributed to this transaction

  SavingsTransaction({
    this.myId,
    required this.id,
    required this.amount,
    required this.date,
    required this.note,
    required this.savingsGoalId,
  });

  factory SavingsTransaction.fromJson(Map<String, dynamic> json) {
    return SavingsTransaction(
      id: json['id'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      note: json['note'],
      savingsGoalId: json['savingsGoalId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'date': date.toIso8601String(),
      'note': note,
      'savingsGoalId': savingsGoalId,
    };
  }
}
