import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:flutter/material.dart';

class FindrobeHeader extends StatelessWidget {
  final String headerTitle;

  const FindrobeHeader({
    super.key,
    required this.headerTitle
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Image.asset(
          "assets/minimal_logo.png",
          width: 75,
          height: 75,
        ),
        const SizedBox(width: 30),
        Text(
          headerTitle,
          style: AppFonts.poiret40,
        )
      ],
    );
  }
}