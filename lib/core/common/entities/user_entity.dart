// import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User extends Equatable {
  final String id;
  final String email;
  final String firstname;
  final String lastname;
  const User({
    required this.id,
    required this.email,
    required this.firstname,
    required this.lastname,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, email, firstname, lastname];
}
