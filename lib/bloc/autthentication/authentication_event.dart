part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class EmailSignUpEvent extends AuthenticationEvent {
  final String email, name, password;
  final String phoneNumber;

  EmailSignUpEvent(
      {required this.email,
      required this.name,
      required this.phoneNumber,
      required this.password});

  @override
  List<Object> get props => [email];
}
class EmailSignInEvent extends AuthenticationEvent {
  final String email, password;

   EmailSignInEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
