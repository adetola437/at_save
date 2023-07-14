import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'visibility_event.dart';
part 'visibility_state.dart';

class VisibilityBloc extends Bloc<VisibilityEvent, VisibilityState> {
  VisibilityBloc() : super(VisibilityInitial()) {
    on<VisibilityEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<ToggleVisibility>(
      (event, emit) => toggleVisibility(event, emit),
    );
    on<FetchVisibility>(
      (event, emit) => _fetchVisibility(event, emit),
    );
  }

  toggleVisibility(ToggleVisibility event, emit) async {
    emit(VisibilityLoading());
    emit(VisibilityLoaded(visible: event.visible));
  }

  _fetchVisibility(FetchVisibility event, emit) {
    emit(VisibilityLoaded(visible: false));
  }
}
