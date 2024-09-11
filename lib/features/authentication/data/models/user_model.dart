// import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:blog_ward/core/common/entities/user_entity.dart';

class UserModel extends User {
 const UserModel({
    required super.id,
    required super.email,
    required super.firstname,
    required super.lastname,
  });

    factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: (map['id'] ?? '') as String,
      email: (map['email'] ?? '') as String,
      firstname: (map['firstname'] ?? '') as String,
      lastname: (map['lastname'] ?? '') as String,
    );
  }
    UserModel copyWith({
    String? id,
    String? email,
    String? firstname,
    String? lastname,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
    );
  }
}
