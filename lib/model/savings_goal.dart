import 'package:isar/isar.dart';
part 'savings_goal.g.dart';
@Collection()
class SavingsGoal {
   Id? myId;
   String id;
   String title;
 double targetAmount;
   DateTime targetDate;
   String description;
  double currentAmount;

  SavingsGoal({
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
      id: json['id'],
      title: json['title'],
      targetAmount: json['target_amount'],
      targetDate: DateTime.parse(json['target_date']),
      description: json['description'],
      currentAmount: json['currentAmount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'target_amount': targetAmount,
      'target_date': targetDate.toIso8601String(),
      'description': description,
      'current_amount': currentAmount,
    };
  }
}
