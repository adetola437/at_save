part of 'visibility_bloc.dart';

abstract class VisibilityEvent extends Equatable {
  const VisibilityEvent();

  @override
  List<Object> get props => [];
}

class ToggleVisibility extends VisibilityEvent {
  bool visible;
   ToggleVisibility({this.visible=false});

  @override
  List<Object> get props => [];
}
class FetchVisibility extends VisibilityEvent{}
