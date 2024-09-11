import 'package:blog_ward/core/errors/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class Usecase<Success, Params> {
  Future<Either<Failure, Success>> call(Params params);
}

class NoParams {}