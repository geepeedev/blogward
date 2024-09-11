import 'package:blog_ward/core/theme/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      this.appBarTitle,
      this.trailIconAction,
      this.leadNavString,
      this.trailIcon,
      this.leadIcon,
      this.titlePresent = true,
      this.trailActivity = true});
  final String? appBarTitle;
  final void Function()? trailIconAction;
  final String? leadNavString;
  final Widget? trailIcon;
  final Widget? leadIcon;
  final bool titlePresent;
  final bool trailActivity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.appPadding),
      child: AppBar(
        // flexibleSpace: ,
        automaticallyImplyLeading: false,
        leadingWidth: AppSizes.appPadding,
        toolbarHeight: double.infinity,
        title: titlePresent ? Text(appBarTitle ?? "BlogWard") : null,
        centerTitle: true,
        // title:Text(appBarTitle),
        actions: trailActivity
            ? [
                IconButton(
                    onPressed: trailIconAction,
                    icon: trailIcon ?? const Icon(Iconsax.add_circle))
              ]
            : null,
        leading: leadIcon != null
            ? IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, leadNavString ?? "Signin");
                },
                icon: leadIcon ??
                    const Icon(
                      Iconsax.close_circle,
                      // size: 20,
                    ),
              )
            : null,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
