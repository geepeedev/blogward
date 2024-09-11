import 'dart:io';

import 'package:blog_ward/core/errors/failures.dart';
import 'package:blog_ward/core/errors/server_exceptions.dart';
import 'package:blog_ward/features/blog/data/datasources/remote_datasource.dart';
import 'package:blog_ward/features/blog/data/models/blog_model.dart';
import 'package:blog_ward/features/blog/domain/entities/blog.dart';
import 'package:blog_ward/features/blog/domain/repository/blog_repository.dart';
// import 'package:fpdart/src/either.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BLogRepositoryImpl implements BlogRepository {
  final BlogRemoteDatasource blogRemoteDatasource;

  BLogRepositoryImpl({required this.blogRemoteDatasource});
  @override
  Future<Either<Failure, Blog>> uploadBlog(
      {required File image,
      required String title,
      required String content,
      required String posterId,
      required List<String> category}) async {
    try {
      BlogModel blogModel = BlogModel(
          id: const Uuid().v1(),
          posterId: posterId,
          title: title,
          content: content,
          imageUrl: '',
          category: category,
          updatedAt: DateTime.now());

      final String imageUrl = await blogRemoteDatasource.uploadBlogImage(
        image: image,
        blog: blogModel,
      );
      final BlogModel uploadedBlog = await blogRemoteDatasource
          .uploadBlogDatabase(blogModel.copyWith(imageUrl: imageUrl));

      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> selectAllBlogs() async {
    try {
      final blogs = await blogRemoteDatasource.getAllBLogs();

      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
