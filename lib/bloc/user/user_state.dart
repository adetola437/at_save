part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserError extends UserState {}

class UserSuccess extends UserState {
  final User user;

  const UserSuccess({
    required this.user,
  });
  @override
  List<Object> get props => [user];
}
