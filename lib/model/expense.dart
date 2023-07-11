import 'package:isar/isar.dart';

part 'expense.g.dart';

@Collection()
class Expense {
  Id? myId;
  String id;
  String category;
  double amount;
  DateTime date;
  String description;
  String transactionType;

  Expense({
    required this.description,
    this.myId,
    required this.id,
    required this.category,
    required this.amount,
    required this.date,
    required this.transactionType,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      description: json['description'],
      id: json['id'],
      category: json['category'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      transactionType: json['transactionType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description':description,
      'id': id,
      'category': category,
      'amount': amount,
      'date': date.toIso8601String(),
      'transactionType': transactionType,
    };
  }
}
