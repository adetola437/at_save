part of 'expense_transaction_bloc.dart';

abstract class ExpenseTransactionEvent extends Equatable {
  const ExpenseTransactionEvent();

  @override
  List<Object> get props => [];
}

class CreateExpenseTransaction extends ExpenseTransactionEvent {
  String id;  
  String category;  
  double amount;
  DateTime date;
  String transactionType;
  String description;
  CreateExpenseTransaction(
      {required this.amount,
      required this.category,
      required this.description,
      required this.date,
      required this.id,
      required this.transactionType});

  @override
  List<Object> get props => [];
}

class FetchExpenseTransaction extends ExpenseTransactionEvent {}
