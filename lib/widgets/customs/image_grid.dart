import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:flutter/material.dart';

// Build image grid
List<Widget> buildImageGrid(BuildContext context, List<String> imageUrls) {
  List<Widget> imageWidgets = [];

  for (int i = 0; i < imageUrls.length && i < 3; i++) {
    if (i == 2 && imageUrls.length > 3) {
      imageWidgets.add(
        _buildClickableImageOverlay(context, imageUrls[i], "+${imageUrls.length - 3}")
      );
    } else {
      imageWidgets.add(_buildClickableImage(context, imageUrls[i]));
      
      imageWidgets.add(
        const SizedBox(width: 15.0)
      );
    }
  }

  return imageWidgets;
}

// Clickable image to enlarge
Widget _buildClickableImage(BuildContext context, String imageUrl) {
  return InkWell(
    onTap: () {
      _showImageDialog(context, imageUrl);
    },
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Image.network(
        imageUrl,
        width: 100,
        height: 100,
        fit: BoxFit.cover
      )
    ),
  );
}

// Clickable image with overlay to open single post
Widget _buildClickableImageOverlay(BuildContext context, String imageUrl, String overlayText) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, "/postrobe_single");
    },
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.network(
            imageUrl,
            width: 100,
            height: 100,
            fit: BoxFit.cover
          )
        ),
        Positioned.fill(
          child: Container(
            color: AppColors.overlayBlack,
            child: Center(
              child: Text(
                overlayText,
                style: AppFonts.poiret20
              )
            ),
          ),
        )
      ],
    )
  );
}

// Show a larger image in dialog
void _showImageDialog(BuildContext context, String imageUrl) {
  showDialog(
    context: context, 
    builder: (context) {
      return Dialog(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(10.0)
          ),
          padding: const EdgeInsets.all(15.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            )
          )
        ),
      );
    }
  );
}