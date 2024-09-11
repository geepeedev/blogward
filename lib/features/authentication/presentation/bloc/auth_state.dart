part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthSuccess extends AuthState {
  final User user;

  const AuthSuccess({required this.user});
}

final class AuthFailure extends AuthState {
  final String failure;

  const AuthFailure({required this.failure});
  @override
  String toString() {
    'failure message: $failure';
    return super.toString();
  }
}

final class AuthLoading extends AuthState {}
