// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

import 'package:equatable/equatable.dart';

class Blog extends Equatable {
  final String id;
  final String posterId;
  final String title;
  final String content;
  final String imageUrl;
  final List<String> category;
  final DateTime updatedAt;
  final String? posterFirstName;
   final String? posterLastName;
  const Blog({
    required this.id,
    required this.posterId,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.category,
    required this.updatedAt,
    this.posterFirstName,
    this.posterLastName
  });
  @override
  bool get stringify => true;
  @override
  List<Object?> get props {
    return [
      id,
      posterId,
      title,
      content,
      imageUrl,
      category,
      updatedAt,
      posterFirstName,
      posterLastName
    ];
  }
}
