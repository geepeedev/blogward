import 'package:blog_ward/core/errors/server_exceptions.dart';
import 'package:blog_ward/features/authentication/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthDatasource {
  Session? get userSession;
  Future<UserModel?> getCurrentUser();
  Future<UserModel> signUpWithEmailPassword(
      {required firstname,
      required lastname,
      required email,
      required password});

  Future<UserModel> signInWithEmailPassword(
      {required email, required password});
}

class SupabaseDatasourceImpl implements AuthDatasource {
  final SupabaseClient supabaseClient;

  SupabaseDatasourceImpl({required this.supabaseClient});
  @override
  Future<UserModel> signInWithEmailPassword(
      {required email, required password}) async {
    try {
      // supabaseClient.auth.currentSession!.user;
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw ServerException(message: "This user is not found");
      }
      return UserModel.fromMap(response.user!.toJson()).copyWith(email: userSession!.user.email);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword(
      {required firstname,
      required lastname,
      required email,
      required password}) async {
    try {
      final response = await supabaseClient.auth.signUp(
          password: password,
          email: email,
          data: {'firstname': firstname, 'lastname': lastname});
      if (response.user == null) {
        throw ServerException(message: "This user is not found");
      }
      return UserModel.fromMap(response.user!.toJson()).copyWith(email: userSession!.user.email);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Session? get userSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      if (userSession != null) {
        final userData = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', userSession!.user.id);
       return  UserModel.fromMap(userData.first).copyWith(email: userSession!.user.email);
      }
    return  null;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
