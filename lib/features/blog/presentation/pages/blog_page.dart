// import 'package:blog_ward/core/common/UserCubit/app_user_cubit.dart';
import 'package:blog_ward/core/theme/app_pallete.dart';
import 'package:blog_ward/core/utils/show_snackbar.dart';
// import 'package:blog_ward/core/utils/show_snackbar.dart';
import 'package:blog_ward/features/authentication/presentation/components/custom_appbar.dart';
import 'package:blog_ward/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_ward/features/blog/presentation/components/blog_card.dart';
// import 'package:blog_ward/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(SelectAllBlogsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogFailure) {
              showSnackBar(context, state.error);
            }
          },
        )
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            // trailIconAction: () => Navigator.pushNamed(context, "AddBlog"),
            trailIconAction: () {
              // context.read<BlogBloc>().add(AddPageEvent());

              Navigator.pushNamed(context, "AddBlog");
              context.read<BlogBloc>().add(ResetForm());
            },
          ),
          body: Center(
            child: BlocBuilder<BlogBloc, BlogState>(
              builder: (context, state) {
                if (state is GetBlogsState) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: double.infinity,
                      height: double.maxFinite,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.blogs.length,
                        itemBuilder: (context, index) {
                          final blog = state.blogs[index];
                          return BlogCardComponent(
                            blog: blog,
                            color: index % 3 == 0
                                ? AppPallete.primaryColor
                                : index % 3 == 1
                                    ? AppPallete.secondaryColor
                                    : Colors.greenAccent,
                          );
                        },
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}
