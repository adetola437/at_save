part of 'target_bloc.dart';

abstract class TargetState extends Equatable {
  const TargetState();

  @override
  List<Object> get props => [];
}

class TargetInitial extends TargetState {}

class TargetLoading extends TargetState {}

class TargetLoaded extends TargetState {}

class TargetError extends TargetState {}
