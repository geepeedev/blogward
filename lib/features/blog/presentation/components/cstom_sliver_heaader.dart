import 'dart:math';

import 'package:blog_ward/core/theme/app_sizes.dart';
import 'package:blog_ward/core/utils/date_formatter.dart';
import 'package:blog_ward/core/utils/read_time.dart';
import 'package:blog_ward/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';

SliverPersistentHeader customSliverHeader(
    double minHeight, double maxheight, Color color, Blog blog) {
  return SliverPersistentHeader(
    pinned: true,
    // floating: true,
    delegate: _SliverAppBar(
        minHeight: minHeight, maxHeight: maxheight, color: color, blog: blog),
  );
}

class _SliverAppBar extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Color color;
  final Blog blog;

  _SliverAppBar({
    required this.minHeight,
    required this.maxHeight,
    required this.color,
    required this.blog,
  });
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: Container(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.appPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pushNamed('Blog'),
                icon: const Icon(
                  Iconsax.close_circle,
                  color: Colors.black87,
                ),
              ),
              Row(
                children: blog.category
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            e.toUpperCase(),
                            style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ))
                    .toList(),
              ),
              Text(
                // blog.title.capitalize(),
                blog.title.toTitleCase(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'By ${blog.posterFirstName} ${blog.posterLastName}'
                        .toTitleCase(),
                    style: const TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${dateFormatted(blog.updatedAt)} . ${calculateReadingTime(blog.content)} min',
                    style: const TextStyle(color: Colors.blueGrey),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
