import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:flutter/material.dart';

class FindrobeTextfield extends StatelessWidget {
  final String labelText;
  final bool isSecure;
  final bool isEmail;
  final bool isMultiline;
  final TextEditingController controller;

  const FindrobeTextfield({
    super.key,
    required this.labelText,
    this.isSecure = false,
    this.isEmail = false,
    this.isMultiline = false,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText.isNotEmpty)
          Text(
            labelText,
            style: AppFonts.poiret16,
            textAlign: TextAlign.left,
          ),
        const SizedBox(height: 5.0),
        TextFormField(
          controller: controller,
          obscureText: isSecure,
          maxLines: isMultiline ? null : 1,
          keyboardType: 
            isEmail ? TextInputType.emailAddress :
            isSecure ? TextInputType.text :
            isMultiline ? TextInputType.multiline :
            TextInputType.text,
          style: AppFonts.forum16white,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none
            ),
            filled: true,
            fillColor: AppColors.black,
          ),
          cursorColor: AppColors.beige,
        )
      ],
    );
  }
}