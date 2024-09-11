import 'dart:io';

import 'package:blog_ward/features/blog/domain/value_object/category_value_object.dart';
import 'package:equatable/equatable.dart';

enum Status { loading, uploaded, initial, error }

class UploadBlogState extends Equatable {
  final File? image;
  final Category category;
  final String? title;
  final String? content;
  final String? posterId;
  final Status status;
  const UploadBlogState({
    this.image,
    this.category = const Category.pure(),
    this.title,
    this.posterId,
    this.content,
    this.status = Status.initial,
  });

  UploadBlogState reset() {
    return UploadBlogState(
      image: null,
      category: const Category.pure(),
      title: null,
      content: null,
      posterId: posterId,
      status: Status.initial,
    );
  }

  UploadBlogState copyWith({
    File? image,
    Category? category,
    String? title,
    String? content,
    String? posterId,
    Status? status,
  }) {
    return UploadBlogState(
        image: image ?? this.image,
        category: category ?? this.category,
        title: title ?? this.title,
        content: content ?? this.content,
        posterId: posterId ?? this.posterId,
        status: status ?? this.status);
  }

  bool get isComplete => image != null;

  @override
  List<Object?> get props =>
      [image, content, title, status, posterId, category];
}
