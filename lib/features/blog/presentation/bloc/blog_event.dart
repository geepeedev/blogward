part of 'blog_bloc.dart';

sealed class BlogEvent extends Equatable {
  const BlogEvent();

  @override
  List<Object> get props => [];
}

final class ImagePickEvent extends BlogEvent {}

final class CategoryPickEvent extends BlogEvent {
  // final List<String> category;
  final String categoryItem;

  const CategoryPickEvent({required this.categoryItem});
  @override
  List<Object> get props => [categoryItem];
}

final class FormSubmitEvent extends BlogEvent {}

final class BlogFieldEvent extends BlogEvent {
  final String title;
  final String content;

  const BlogFieldEvent({required this.title, required this.content});
}

final class PosterIdEvent extends BlogEvent {
  final String currentUserId;

  const PosterIdEvent({required this.currentUserId});
}

final class ResetForm extends BlogEvent {
  


}

final class AddPageEvent extends BlogEvent {}

final class SelectAllBlogsEvent extends BlogEvent {}
