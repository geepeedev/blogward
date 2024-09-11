// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_ward/core/errors/failures.dart';
import 'package:blog_ward/core/usecase/usecase_interface.dart';
import 'package:blog_ward/core/common/entities/user_entity.dart';
import 'package:blog_ward/features/authentication/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';


class SignUp implements Usecase<User, SignUpParams> {
  final AuthRepository authRepository;
  SignUp({
    required this.authRepository,
  });
  @override
  Future<Either<Failure, User>> call(SignUpParams params) async {
    return await authRepository.signUpWithEmailPassword(
        firstname: params.firstname,
        lastname: params.lastname,
        email: params.email,
        password: params.password);
  }
}

class SignUpParams {
  final String email;
  final String password;
  final String firstname;
  final String lastname;

  SignUpParams(
      {required this.email,
      required this.password,
      required this.firstname,
      required this.lastname});
}
