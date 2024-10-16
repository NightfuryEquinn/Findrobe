// Show a larger image in dialog
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

void showImageDialog(BuildContext context, String imageUrl) {
  showDialog(
    context: context, 
    builder: (context) {
      return Dialog(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(10.0)
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.5,
          padding: const EdgeInsets.all(15.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: PhotoView(
              imageProvider: NetworkImage(
                imageUrl
              ),
              backgroundDecoration: const BoxDecoration(
                color: AppColors.grey
              ),
              customSize: MediaQuery.of(context).size,
              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.covered * 2.0,
              enablePanAlways: true,
            ) 
          )
        ),
      );
    }
  );
}