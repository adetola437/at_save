import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

import '../../model/expense.dart';
import '../../repository/repository.dart';

part 'expense_transaction_event.dart';
part 'expense_transaction_state.dart';

class ExpenseTransactionBloc
    extends Bloc<ExpenseTransactionEvent, ExpenseTransactionState> {
  ExpenseTransactionBloc() : super(ExpenseTransactionInitial()) {
    on<ExpenseTransactionEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<CreateExpenseTransaction>(
      (event, emit) => _createExpenseTransaction(event, emit),
    );

    on<FetchExpenseTransaction>(
      (event, emit) => _fetchExpenseTransactions(event, emit),
    );
  }
///Creates a new expense transaction
  _createExpenseTransaction(CreateExpenseTransaction event, emit) async {
    emit(ExpenseTransactionLoading());
    Repository repo = Repository();
    try {
      Expense expense = Expense(
          description: event.description,
          id: '',
          category: event.category,
          amount: event.amount,
          date: event.date,
          transactionType: event.transactionType);
      await repo.createExpenses(expense);

      emit(ExpenseTransactionCreated());
    } catch (e) {
      emit(ExpenseTransactionError());
    }
  }
///This method fetches the list of all expense transactions
  _fetchExpenseTransactions(FetchExpenseTransaction event, emit) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    emit(ExpenseTransactionLoading());
    Repository repo = Repository();
    List<Expense> localExpenses = await repo.getLocalExpenses();
    try {
      if (connectivityResult == ConnectivityResult.none) {
        emit(ExpenseTransactionLoaded(expenses: localExpenses));
      } else if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        final List<Expense> remoteExpenses = await repo.getRemoteExpense();

        if (localExpenses != remoteExpenses) {
          await repo.populateExpensesTransactions(remoteExpenses);
        }

        localExpenses = await repo.getLocalExpenses();

        emit(ExpenseTransactionLoaded(expenses: remoteExpenses));
      }
    } catch (e) {
      emit(ExpenseTransactionError());
    }
  }
}
