part of 'visibility_bloc.dart';

abstract class VisibilityState extends Equatable {
  const VisibilityState();

  @override
  List<Object> get props => [];
}

class VisibilityInitial extends VisibilityState {}

class VisibilityLoading extends VisibilityState {}

class VisibilityLoaded extends VisibilityState {
  bool visible;
   VisibilityLoaded({this.visible=false});

  @override
  List<Object> get props => [];
}
