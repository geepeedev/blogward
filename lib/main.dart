import 'package:blog_ward/core/common/UserCubit/app_user_cubit.dart';
import 'package:blog_ward/core/dependency/init_dependencies.dart';
// import 'package:blog_ward/core/private/private_fields.dart';
import 'package:blog_ward/core/theme/app_theme.dart';
// import 'package:blog_ward/features/authentication/data/datasource/supabase_datasource.dart';
// import 'package:blog_ward/features/authentication/data/repositories/auth_repo_impl.dart';
// import 'package:blog_ward/features/authentication/domain/usecase/signup.dart';
import 'package:blog_ward/features/authentication/presentation/bloc/auth_bloc.dart';

import 'package:blog_ward/features/authentication/presentation/pages/signin_screen.dart';
import 'package:blog_ward/features/authentication/presentation/pages/signup_screen.dart';
import 'package:blog_ward/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_ward/features/blog/presentation/pages/add_blog_page.dart';
// import 'package:blog_ward/features/blog/presentation/pages/blog_details.dart';
import 'package:blog_ward/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => servicelocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (context) => servicelocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (context) => servicelocator<BlogBloc>(),
      ),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    // context.read<AppUserCubit>().updateUser();
    context.read<AuthBloc>().add(CurrentUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkThemeMode,
      // i noticed while developing this app that the use of initial route redirected my app to the signin page
      //even after the user data was fetched the initialroute caused issues when developing the app
      // this prevented the blocselector from working
      // initialRoute: 'Signin',
      routes: {
        "Signup": (context) => const SignUpScreen(),
        "Signin": (context) => const SignInScreen(),
        "Blog": (context) => const BlogScreen(),
        "AddBlog": (context) => const AddBlogScreen(),
        // "BlogDetail" :(context) =>  BlogDetailScreen(blog: ,),
      },
      debugShowCheckedModeBanner: false,
      home: BlocConsumer<AppUserCubit, AppUserState>(
        listenWhen: (previous, current) =>
            current is UserLoggedInState && current.user.id.isNotEmpty,
        listener: (context, state) {
          // if (state is UserLoggedInState) {
          //   context
          //       .read<BlogBloc>()
          //       .add(PosterIdEvent(currentUserId: state.user.id));
          // }
        },
        builder: (context, state) {
          if (state is UserLoggedInState) {
            return const BlogScreen();
          }
          return const SignInScreen();
        },
      ),
    );
  }
}
