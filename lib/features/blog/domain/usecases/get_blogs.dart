import 'package:blog_ward/core/errors/failures.dart';
import 'package:blog_ward/core/usecase/usecase_interface.dart';
import 'package:blog_ward/features/blog/domain/entities/blog.dart';
import 'package:blog_ward/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class SelectBlogs implements Usecase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;

  SelectBlogs({required this.blogRepository});
  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.selectAllBlogs();
  }
}
