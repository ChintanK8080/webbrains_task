import 'package:flutter/material.dart';
import 'package:webbrains_task/utility/app_colors.dart';

import '../../utility/app_textstyle.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onPress});
  final String text;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 45,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: AppTextStyle.buttonText,
        ),
      ),
    );
  }
}