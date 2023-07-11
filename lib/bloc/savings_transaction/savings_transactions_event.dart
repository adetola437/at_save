part of 'savings_transactions_bloc.dart';

abstract class SavingsTransactionsEvent extends Equatable {
  const SavingsTransactionsEvent();

  @override
  List<Object> get props => [];
}

class CreateSavingsTransactionEvent extends SavingsTransactionsEvent {
  SavingsTransaction transaction;
   CreateSavingsTransactionEvent({required this.transaction});

  @override
  List<Object> get props => [];
}
class FetchSavingsTransactions extends SavingsTransactionsEvent{}
