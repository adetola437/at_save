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
    required this.description,  //description of the transaction made
    this.myId,  //isar unique id
    required this.id,  //unique id gotten from firebase
    required this.category, //bedget category for withdrawal
    required this.amount, //amount to be withdrawn
    required this.date, //date od withdrawal
    required this.transactionType,   //type of transaction,
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
