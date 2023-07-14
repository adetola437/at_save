// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/user.dart';
import '../../repository/repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final Repository repository = Repository();

  UserBloc() : super(UserInitial()) {
    on<FetchUserEvent>((event, emit) => _fetchUser(event, emit));
    on<UserLogoutEvent>((event, emit) => emit(UserInitial()));
  }

  _fetchUser(FetchUserEvent event, emit) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    emit(UserLoading());
    var localUsers = await repository.localUsers();
    try {
      if (connectivityResult == ConnectivityResult.none) {
        print('local users');
        emit(UserSuccess(user: localUsers!));
      } else if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
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
