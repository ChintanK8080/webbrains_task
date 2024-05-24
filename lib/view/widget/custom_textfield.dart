
import 'package:flutter/material.dart';
import 'package:webbrains_task/utility/app_colors.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield(
      {super.key,
      required this.text,
      required this.hintText,
      this.trailing,
      this.isObsecure = false,
      required this.controller});
  final String text;
  final TextEditingController controller;
  final String hintText;
  final Widget? trailing;
  final bool isObsecure;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: const TextStyle(
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        SizedBox(
          height: 41,
          child: TextFormField(
            validator: (value) {
              return "enter valid data";
            },
            controller: widget.controller,
            obscureText: widget.isObsecure,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle:
                    TextStyle(color: const Color(0xff1F1F1F).withOpacity(0.41)),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                suffix: widget.trailing),
          ),
        ),
      ],
    );
  }
}