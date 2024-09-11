import 'package:blog_ward/core/errors/failures.dart';
import 'package:blog_ward/core/usecase/usecase_interface.dart';
import 'package:blog_ward/core/common/entities/user_entity.dart';
import 'package:blog_ward/features/authentication/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignIn implements Usecase<User, UserSignInParams> {
  final AuthRepository authRepository;

  UserSignIn({required this.authRepository});
  @override
  Future<Either<Failure, User>> call(UserSignInParams params) async {
    return await authRepository.signInWithEmailPassword(
        email: params.email, password: params.password);
  }
}

class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams({required this.email, required this.password});
}
