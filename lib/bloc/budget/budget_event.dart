part of 'budget_bloc.dart';

abstract class BudgetEvent extends Equatable {
  const BudgetEvent();

  @override
  List<Object> get props => [];
}

class CreateBudgetEvent extends BudgetEvent {
  String budgetName;
  double budgetAmount;
  int color;
   CreateBudgetEvent({
    required this.budgetAmount, required this.budgetName, required this.color
  });

  @override
  List<Object> get props => [];
}

class FetchBudgetEvent extends BudgetEvent{}
