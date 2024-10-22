import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:flutter/material.dart';

class CollectionButton extends StatelessWidget {
  final VoidCallback onTap;
  final String placeholderImage;
  final String title;
  final String punchline;

  const CollectionButton({
    super.key,
    required this.onTap,
    required this.placeholderImage,
    required this.title,
    required this.punchline
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.overlayBlack,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: InkWell(
        onTap: onTap,
        splashColor: AppColors.overlayBeige,
        borderRadius: BorderRadius.circular(10.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image(
                  image: AssetImage(placeholderImage),
                  width: 65,
                  height: 65,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 30.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppFonts.poiret20,
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    punchline,
                    style: AppFonts.forum12
                  )
                ],
              )
            ],
          )
        )
      ) 
    );
  }
}