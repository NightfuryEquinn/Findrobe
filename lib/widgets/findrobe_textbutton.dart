import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:flutter/material.dart';

class FindrobeTextbutton extends StatelessWidget {
  final String labelText;
  final VoidCallback onPressed;

  const FindrobeTextbutton({
    super.key,
    required this.labelText,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        overlayColor: AppColors.beige,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
      ),
      onPressed: onPressed,
      child: Text(
        labelText,
        style: AppFonts.forum12,
      ),
    );
  }
}