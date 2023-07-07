import 'package:isar/isar.dart';

part 'savings_goal.g.dart';

@Collection()
class SavingsGoal {
  Id? myId;
  String id;
  String status;
  String title;
  double targetAmount;
  DateTime targetDate;
  DateTime createdDate;
  String description;
  double currentAmount;

  SavingsGoal({
    this.status='Active',
    required this.createdDate,
    this.myId,
    required this.id,
    required this.title,
    required this.targetAmount,
    required this.targetDate,
    required this.description,
    this.currentAmount = 0,
  });

  factory SavingsGoal.fromJson(Map<String, dynamic> json) {
    return SavingsGoal(
      status: json['status'],
      createdDate: DateTime.parse(json['created_date']),
      id: json['id'],
      title: json['title'],
      targetAmount: json['target_amount'] != null
          ? json['target_amount'].toDouble()
          : null,
      targetDate: DateTime.parse(json['target_date']),
      description: json['description'],
      currentAmount: json['current_amount'] != null
          ? json['current_amount'].toDouble()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'id': id,
      'title': title,
      'target_amount': targetAmount,
      'target_date': targetDate.toIso8601String(),
      'description': description,
      'current_amount': currentAmount,
      'created_date': createdDate.toIso8601String()
    };
  }
}
