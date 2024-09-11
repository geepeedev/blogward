// import 'package:blog_ward/core/errors/failures.dart';
import 'package:blog_ward/core/common/UserCubit/app_user_cubit.dart';
import 'package:blog_ward/core/usecase/usecase_interface.dart';
import 'package:blog_ward/core/common/entities/user_entity.dart';
import 'package:blog_ward/features/authentication/domain/usecase/current_user.dart';
import 'package:blog_ward/features/authentication/domain/usecase/signin.dart';
import 'package:blog_ward/features/authentication/domain/usecase/signup.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUp _signup;
  final UserSignIn _signIn;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required SignUp signUp,
    required UserSignIn signIn,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _signup = signUp,
        _signIn = signIn,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>(
      (_, emit) => emit(
        AuthLoading(),
      ),
    );
    on<SignUpEvent>((event, emit) async {
      final resp = await _signup(SignUpParams(
          email: event.email,
          password: event.password,
          firstname: event.firstname,
          lastname: event.lastname));
      resp.fold(
        (failure) => emit(AuthFailure(failure: failure.message)),
        (user) => _emitAuthSuccess(user, emit),
      );
    });
    on<SignInEvent>((event, emit) async {
      final resp = await _signIn(
          UserSignInParams(email: event.email, password: event.password));
      resp.fold(
        (failure) => emit(AuthFailure(failure: failure.message)),
        (user) => _emitAuthSuccess(user, emit),
      );
    });
    on<CurrentUserEvent>((event, emit) async {
      final res = await _currentUser(NoParams());
      res.fold(
        (failure) => emit(AuthFailure(failure: failure.message)),
        (user) => _emitAuthSuccess(user, emit),
      );
    });
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user: user));
  }
}
