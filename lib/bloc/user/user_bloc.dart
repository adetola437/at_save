// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../model/user.dart';
import '../../repository/repository.dart';

part 'user_event.dart';
part 'user_state.dart';

///This bloc holds all of the user informations.
class UserBloc extends Bloc<UserEvent, UserState> {
  final Repository repository = Repository();

  UserBloc() : super(UserInitial()) {
    on<FetchUserEvent>((event, emit) => _fetchUser(event, emit));
    on<UserLogoutEvent>((event, emit) => emit(UserInitial()));
  }
///Method to implement fetch user event to get the logged in user
  _fetchUser(FetchUserEvent event, emit) async {
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    emit(UserLoading());
    var localUsers = await repository.localUsers();
    try {
      if (isConnected == false) {
        emit(UserSuccess(user: localUsers!));
      } else {
        final remoteUsers = await repository.remoteUsers();

        if (localUsers != remoteUsers) {
          await repository.populateUser(remoteUsers);
        }
        localUsers = await repository.localUsers();

        emit(UserSuccess(user: localUsers!));
      }
    } catch (e) {
      emit(UserError());
    }
  }
}
