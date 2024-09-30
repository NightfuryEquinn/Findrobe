import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:flutter/material.dart';

class FindrobeButton extends StatelessWidget {
  final String buttonText;
  final double width;
  final Color buttonColor;
  final VoidCallback onPressed;

  const FindrobeButton({
    super.key,
    required this.buttonText,
    this.width = double.infinity,
    this.buttonColor = AppColors.beige,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          overlayColor: AppColors.grey,
          minimumSize: const Size(double.infinity, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
        ),
        child: Text(
          buttonText,
          style: AppFonts.forum16black,
        ),
      ),
    );
  }
}