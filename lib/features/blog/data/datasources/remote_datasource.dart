import 'dart:io';

import 'package:blog_ward/core/errors/server_exceptions.dart';
import 'package:blog_ward/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDatasource {
  Future<List<BlogModel>> getAllBLogs();
  Future<BlogModel> uploadBlogDatabase(BlogModel blog);
  Future<String> uploadBlogImage(
      {required File image, required BlogModel blog});
}

class BlogRemoteDatasourceImpl implements BlogRemoteDatasource {
  final SupabaseClient supabaseClient;

  BlogRemoteDatasourceImpl({required this.supabaseClient});
  @override
  Future<BlogModel> uploadBlogDatabase(BlogModel blog) async {
    try {
      final blogData =
          await supabaseClient.from('blogs').insert(blog.toJson()).select();
      return BlogModel.fromJson(blogData.first);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage(
      {required File image, required BlogModel blog}) async {
    try {
      await supabaseClient.storage.from('blog_images').upload(blog.id, image);

      return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBLogs() async {
    try {
      final blogs = await supabaseClient
          .from('blogs')
          .select('*, profiles(first_name , last_name)');
      return blogs
          .map((blog) => BlogModel.fromJson(blog).copyWith(
              firstName: blog['profiles']['first_name'],
              lastName: blog['profiles']['last_name']))
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
