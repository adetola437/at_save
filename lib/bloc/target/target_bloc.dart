import 'dart:math';

import 'package:at_save/model/savings_goal.dart';
import 'package:at_save/repository.dart';
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
  Repository repo = Repository();
  try {
    SavingsGoal goal = SavingsGoal(
        currentAmount: event.currentAmount,
        createdDate: DateTime.now(),
        id: '',
        title: event.title,
        targetAmount: event.targetAmount,
        targetDate: event.targetDate,
        description: event.description);
    repo.createGoal(goal);
  } catch (e) {
    print(e);
  }
}
