part of 'app_user_cubit.dart';

sealed class AppUserState extends Equatable {
  const AppUserState();

  @override
  List<Object> get props => [];
}

// app initial is used to show that the user is logged out
final class AppUserInitial extends AppUserState {}

// this shows that the user is logged in
final class UserLoggedInState extends AppUserState {
  final User user;

const  UserLoggedInState({required this.user});
}
