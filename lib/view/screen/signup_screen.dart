import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webbrains_task/controller/user_controller.dart';
import 'package:webbrains_task/models/user_model.dart' as user;
import 'package:webbrains_task/routes/routes.dart';
import 'package:webbrains_task/utility/app_colors.dart';
import 'package:webbrains_task/utility/app_strings.dart';
import 'package:webbrains_task/utility/app_textstyle.dart';
import 'package:webbrains_task/utility/utility.dart';
import 'package:webbrains_task/view/widget/custom_button.dart';
import 'package:webbrains_task/view/widget/custom_textfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isChecked = false;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final controller = Get.find<UserController>();

  _notify([Function? function]) {
    if (mounted) {
      setState(
        () {
          function?.call();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(AppStrings.webbrains, style: AppTextStyle.titleText),
              const SizedBox(
                height: 41.7,
              ),
              const Text(
                AppStrings.createAnAccount,
                style: AppTextStyle.headingText,
              ),
              const SizedBox(
                height: 25,
              ),
              CustomTextfield(
                controller: nameController,
                text: AppStrings.name,
                hintText: AppStrings.nameHint,
              ),
              const SizedBox(
                height: 9,
              ),
              CustomTextfield(
                controller: emailController,
                text: AppStrings.emailAddress,
                hintText: AppStrings.emailAddressHint,
              ),
              const SizedBox(
                height: 9,
              ),
              CustomTextfield(
                controller: phoneNumberController,
                text: AppStrings.phone,
                hintText: AppStrings.phoneHint,
              ),
              const SizedBox(
                height: 9,
              ),
              CustomTextfield(
                controller: passwordController,
                text: AppStrings.password,
                hintText: AppStrings.passwordHint,
              ),
              const SizedBox(
                height: 17,
              ),
              const SizedBox(
                height: 28,
              ),
              Flexible(
                child: CustomButton(
                  text: AppStrings.signUp,
                  onPress: () async {
                    await controller.register(
                      user: user.User(
                          email: emailController.text,
                          name: nameController.text,
                          phoneNo: phoneNumberController.text),
                      password: passwordController.text,
                      context: context,
                      onSuccess: (user) async {
                        await Utility.setUsers(user);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            Get.offAllNamed(Routes.login);
          },
          child: RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: AppStrings.alreadyHaveAnAccount,
                  style: AppTextStyle.hintStyle,
                ),
                const TextSpan(text: "  "),
                TextSpan(
                  text: AppStrings.login,
                  style: AppTextStyle.buttonText.copyWith(
                    color: AppColors.primaryColor,
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
