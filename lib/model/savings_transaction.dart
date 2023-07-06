
import 'package:isar/isar.dart';
part 'savings_transaction.g.dart';
@Collection()
class SavingsTransaction {
   Id? myId;
   String id;
   double amount;
   DateTime date;
   String note;
   String savingsGoalId;

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
