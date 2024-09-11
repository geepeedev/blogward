import 'dart:io';

import 'package:blog_ward/core/errors/failures.dart';
import 'package:blog_ward/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> category,
  });

  Future<Either<Failure, List<Blog>>> selectAllBlogs();
}
