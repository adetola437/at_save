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
