// import 'dart:js_interop';

import 'package:blog_ward/core/errors/failures.dart';
import 'package:blog_ward/core/errors/server_exceptions.dart';
import 'package:blog_ward/core/network/internet_checker.dart';
import 'package:blog_ward/features/authentication/data/datasource/supabase_datasource.dart';
import 'package:blog_ward/core/common/entities/user_entity.dart';
import 'package:blog_ward/features/authentication/data/models/user_model.dart';
import 'package:blog_ward/features/authentication/domain/repository/auth_repository.dart';
// import 'package:fpdart/src/either.dart';
import 'package:fpdart/fpdart.dart';
// import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
// import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource authDatasource;
  // final ConnectionStream connectionStream;
  final InternetChecker internet;

  AuthRepositoryImpl({
    required this.authDatasource,
    required this.internet,
  });

  @override
  Future<Either<Failure, User>> signInWithEmailPassword(
      {required email, required password}) async {
    return _getUser(() async => await authDatasource.signInWithEmailPassword(
        email: email, password: password));
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required firstname,
    required lastname,
    required email,
    required password,
  }) async {
    return _getUser(() async => await authDatasource.signUpWithEmailPassword(
        firstname: firstname,
        lastname: lastname,
        email: email,
        password: password));
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await (internet.isConnected)) {
        final session = authDatasource.userSession;
        // if (status == InternetStatus.disconnected) {
        if (session == null) {
          return left(Failure('Please turn on data'));
        }
        return right(UserModel(
            id: session.user.id,
            email: session.user.email ?? '',
            firstname: '',
            lastname: ''));
      }
      // }
      final user = await authDatasource.getCurrentUser();
      if (user == null) {
        return left(Failure('This user is not logged in'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    // final connection = internet.listenForInternet();
    internet.listenForInternet();
    try {
      if (!await (internet.isConnected)) {
        return left(Failure("No internet connection"));
      }

      final user = await fn();
      return right(user);
      // return left(Failure("No internet connection"));
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(
        Failure(e.message),
      );
    }
  }
}
