part of 'target_bloc.dart';

abstract class TargetEvent extends Equatable {
  const TargetEvent();

  @override
  List<Object> get props => [];
}

class CreateTargetEvent extends TargetEvent {
  String id;
  String title;
  double targetAmount;
  DateTime targetDate;
  String description;
  double currentAmount;
  CreateTargetEvent(
      {required this.currentAmount,
      required this.description,
      required this.targetAmount,
     required this.targetDate,
      required this.title,
     required this.id});

  @override
  List<Object> get props => [];
}
