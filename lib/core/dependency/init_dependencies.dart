import 'package:blog_ward/core/common/UserCubit/app_user_cubit.dart';
import 'package:blog_ward/core/network/internet_checker.dart';
import 'package:blog_ward/core/private/private_fields.dart';
// import 'package:blog_ward/core/usecase/usecase_interface.dart';

import 'package:blog_ward/features/authentication/data/datasource/supabase_datasource.dart';
import 'package:blog_ward/features/authentication/data/repositories/auth_repo_impl.dart';
import 'package:blog_ward/features/authentication/domain/repository/auth_repository.dart';
import 'package:blog_ward/features/authentication/domain/usecase/current_user.dart';
import 'package:blog_ward/features/authentication/domain/usecase/signin.dart';
import 'package:blog_ward/features/authentication/domain/usecase/signup.dart';
import 'package:blog_ward/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:blog_ward/features/blog/data/datasources/remote_datasource.dart';
import 'package:blog_ward/features/blog/data/repository/blog_repository_impl.dart';
import 'package:blog_ward/features/blog/domain/repository/blog_repository.dart';
import 'package:blog_ward/features/blog/domain/usecases/get_blogs.dart';
import 'package:blog_ward/features/blog/domain/usecases/upload_blog.dart';
import 'package:blog_ward/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final servicelocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
      anonKey: Secrets.supabaseAnonKey, url: Secrets.supabaseUrl);
  servicelocator.registerLazySingleton(() => supabase.client);
  servicelocator.registerFactory(() => InternetConnection());
  // here i registered core folder classees that need to be initialized once the app is launched
  servicelocator.registerFactory<InternetChecker>(
      () => InternetCheckerImpl(internetConnection: servicelocator()));
  servicelocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  servicelocator
    ..registerFactory<AuthDatasource>(
      () => SupabaseDatasourceImpl(
        supabaseClient: servicelocator(),
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        authDatasource: servicelocator(),
        internet: servicelocator(),
      ),
    )
    ..registerFactory(
      () => SignUp(
        authRepository: servicelocator(),
      ),
    )
    ..registerFactory(
      () => UserSignIn(
        authRepository: servicelocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        authRepository: servicelocator(),
      ),
    )
    ..registerLazySingleton(
      () => AuthBloc(
        signUp: servicelocator(),
        currentUser: servicelocator(),
        signIn: servicelocator(),
        appUserCubit: servicelocator(),
      ),
    );
}

void _initBlog() {
  servicelocator
    ..registerFactory<BlogRemoteDatasource>(
      () => BlogRemoteDatasourceImpl(
        supabaseClient: servicelocator(),
      ),
    )
    ..registerFactory<BlogRepository>(
      () => BLogRepositoryImpl(
        blogRemoteDatasource: servicelocator(),
      ),
    )
    ..registerFactory(
      () => UploadBlog(
        blogRepository: servicelocator(),
      ),
    )
    ..registerFactory(
      () => SelectBlogs(
        blogRepository: servicelocator(),
      ),
    )
    ..registerLazySingleton(
      () => BlogBloc(
        uploadBlog: servicelocator(),
        selectBlogs: servicelocator(),
        currentUser: servicelocator(),
      ),
    );
}
