import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webbrains_task/controller/user_controller.dart';
import 'package:webbrains_task/utility/app_colors.dart';
import 'package:webbrains_task/utility/app_strings.dart';
import 'package:webbrains_task/utility/app_textstyle.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final controller = UserController();
  @override
  void initState() {
    redirectOnAuthenticate();
    super.initState();
  }

  redirectOnAuthenticate() async {
    await Future.delayed(const Duration(seconds: 3));
    UserController userController = Get.find<UserController>();
    userController.authenticateUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: AppColors.white,
        child: Center(
          child: Text(
            AppStrings.webbrains,
            style: AppTextStyle.headingText
                .copyWith(color: AppColors.primaryColor),
          ),
        ),
      ),
    );
  }
}
