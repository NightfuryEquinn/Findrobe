import 'dart:io';

import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:flutter/material.dart';

class FindrobeImagepicker extends StatelessWidget {
  final String labelText;
  final double height;
  final File? image;
  final BoxFit boxfit;
  final VoidCallback onTap;

  const FindrobeImagepicker({
    super.key,
    required this.labelText,
    required this.height,
    this.image,
    this.boxfit = BoxFit.scaleDown,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      child: InkWell(
        onTap: onTap,
        splashColor: AppColors.overlayBeige,
        borderRadius: BorderRadius.circular(10.0),
        child: SizedBox(
          height: height,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Center(
              child: image == null ?
                Text(
                  labelText,
                  style: AppFonts.poiret20,
                )
                :
                Image.file(
                  image!,
                  fit: boxfit,
                  width: double.infinity,
                )
            )
          ),
        )
      ) 
    );
  }
}