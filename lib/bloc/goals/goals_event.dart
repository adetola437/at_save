part of 'goals_bloc.dart';

abstract class GoalsEvent extends Equatable {
  const GoalsEvent();

  @override
  List<Object> get props => [];
}

class GetGoalsEvent extends GoalsEvent {}

class AddMoneyToSavingsEvent extends GoalsEvent {
  String id;
  double amount;
  AddMoneyToSavingsEvent({required this.amount, required this.id});

  @override
  List<Object> get props => [];
}

class BreakSavingsEvent extends GoalsEvent {
  final String id;
  final double amount;
  const BreakSavingsEvent({required this.amount, required this.id});

  @override
  List<Object> get props => [];
}

class DeleteEvent extends GoalsEvent {
  final String id;
  final double amount;
  const DeleteEvent({required this.amount, required this.id});

  @override
  List<Object> get props => [];
}

class UpdateGoalEvent extends GoalsEvent {
  final String goalName;
  final double targetAmount;
  final DateTime date;
  final String description;
  final String golaId;
  const UpdateGoalEvent(
      {required this.targetAmount,
      required this.goalName,
      required this.golaId,
      required this.date,
      required this.description});

  @override
  List<Object> get props => [];
}
