import 'package:blog_ward/core/errors/failures.dart';
import 'package:blog_ward/core/usecase/usecase_interface.dart';
import 'package:blog_ward/core/common/entities/user_entity.dart';
import 'package:blog_ward/features/authentication/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements Usecase<User, NoParams> {
  final AuthRepository authRepository;

  CurrentUser({required this.authRepository});
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
