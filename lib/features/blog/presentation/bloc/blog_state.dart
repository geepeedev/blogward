// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'blog_bloc.dart';

sealed class BlogState extends Equatable {
  const BlogState();
  @override
  List<Object?> get props => [];
}

final class BlogInitial extends BlogState {}

final class BlogFailure extends BlogState {
  final String error;
  const BlogFailure({required this.error});
}

final class BlogEdit extends BlogState {
  final UploadBlogState editBlog;

  const BlogEdit({required this.editBlog});
  @override
  List<Object> get props => [editBlog];
}

final class GetBlogsState extends BlogState {
  final List<Blog> blogs;

  const GetBlogsState({required this.blogs});
  @override
  List<Object> get props => [blogs];
}
