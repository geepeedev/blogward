import 'package:blog_ward/core/theme/app_pallete.dart';
import 'package:blog_ward/core/utils/read_time.dart';
import 'package:blog_ward/features/blog/domain/entities/blog.dart';
import 'package:blog_ward/features/blog/presentation/components/cstom_sliver_heaader.dart';
import 'package:blog_ward/features/blog/presentation/pages/blog_details.dart';
import 'package:flutter/material.dart';

class BlogCardComponent extends StatelessWidget {
  final Blog blog;
  final Color color;
  const BlogCardComponent({super.key, required this.blog, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).pushNamed('BlogDetail', blog);
        Navigator.push(context, BlogDetailScreen.route(blog, color));
      },
      child: Container(
        height: 170,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: blog.category.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Chip(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                          ),
                          backgroundColor: AppPallete.backgroundColor,
                          label: Text(
                            blog.category[index],
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Text(
              blog.title.toTitleCase(),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            Text('${calculateReadingTime(blog.title)} min')
            // Text({'${calculateReadingTime(blog.content)} min' )
          ],
        ),
      ),
    );
  }
}
