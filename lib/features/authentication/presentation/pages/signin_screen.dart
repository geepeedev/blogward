import 'package:blog_ward/core/common/widgets/loader.dart';
import 'package:blog_ward/core/theme/app_pallete.dart';
import 'package:blog_ward/core/theme/app_sizes.dart';
import 'package:blog_ward/core/utils/show_snackbar.dart';
import 'package:blog_ward/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:blog_ward/features/authentication/presentation/components/auth_button.dart';
// import 'package:blog_ward/features/authentication/presentation/pages/signup_screen.dart';
import 'package:blog_ward/features/authentication/presentation/components/auth_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          // physics: const BouncingScrollPhysics(),
          child: Padding(
            // padding: const EdgeInsets.symmetric(vertical: double.infinity),
            padding: const EdgeInsets.all(AppSizes.appPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Sign In.",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: AppSizes.spaceBetweenSections,
                ),
                const SignInFormSection(),
                const SizedBox(
                  height: AppSizes.spaceBetweenSections,
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'Signup'),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have an account? ",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        TextSpan(
                          text: "Sign up",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppPallete.secondaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignInFormSection extends StatefulWidget {
  const SignInFormSection({
    super.key,
  });

  @override
  State<SignInFormSection> createState() => _SignInFormSectionState();
}

class _SignInFormSectionState extends State<SignInFormSection> {
  final formkey = GlobalKey();

  final emailNameController = TextEditingController();
  final passwordNameController = TextEditingController();

  @override
  void dispose() {
    emailNameController.dispose();
    passwordNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          showSnackBar(context, state.failure);
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Loader();
        }
        return Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: AppSizes.spaceBetweeninputFields,
              ),
              AuthTextField(
                hintText: 'Email',
                prefixicon: Iconsax.user,
                controller: emailNameController,
              ),
              const SizedBox(
                height: AppSizes.spaceBetweeninputFields,
              ),
              AuthTextField(
                hintText: 'Password',
                prefixicon: Iconsax.password_check,
                controller: passwordNameController,
                isObscureText: true,
              ),
              const SizedBox(
                height: AppSizes.spaceBetweenSections,
              ),
              AuthButton(
                buttonText: "Sign In",
                buttonAction: () {
                  context.read<AuthBloc>().add(
                        SignInEvent(
                          email: emailNameController.text.trim(),
                          password: passwordNameController.text.trim(),
                        ),
                      );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
