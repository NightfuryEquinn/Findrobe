import 'package:findrobe_app/constants/arguments.dart';
import 'package:findrobe_app/global/popup_modal.dart';
import 'package:findrobe_app/models/clothing.dart';
import 'package:findrobe_app/providers/collection_data_provider.dart';
import 'package:findrobe_app/providers/loading_provider.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CollectionSingleField extends ConsumerWidget {
  final FindrobeClothing clothing;

  const CollectionSingleField({
    super.key,
    required this.clothing
  });

  Future<void> _deletePost(BuildContext context, WidgetRef ref, String clothingId, String category, String userId) async {
    ref.read(loadingProvider.notifier).show();

    final bool deleted = await ref.read(collectionDataNotifierProvider.notifier).deleteClothing(clothingId, category, userId);

    if (deleted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.beige,
          content: Text(
            "Your clothing is deleted!",
            style: AppFonts.forum16black,
          ),
          duration: const Duration(seconds: 3)
        )
      );

      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.beige,
          content: Text(
            "Failed to delete your clothing. Please try again!",
            style: AppFonts.forum16black,
          ),
          duration: const Duration(seconds: 3)
        )
      );
    }

    ref.read(loadingProvider.notifier).hide();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.overlayBlack
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.network(
                clothing.image,
                width: 65,
                height: 65,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 30.0),
            Expanded(
              child: Text(
                clothing.name,
                style: AppFonts.poiret20
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                children: [
                  Material(
                    color: Colors.transparent,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(5.0),
                      onTap: () {
                        Navigator.pushNamed(
                          context, 
                          "/collection_add",
                          arguments: EditCollectionArgs(
                            clothing: clothing
                          )
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(
                          CupertinoIcons.pencil,
                          color: AppColors.white,
                          size: 20.0,  
                        ),
                      )
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Material(
                    color: Colors.transparent,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(5.0),
                      onTap: () {
                        showPopupModal(
                          context: context, 
                          title: "Delete Confirmation", 
                          content: "Are you sure you want to delete this item?", 
                          onPress: () {
                            _deletePost(
                              context, 
                              ref, 
                              clothing.clothingId, 
                              clothing.category, 
                              clothing.userId
                            );
                          }
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(
                          CupertinoIcons.delete,
                          color: AppColors.white,
                          size: 20.0,  
                        ),
                      )
                    ),
                  ),
                  const SizedBox(width: 10.0),
                ],
              ),
            )
          ],
        )
      )
    );
  }
}