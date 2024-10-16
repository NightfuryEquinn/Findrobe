import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:flutter/cupertino.dart';

class PostrobeEmpty extends StatelessWidget {
  final String labelText;

  const PostrobeEmpty({
    super.key,
    required this.labelText
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: AppColors.overlayBlack,
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.clear_circled,
              color: AppColors.white,
              size: 36.0,
            ),
            const SizedBox(height: 15.0),
            Text(
              labelText,
              style: AppFonts.poiret24,
            )
          ],
        )
      )
    );
  }
}