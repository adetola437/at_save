import 'package:isar/isar.dart';

part 'expense.g.dart';
@Collection()
class Expense {
   Id? myId;
   String id;
  String category;
   double amount;
   DateTime date;
   String userId;

  Expense({
    this.myId,
    required this.id,
    required this.category,
    required this.amount,
    required this.date,
    required this.userId,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      category: json['category'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'amount': amount,
      'date': date.toIso8601String(),
      'userId': userId,
    };
  }
}
