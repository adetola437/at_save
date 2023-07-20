import 'package:at_save/model/expense.dart';
import 'package:at_save/model/savings_goal.dart';
import 'package:at_save/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'goals_event.dart';
part 'goals_state.dart';

class GoalsBloc extends Bloc<GoalsEvent, GoalsState> {
  GoalsBloc() : super(GoalsInitial()) {
    on<GoalsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetGoalsEvent>(
      (event, emit) => _getGoals(event, emit),
    );

    on<AddMoneyToSavingsEvent>(
      (event, emit) => _addMoney(event, emit),
    );

    on<BreakSavingsEvent>(
      (event, emit) => _breakSavings(event, emit),
    );

    on<DeleteEvent>(
      (event, emit) => _deleteGoal(event, emit),
    );

    on<UpdateGoalEvent>(
      (event, emit) => _updateGoal(event, emit),
    );
  }

  _updateGoal(UpdateGoalEvent event, emit) async {
    emit(GoalsLoading());
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    Repository repo = Repository();
    try {
      if (isConnected == false) {
        await repo.updateLocalGoal(event.golaId, event.goalName,
            event.description, event.targetAmount, event.date);
        repo.updateSavingsGoal(event.golaId, event.goalName, event.description,
            event.targetAmount, event.date);
        emit(GoalEdited());
      } else {
        await repo.updateLocalGoal(event.golaId, event.goalName,
            event.description, event.targetAmount, event.date);
        await repo.updateSavingsGoal(event.golaId, event.goalName,
            event.description, event.targetAmount, event.date);

        emit(GoalEdited());
      }
    } catch (e) {
      emit(GoalEditError());
    }

    // emit(GoalsLoading());
    // Repository repo = Repository();
    // try {
    //   bool status = await repo.updateSavingsGoal(event.golaId,
    //       event.description, event.goalName, event.targetAmount, event.date);
    //   if (status == true) {
    //     emit(GoalEdited());
    //   } else {
    //     emit(GoalEditError());
    //   }

    // List<SavingsGoal> localGoals = await repo.getGoals();

    // final List<SavingsGoal> remoteGoals = await repo.getGoals();

    // if (localGoals != remoteGoals) {
    //   await repo.populateGoals(remoteGoals);
    // }
    // localGoals = await repo.getGoals();

    // emit(GoalsLoaded(goals: localGoals));

    // } catch (e) {
    //   emit(GoalEditError());
    //   print(e);
    // }
  }

  _breakSavings(BreakSavingsEvent event, emit) async {
    emit(GoalsLoading());
    Expense expense = Expense(
        description: 'Savings Withdrawal',
        id: '',
        category: 'Savings break',
        amount: event.amount,
        date: DateTime.now(),
        transactionType: 'credit');
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    Repository repo = Repository();
    try {
      if (isConnected == false) {
        await repo.changeLocalStatus(event.id, event.status!);
        await repo.removeFromLocalSavings(event.amount, event.id);
        await repo.addToLocalWalletbalance(event.amount);
        repo.breakSavings(event.id, event.amount);
        emit(GoalBroken());
      } else {
        await repo.changeLocalStatus(event.id, event.status!);
        await repo.removeFromLocalSavings(event.amount, event.id);
        await repo.addToLocalWalletbalance(event.amount);
        await repo.breakSavings(event.id, event.amount);
        await repo.createExpenses(expense);

        emit(GoalBroken());
      }
    } catch (e) {
      emit(GoalsLoadingError());
    }
    // try {
    //   await repo.breakSavings(event.id, event.amount);
    //   emit(GoalBroken());

    // } catch (e) {
    //   emit(GoalsLoadingError());
    //   print(e);
    //
  }

  _addMoney(AddMoneyToSavingsEvent event, emit) async {
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    emit(GoalsLoading());
    Repository repo = Repository();
    try {
      if (isConnected == false) {
        await repo.removeFromLocalWallet(event.amount);
        await repo.addToLocalGoal(event.id, event.amount);
        repo.addToSavings(event.id, event.amount);
        emit(GoalTopUp());
      } else {
        await repo.removeFromLocalWallet(event.amount);
        await repo.addToLocalGoal(event.id, event.amount);
        await repo.addToSavings(event.id, event.amount);
        Expense expense = Expense(
            description: 'deposit to savings',
            id: '',
            category: 'Savings',
            amount: event.amount,
            date: DateTime.now(),
            transactionType: 'savings_creation');
        await repo.createExpenses(expense);
        emit(GoalTopUp());
      }
    } catch (e) {
      emit(GoalTopUpError());
    }
    // try {
    //   if (event.id == '') {
    //     print('id is empty');
    //     print(event.id);
    //   } else {
    //     await repo.addToSavings(event.id, event.amount);
    //     emit(GoalTopUp());

    //   }
    // } catch (e) {
    //   print(e);
    //   emit(GoalsLoadingError());
    // }
  }

  _getGoals(GetGoalsEvent event, emit) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    emit(GoalsLoading());
    try {
      Repository repo = Repository();
      List<SavingsGoal> localGoals = await repo.getLocalGoals();
      if (connectivityResult == ConnectivityResult.none) {
        emit(GoalsLoaded(
            goals: localGoals
              ..sort((a, b) => b.createdDate.compareTo(a.createdDate))));
      } else if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        try {
          final List<SavingsGoal> remoteGoals = await repo.getGoals();

          if (localGoals != remoteGoals) {
            await repo.populateGoals(remoteGoals);
          }
          localGoals = await repo.getGoals();

          emit(GoalsLoaded(
              goals: localGoals
                ..sort((a, b) => b.createdDate.compareTo(a.createdDate))));
        } on Exception {
          emit(GoalsLoadingError());
        }
      }
    } catch (e) {
      emit(GoalsLoadingError());
    }
  }

  _deleteGoal(DeleteEvent event, emit) async {
    Expense expense = Expense(
        description: 'Savings Withdrawal',
        id: '',
        category: 'Savings Withdrawal',
        amount: event.amount,
        date: DateTime.now(),
        transactionType: 'debit');
    emit(GoalsLoading());
    Repository repo = Repository();
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    try {
      if (isConnected == false) {
        bool status = await repo.deleteLocalGoal(event.id, event.amount);
        await repo.addToLocalWalletbalance(event.amount);
        repo.deleteGoal(event.id, event.amount);
        repo.createExpenses(expense);
        if (status == true) {
          emit(GoalDeleted());
        } else {
          emit(GoalDeleteError());
        }
      } else {
        bool status = await repo.deleteLocalGoal(event.id, event.amount);
        await repo.addToLocalWalletbalance(event.amount);
        await repo.deleteGoal(event.id, event.amount);
        if (status == true) {
          emit(GoalDeleted());
        } else {
          emit(GoalDeleteError());
        }
      }
    } catch (e) {
      emit(GoalDeleteError());
    }

    // emit(GoalsLoading());
    // print('deleting');
    // try {
    //   Repository repo = Repository();
    //   bool status = await repo.deleteGoal(event.id, event.amount);
    //   if (status == true) {
    //     emit(GoalDeleted());
    //   } else {
    //     emit(GoalsLoadingError());
    //   }

    //   // emit(GoalsLoaded(goals: localGoals));
    // } catch (e) {
    //   emit(GoalsLoadingError());
    // }
  }
}
