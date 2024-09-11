// import 'package:blog_ward/core/common/UserCubit/app_user_cubit.dart';
import 'dart:io';

// import 'package:blog_ward/core/common/widgets/loader.dart';
// import 'package:blog_ward/core/common/UserCubit/app_user_cubit.dart';
import 'package:blog_ward/core/theme/app_pallete.dart';
import 'package:blog_ward/core/theme/app_sizes.dart';
import 'package:blog_ward/core/utils/show_snackbar.dart';
// import 'package:blog_ward/core/utils/show_snackbar.dart';
import 'package:blog_ward/features/authentication/presentation/components/custom_appbar.dart';
// import 'package:blog_ward/features/blog/domain/value_object/category_value_object.dart';
import 'package:blog_ward/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_ward/features/blog/presentation/components/add_blog_input.dart';
import 'package:blog_ward/features/blog/presentation/objects/upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dotted_border/dotted_border.dart';
// import 'dart:io';

class AddBlogScreen extends StatefulWidget {
  const AddBlogScreen({super.key});

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(ResetForm());
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController blogContentController = TextEditingController();
    final TextEditingController blogTitleController = TextEditingController();
    final formkey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          appBarTitle: "Add Blog",
          trailIcon: const Icon(Iconsax.tick_circle),
          // leadIcon: const Icon(Iconsax.arrow_left_1),
          trailIconAction: () {
            if (formkey.currentState!.validate()) {
              context.read<BlogBloc>().add(BlogFieldEvent(
                  title: blogTitleController.text.trim(),
                  content: blogContentController.text.trim()));
              context.read<BlogBloc>().add(FormSubmitEvent());
              // formkey.currentState!.reset();
              // context.read<BlogBloc>().add(ResetForm());
            }
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: MultiBlocListener(
              listeners: [
                BlocListener<BlogBloc, BlogState>(
                  listenWhen: (previous, current) => current is BlogEdit,
                  listener: (context, state) {
                    if (state is BlogEdit &&
                        state.editBlog.status == Status.error) {
                      showSnackBar(context, 'Complete all fields');
                    }
                    if (state is BlogEdit &&
                        state.editBlog.status == Status.loading) {
                      showSnackBar(context, 'Upload in progress');
                    }
                    if (state is BlogEdit &&
                        state.editBlog.status == Status.uploaded) {
                      showSnackBar(context, "Blog uploaded");
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('Blog', (route) => false);
                    }
                  },
                ),
                BlocListener<BlogBloc, BlogState>(
                  listenWhen: (previous, current) => current is BlogFailure,
                  listener: (context, state) {
                    if (state is BlogFailure) {
                      showSnackBar(context, state.error);
                    }
                  },
                )
              ],
              child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      const SelectImageComponent(),
                      const SelectBlogCategoryComponent(),
                      AddBlogInputComponent(
                          controller: blogTitleController,
                          hintText: "Blog Title"),
                      const SizedBox(
                        height: AppSizes.spaceBetweeninputFields,
                      ),
                      AddBlogInputComponent(
                          controller: blogContentController,
                          hintText: "Blog Content"),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

class SelectBlogCategoryComponent extends StatelessWidget {
  const SelectBlogCategoryComponent({
    super.key,
  });
  static List<String> blogCategories = [
    'Technology',
    'Business',
    'Programming',
    'Entertainment'
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ListView.builder(
        // shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: blogCategories.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: GestureDetector(
              onTap: () {
                context.read<BlogBloc>().add(CategoryPickEvent(
                      categoryItem: blogCategories[index],
                    ));
              },
              child: BlocBuilder<BlogBloc, BlogState>(
                // selector: (state) => state is BlogEdit,
                buildWhen: (previous, current) => current is BlogEdit,

                builder: (context, state) {
                  // final category = edit.editBlog.category;
                  if (state is BlogEdit) {
                    return Chip(
                      padding: const EdgeInsets.all(8),
                      backgroundColor: state.editBlog.category.value
                              .contains(blogCategories[index])
                          ? AppPallete.secondaryColor
                          : AppPallete.backgroundColor,
                      label: Text(
                        blogCategories[index],
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ),
                      ),
                      side: BorderSide(
                        color: state.editBlog.category.value
                                .contains(blogCategories[index])
                            ? AppPallete.backgroundColor
                            : AppPallete.borderColor,
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class SelectImageComponent extends StatelessWidget {
  const SelectImageComponent({
    super.key,
  });

  // File? image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // selectedImage();
        context.read<BlogBloc>().add(ImagePickEvent());
      },
      child: BlocBuilder<BlogBloc, BlogState>(
          // selector: (state) => state as BlogEdit,
          // buildWhen: (previous, current) => current is BlogEdit,
          builder: (context, state) {
        if (state is BlogEdit && state.editBlog.image != null) {
          return ImageWidget(image: state.editBlog.image!);
        }
        return const ImageNullWidget();
        // final image = state.editBlog.image;
        // return image != null
        //     ? ImageWidget(image: image)
        //     : const ImageNullWidget();
      }),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.image,
  });

  final File image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ImageNullWidget extends StatelessWidget {
  const ImageNullWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      strokeCap: StrokeCap.round,
      borderType: BorderType.RRect,
      radius: const Radius.circular(10),
      color: AppPallete.accentColor,
      dashPattern: const [10, 4],
      child: const SizedBox(
        width: double.infinity,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.folder_2,
              size: 45,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Select your image",
              style: TextStyle(fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}
