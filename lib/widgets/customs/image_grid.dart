import 'package:findrobe_app/constants/arguments.dart';
import 'package:findrobe_app/global/image_modal.dart';
import 'package:findrobe_app/models/post.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:flutter/material.dart';

// Build image grid
List<Widget> buildImageGrid(BuildContext context, FindrobePost post, List<String> imageUrls) {
  List<Widget> imageWidgets = [];

  if (imageUrls.isEmpty) {
    imageWidgets.add(
      _buildClickableImageOverlay(context, post, "https://media.istockphoto.com/id/1147544807/vector/thumbnail-image-vector-graphic.jpg?s=612x612&w=0&k=20&c=rnCKVbdxqkjlcs3xH87-9gocETqpspHFXu5dIGB4wuM=", "")
    );
  } else if (imageUrls.length == 1) {
    imageWidgets.add(
      _buildClickableImageOverlay(context, post, imageUrls[0], "")
    );
  } else if (imageUrls.length == 2) {
    imageWidgets.add(_buildClickableImage(context, imageUrls[0]));

    imageWidgets.add(
      const SizedBox(width: 15.0)
    );

    imageWidgets.add(
      _buildClickableImageOverlay(context, post, imageUrls[1], "")
    );
  } else {
    for (int i = 0; i < imageUrls.length && i < 3; i++) {
      if (i == 2 && imageUrls.length >= 3) {
        imageWidgets.add(
          _buildClickableImageOverlay(context, post, imageUrls[i], "+${imageUrls.length - 3}")
        );
      } else {
        imageWidgets.add(_buildClickableImage(context, imageUrls[i]));
        
        imageWidgets.add(
          const SizedBox(width: 15.0)
        );
      }
    }
  }

  return imageWidgets;
}

// Clickable image to enlarge
Widget _buildClickableImage(BuildContext context, String imageUrl) {
  return InkWell(
    onTap: () {
      showImageDialog(context, imageUrl);
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
Widget _buildClickableImageOverlay(BuildContext context, FindrobePost post, String imageUrl, String overlayText) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(
        context, 
        "/postrobe_single",
        arguments: PostrobeSingleArgs(
          post: post
        )
      );
    },
    child: overlayText.isEmpty ?
      Stack(
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
      ) :
      ClipRRect(
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