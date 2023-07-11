import 'package:at_save/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/savings_transaction.dart';

part 'savings_transactions_event.dart';
part 'savings_transactions_state.dart';

class SavingsTransactionsBloc
    extends Bloc<SavingsTransactionsEvent, SavingsTransactionsState> {
  SavingsTransactionsBloc() : super(SavingsTransactionsInitial()) {
    on<SavingsTransactionsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<CreateSavingsTransactionEvent>(
      (event, emit) => _createTransaction(event, emit),
    );
    on<FetchSavingsTransactions>(
      (event, emit) => _fetchTransactions(event, emit),
    );
  }

  _fetchTransactions(FetchSavingsTransactions event, emit) async {
    emit(SavingsTransactionsLoading());
    Repository repo = Repository();
    List<SavingsTransaction> localTransactions =
        await repo.getLocalTransactions();
    try {
      final List<SavingsTransaction> remoteTransactions =
          await repo.getTransactions();

      if (localTransactions != remoteTransactions) {
        await repo.populateSavingsTransactions(remoteTransactions);
      }
      localTransactions = await repo.getLocalTransactions();

      emit(SavingsTransactionsLoaded(transactions: localTransactions));
    } on Exception {
      emit(SavingsTransactionsError());
    }
  }

  _createTransaction(CreateSavingsTransactionEvent event, emit) async {
    emit(SavingsTransactionsLoading());
    Repository repo = Repository();

    try {
      repo.createTransaction(event.transaction);

      List<SavingsTransaction> localTransactions =
          await repo.getLocalTransactions();

      final List<SavingsTransaction> remoteTransactions =
          await repo.getTransactions();

      if (localTransactions != remoteTransactions) {
        await repo.populateSavingsTransactions(remoteTransactions);
      }
      localTransactions = await repo.getTransactions();

      emit(SavingsTransactionsLoaded(transactions: localTransactions));
    } catch (e) {
      print(e);
    }
  }
}
