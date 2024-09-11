// import 'package:blog_ward/core/theme/app_pallete.dart';
import 'package:blog_ward/core/common/widgets/loader.dart';
import 'package:blog_ward/core/theme/app_sizes.dart';
import 'package:blog_ward/core/utils/show_snackbar.dart';
import 'package:blog_ward/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:blog_ward/features/authentication/presentation/components/auth_button.dart';
import 'package:blog_ward/features/authentication/presentation/components/auth_textbutton.dart';
import 'package:blog_ward/features/authentication/presentation/components/auth_textfield.dart';
import 'package:blog_ward/features/authentication/presentation/components/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        leadIcon: Icon(Iconsax.close_circle),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.appPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Sign Up.",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: AppSizes.spaceBetweenSections,
                ),
                const SignUpFormSection(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    AuthTextButton(
                      buttonText: "Sign in",
                      onPressed: () => Navigator.pushNamed(context, 'Signin'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpFormSection extends StatefulWidget {
  const SignUpFormSection({
    super.key,
  });

  @override
  State<SignUpFormSection> createState() => _SignUpFormSectionState();
}

class _SignUpFormSectionState extends State<SignUpFormSection> {
  // @override
  // final GlobalKey<FormFieldState<FormState>> formKey =
  //     GlobalKey<FormFieldState<FormState>>();

  final formkey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordNameController = TextEditingController();
  final emailNameController = TextEditingController();

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
            children: [
              AuthTextField(
                hintText: 'First name',
                prefixicon: Iconsax.user,
                controller: firstNameController,
              ),
              const SizedBox(
                height: AppSizes.spaceBetweeninputFields,
              ),
              AuthTextField(
                hintText: 'Last Name',
                prefixicon: Iconsax.user,
                controller: lastNameController,
              ),
              const SizedBox(
                height: AppSizes.spaceBetweeninputFields,
              ),
              AuthTextField(
                hintText: 'Email',
                prefixicon: Iconsax.message_2,
                controller: emailNameController,
                textChange: (value) {},
              ),
              const SizedBox(
                height: AppSizes.spaceBetweeninputFields,
              ),
              AuthTextField(
                hintText: 'Password',
                prefixicon: Iconsax.password_check,
                controller: passwordNameController,
                isObscureText: true,
                textChange: (value) {},
              ),
              const SizedBox(
                height: AppSizes.spaceBetweenSections,
              ),
              AuthButton(
                buttonText: "Sign Up",
                buttonAction: () {
                  // final isValid = formKey.currentState;
                  final isValid = formkey.currentState;
                  if (isValid != null) {
                    isValid.validate();
                    // formKey.currentState.validate();
                    context.read<AuthBloc>().add(
                          SignUpEvent(
                            email: emailNameController.text.trim(),
                            firstname: firstNameController.text.trim(),
                            lastname: lastNameController.text.trim(),
                            password: passwordNameController.text.trim(),
                          ),
                        );
                  }
                },
              ),
              const SizedBox(
                height: AppSizes.spaceBetweenSections,
              ),
            ],
          ),
        );
      },
    );
  }
}
