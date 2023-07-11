import 'package:at_save/model/savings_goal.dart';
import 'package:at_save/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
    Repository repo = Repository();
    try {
      repo.updateSavingsGoal(event.golaId, event.description, event.goalName,
          event.targetAmount, event.date);
      emit(GoalEdited());

      // List<SavingsGoal> localGoals = await repo.getGoals();

      // final List<SavingsGoal> remoteGoals = await repo.getGoals();

      // if (localGoals != remoteGoals) {
      //   await repo.populateGoals(remoteGoals);
      // }
      // localGoals = await repo.getGoals();

      // emit(GoalsLoaded(goals: localGoals));
    } catch (e) {
      print(e);
    }
  }

  _breakSavings(BreakSavingsEvent event, emit) async {
    emit(GoalsLoading());
    Repository repo = Repository();
    try {
      repo.breakSavings(event.id, event.amount);
      emit(GoalBroken());
      // List<SavingsGoal> localGoals = await repo.getGoals();

      // final List<SavingsGoal> remoteGoals = await repo.getGoals();

      // if (localGoals != remoteGoals) {
      //   await repo.populateGoals(remoteGoals);
      // }
      // localGoals = await repo.getGoals();

      // emit(GoalsLoaded(goals: localGoals));
    } catch (e) {
      emit(GoalsLoadingError());
      print(e);
    }
  }

  _addMoney(AddMoneyToSavingsEvent event, emit) async {
    emit(GoalsLoading());
    Repository repo = Repository();
    try {
      if (event.id == '') {
        print('id is empty');
        print(event.id);
      } else {
        await repo.addToSavings(event.id, event.amount);
        emit(GoalTopUp());
        // List<SavingsGoal> localGoals = await repo.getGoals();

        // final List<SavingsGoal> remoteGoals = await repo.getGoals();

        // if (localGoals != remoteGoals) {
        //   await repo.populateGoals(remoteGoals);
        // }
        // localGoals = await repo.getGoals();

        // emit(GoalsLoaded(goals: localGoals));
      }
    } catch (e) {
      print(e);
      emit(GoalsLoadingError());
    }
  }

  _getGoals(GetGoalsEvent event, emit) async {
    emit(GoalsLoading());
    Repository repo = Repository();
    List<SavingsGoal> localGoals = await repo.getGoals();
    try {
      final List<SavingsGoal> remoteGoals = await repo.getGoals();

      if (localGoals != remoteGoals) {
        await repo.populateGoals(remoteGoals);
      }
      localGoals = await repo.getGoals();

      emit(GoalsLoaded(goals: localGoals));
    } on Exception {
      emit(GoalsLoadingError());
    }
  }

  _deleteGoal(DeleteEvent event, emit) async {
    emit(GoalsLoading());
    print('deleting');
    try {
      Repository repo = Repository();
      await repo.deleteGoal(event.id, event.amount);
      List<SavingsGoal> localGoals = await repo.getGoals();

      final List<SavingsGoal> remoteGoals = await repo.getGoals();

      if (localGoals != remoteGoals) {
        await repo.populateGoals(remoteGoals);
      }
      localGoals = await repo.getGoals();
      emit(GoalDeleted());

      // emit(GoalsLoaded(goals: localGoals));
    } catch (e) {
      emit(GoalsLoadingError());
    }
  }
}
