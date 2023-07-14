import 'package:at_save/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

import '../../model/budget.dart';

part 'budget_event.dart';
part 'budget_state.dart';

///This bloc holds information about the expense budgets
class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  BudgetBloc() : super(BudgetInitial()) {
    on<BudgetEvent>((event, emit) {
      // TODO: implement event handler
    });

    ///This is where the Create event is trigered
    on<CreateBudgetEvent>(
      (event, emit) => _createBudget(event, emit),
    );

    ///The FetchBudgetEvent triggers getting all the list of budgets.
    on<FetchBudgetEvent>(
      (event, emit) => _fetchBudget(event, emit),
    );
  }

  ///Here is the method used to implement the fetchbudget event
  _fetchBudget(FetchBudgetEvent event, emit) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    Repository repo = Repository(); //creating am instance of the repository
    emit(BudgetLoading());

    try {
      List<Budget> localBudgets = await repo.getLocalBudgets();
      if (connectivityResult == ConnectivityResult.none) {
        print('loacl budg');
        emit(BudgetLoaded(budget: localBudgets));
      } else if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        final List<Budget> remoteBudgets = await repo.getRemoteBudgets();
        if (localBudgets != remoteBudgets) {
          localBudgets = await repo.populateBudgets(remoteBudgets);
        }
        localBudgets = await repo.getLocalBudgets();
        emit(BudgetLoaded(budget: localBudgets));
      } else {
        print('error Loading budget');
        emit(BudgetLoadingError());
      }
    } catch (e) {
      emit(BudgetLoadingError());
    }
    // try {
    //Getting the budgets in local storage
    //log(localBudgets.toString(), name: 'local budget');

    //Comparing both the online and local storage data

    // } catch (e) {
    //   print(e);
    // }
  }

  ///Here is the method used to implement the create budget event
  _createBudget(CreateBudgetEvent event, emit) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    emit(BudgetLoading());
    Repository repo = Repository();
    Budget budget = Budget(
        name: event.budgetName,
        amount: event.budgetAmount,
        color: event.color); //Creating a budget object
    try {
      if (connectivityResult == ConnectivityResult.none) {
        await repo.createLocalBudget(budget);
        repo.createBudget(budget); //passing the object to the repository

        List<Budget> localBudgets = await repo.getLocalBudgets();
        print('local budgets used');
        emit(BudgetLoaded(budget: localBudgets));
      } else if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        await repo.createLocalBudget(budget);
        await repo.createBudget(budget); //passing the object to the repository

        List<Budget> localBudgets = await repo.getLocalBudgets();
        emit(BudgetLoaded(budget: localBudgets));
      }

      //  log(localBudgets.toString(), name: 'local budget');
      //  final List<Budget> remoteBudgets = await repo.getRemoteBudgets();
      // log(remoteBudgets.toString(), name: 'remote budget');
      // if (localBudgets != remoteBudgets) {
      //   localBudgets = await repo.populateBudgets(remoteBudgets);
      // }
      // localBudgets = await repo.getLocalBudgets();
    } catch (e) {
   
      emit(BudgetLoadingError());
      print(e);
    }
  }
}
