part of 'expense_transaction_bloc.dart';

abstract class ExpenseTransactionState extends Equatable {
  const ExpenseTransactionState();

  @override
  List<Object> get props => [];
}

class ExpenseTransactionInitial extends ExpenseTransactionState {}

class ExpenseTransactionLoading extends ExpenseTransactionState {}

class ExpenseTransactionError extends ExpenseTransactionState {}
class ExpensedepositError extends ExpenseTransactionState {}
class ExpenseWithdrawError extends ExpenseTransactionState {}
class ExpenseTransactionCreated extends ExpenseTransactionState {}

class ExpenseTransactionLoaded extends ExpenseTransactionState {
  List<Expense> expenses;
   ExpenseTransactionLoaded({required this.expenses});

  @override
  List<Object> get props => [];
}
