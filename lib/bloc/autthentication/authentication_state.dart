part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final String uid;

  AuthenticationSuccess({required this.uid});

  @override
  List<Object> get props => [uid];
}

class AuthenticationError extends AuthenticationState {
  final String error;

  AuthenticationError({required this.error});

  @override
  List<Object> get props => [error];
}

class SignupError extends AuthenticationState {
  final String error;

  SignupError({required this.error});

  @override
  List<Object> get props => [error];
}

class SignupSuccess extends AuthenticationState {
  final String uid;

  SignupSuccess({required this.uid});

  @override
  List<Object> get props => [uid];
}
