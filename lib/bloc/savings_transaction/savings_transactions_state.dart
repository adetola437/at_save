part of 'savings_transactions_bloc.dart';

abstract class SavingsTransactionsState extends Equatable {
  const SavingsTransactionsState();

  @override
  List<Object> get props => [];
}

class SavingsTransactionsInitial extends SavingsTransactionsState {}

class SavingsTransactionsLoading extends SavingsTransactionsState {}

class SavingsTransactionsLoaded extends SavingsTransactionsState {
  List<SavingsTransaction> transactions;
   SavingsTransactionsLoaded({required this.transactions});

  @override
  List<Object> get props => [];
}

class SavingsTransactionsError extends SavingsTransactionsState {}
