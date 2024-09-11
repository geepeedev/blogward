part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class SignUpEvent extends AuthEvent {
  final String email;
  final String firstname;
  final String lastname;
  final String password;

  const SignUpEvent(
      {required this.email,
      required this.firstname,
      required this.lastname,
      required this.password});
}

final class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInEvent({required this.email, required this.password});
}

final class CurrentUserEvent extends AuthEvent {}
