import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:flutter/material.dart';

class CollectionHeader extends StatelessWidget {
  final String headerText;

  const CollectionHeader({
    super.key,
    required this.headerText
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Text(
        headerText,
        style: AppFonts.poiret20
      )
    );
  }
}