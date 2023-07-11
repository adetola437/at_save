import 'package:isar/isar.dart';

part 'budget.g.dart';

@Collection()
class Budget {
  Id? myId;
  String name;
  double amount;
  double? currentAmount;
  int color;

  Budget({
    required this.name,
    required this.amount,
    this.currentAmount = 0,
    required this.color,
  });

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
      name: json['name'],
      amount: json['amount'] != null ? json['amount'].toDouble() : null,
      currentAmount: json['currentAmount'] != null
          ? json['currentAmount'].toDouble()
          : null,
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': amount,
      'currentAmount': currentAmount,
      'color': color,
    };
  }
}
