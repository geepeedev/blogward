import 'package:blog_ward/core/errors/failures.dart';
import 'package:blog_ward/core/common/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> currentUser();
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required firstname,
      required lastname,
      required email,
      required password});

  Future<Either<Failure, User>> signInWithEmailPassword(
      {required email, required password});
}
