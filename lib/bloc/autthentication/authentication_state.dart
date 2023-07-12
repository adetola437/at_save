part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}
///Initial state of the bloc
class AuthenticationInitial extends AuthenticationState {}
/// When the user is authenticating, this state is trigered, majorly for loading state
class AuthenticationLoading extends AuthenticationState {}  
///This state is trigered when the user has been successfully authenticated
class AuthenticationSuccess extends AuthenticationState {
  final String uid;

  AuthenticationSuccess({required this.uid});

  @override
  List<Object> get props => [uid];
}
///When there is an error in the authentication, the Authentication state is emitted.
class AuthenticationError extends AuthenticationState {
  final String error;

  AuthenticationError({required this.error});

  @override
  List<Object> get props => [error];
}
///When a user gets an error while trying to signup, SignUpError state is emitted.
class SignupError extends AuthenticationState {
  final String error;

  SignupError({required this.error});

  @override
  List<Object> get props => [error];
}
///When a user has successfully signed up, the signupseccess state is trigered.
class SignupSuccess extends AuthenticationState {
 // final String uid;

  //SignupSuccess({required this.uid});

  @override
  List<Object> get props => [];
}
