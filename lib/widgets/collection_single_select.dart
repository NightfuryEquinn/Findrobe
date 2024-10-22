import 'package:findrobe_app/models/clothing.dart';
import 'package:findrobe_app/providers/findrobe_image_provider.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CollectionSingleSelect extends ConsumerWidget {
  final String type;
  final FindrobeClothing clothing;

  const CollectionSingleSelect({
    super.key,
    required this.type,
    required this.clothing
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.overlayBlack
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Material(
          color: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(5.0),
            onTap: () {
              ref.read(findrobeImageProvider.notifier).pickImageFromFirebase(type, clothing.image);
              print(type);
              print(clothing.image);
              Navigator.of(context)
                ..pop()
                ..pop();
            },
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
              ]
            ),
          )
        )
      )
    );
  }
}