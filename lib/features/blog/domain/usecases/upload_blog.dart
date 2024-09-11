// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:blog_ward/core/errors/failures.dart';
import 'package:blog_ward/core/usecase/usecase_interface.dart';
import 'package:blog_ward/features/blog/domain/entities/blog.dart';
import 'package:blog_ward/features/blog/domain/repository/blog_repository.dart';
// import 'package:fpdart/src/either.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements Usecase<Blog,UploadBlogParams> {
  final BlogRepository blogRepository;

  UploadBlog({required this.blogRepository});
  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params)  async {
   return await blogRepository.uploadBlog(image: params.image, title: params.title, content: params.content, posterId: params.posterId, category: params.category);
  }
}

final class UploadBlogParams {
  final String title;
  final String content;
  final File image;
  final String posterId;
  final List<String> category;
  UploadBlogParams({
    required this.title,
    required this.content,
    required this.image,
    required this.posterId,
    required this.category,
  });
}
