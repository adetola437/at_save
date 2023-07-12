part of 'goals_bloc.dart';

abstract class GoalsState extends Equatable {
  const GoalsState();

  @override
  List<Object> get props => [];
}

class GoalsInitial extends GoalsState {}

class GoalsLoading extends GoalsState {}

class GoalsLoaded extends GoalsState {
  List<SavingsGoal> goals;
  GoalsLoaded({required this.goals});

  @override
  List<Object> get props => [];
}

class GoalsLoadingError extends GoalsState {}

class GoalDeleted extends GoalsState {}

class GoalEdited extends GoalsState {}

class GoalBroken extends GoalsState {}

class GoalTopUp extends GoalsState {}
