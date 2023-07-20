import 'package:at_save/model/expense.dart';
import 'package:at_save/model/savings_goal.dart';
import 'package:at_save/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'target_event.dart';
part 'target_state.dart';

class TargetBloc extends Bloc<TargetEvent, TargetState> {
  TargetBloc() : super(TargetInitial()) {
    on<TargetEvent>((event, emit) {});
    on<CreateTargetEvent>(
      (event, emit) => _createTarget(event, emit),
    );
  }
}

_createTarget(CreateTargetEvent event, emit) async {
  // var connectivityResult = await Connectivity().checkConnectivity();
  emit(TargetLoading());
  Repository repo = Repository();
  SavingsGoal goal = SavingsGoal(
      currentAmount: event.currentAmount,
      createdDate: DateTime.now(),
      id: '',
      title: event.title,
      targetAmount: event.targetAmount,
      targetDate: event.targetDate,
      description: event.description);
  // if (connectivityResult == ConnectivityResult.none) {
  //   try {
  //     await repo.createLocalGoal(goal);
  //     repo.createGoal(goal);
  //     emit(TargetLoaded());
  //   } catch (e) {
  //     emit(TargetError());
  //   }
  // }
  try {
    SavingsGoal goal = SavingsGoal(
        currentAmount: event.currentAmount,
        createdDate: DateTime.now(),
        id: '',
        title: event.title,
        targetAmount: event.targetAmount,
        targetDate: event.targetDate,
        description: event.description);
    bool status = await repo.createGoal(goal);

    Expense expense = Expense(
        description: event.title,
        id: '',
        category: '${event.title} creation',
        amount: event.currentAmount,
        date: DateTime.now(),
        transactionType: 'savings_creation');
    await repo.createExpenses(expense);
    //emit(TargetError());
    if (status == true) {
      emit(TargetLoaded());
    } else {
      emit(TargetError());
    }
  } catch (e) {
    emit(TargetError());
  }
}
