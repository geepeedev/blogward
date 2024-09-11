// import 'dart:io';

// import 'package:blog_ward/core/theme/app_pallete.dart';
import 'package:blog_ward/core/theme/app_sizes.dart';
// import 'package:blog_ward/core/utils/date_formatter.dart';
// import 'package:blog_ward/core/utils/read_time.dart';
// import 'package:blog_ward/features/authentication/presentation/components/custom_appbar.dart';
import 'package:blog_ward/features/blog/domain/entities/blog.dart';
import 'package:blog_ward/features/blog/presentation/components/cstom_sliver_heaader.dart';
import 'package:flutter/material.dart';


class BlogDetailScreen extends StatelessWidget {
  final Blog blog;
  final Color color;
  const BlogDetailScreen({super.key, required this.blog, required this.color});

  static route(Blog blog, Color color) => MaterialPageRoute(
        builder: (context) => BlogDetailScreen(
          blog: blog,
          color: color,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(slivers: [
          customSliverHeader(180, 250, color, blog),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: AppSizes.spacebtwItems,
                ),
                // Image(image: File(blog.imageUrl))
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Image.network(
                    blog.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: AppSizes.spaceBetweenSections,
                ),
                Text(
                  blog.content,
                  style: TextStyle(
                      color: color,
                      fontSize: 15,
                      letterSpacing: 1.1,
                      wordSpacing: 1,
                      height: 1.5),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
