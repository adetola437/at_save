part of 'budget_bloc.dart';

abstract class BudgetState extends Equatable {
  const BudgetState();

  @override
  List<Object> get props => [];
}

class BudgetInitial extends BudgetState {}

class BudgetLoading extends BudgetState {}

class BudgetCreated extends BudgetState {}

class BudgetLoaded extends BudgetState {
  List<Budget> budget;
  BudgetLoaded({required this.budget});

  @override
  List<Object> get props => [];
}
