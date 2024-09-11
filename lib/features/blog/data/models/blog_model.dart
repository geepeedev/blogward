// import 'dart:convert';

import 'package:blog_ward/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  const BlogModel({
    required super.id,
    required super.posterId,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.category,
    required super.updatedAt,
    super.posterLastName,
    super.posterFirstName
  });

  BlogModel copyWith({
    String? id,
    String? posterId,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? category,
    DateTime? updatedAt,
    String? firstName,
    String? lastName

  }) {
    return BlogModel(
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      updatedAt: updatedAt ?? this.updatedAt,
      posterFirstName: firstName ?? posterFirstName,
      posterLastName: lastName ?? posterLastName
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'poster_id': posterId,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'category': category,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      id: (map['id'] ?? '') as String,
      posterId: (map['poster_id'] ?? '') as String,
      title: (map['title'] ?? '') as String,
      content: (map['content'] ?? '') as String,
      imageUrl: (map['image_url'] ?? '') as String,
      category: List<String>.from((map['category'] ?? const <String>[])),
      updatedAt: map['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(map['updated_at']),
    );
  }
}
