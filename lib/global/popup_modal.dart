import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:findrobe_app/widgets/findrobe_textbutton.dart';
import 'package:flutter/material.dart';

Future<void> showPopupModal({
  required BuildContext context,
  required String title,
  required String content,
  required VoidCallback onPress
}) {
  return showDialog(
    context: context, 
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors.grey,
        title: Text(
          title,
          style: AppFonts.poiret32,
        ),
        content: Text(
          content,
          style: AppFonts.forum16white
        ),
        actions: [
          FindrobeTextbutton(
            labelText: "Cancel", 
            onPressed: () {
              Navigator.of(context).pop();
            }
          ),
          FindrobeTextbutton(
            labelText: "Confirm",
            onPressed: () {
              onPress();
              Navigator.of(context).pop();
            },
          )
        ],
      );
    }
  );
}