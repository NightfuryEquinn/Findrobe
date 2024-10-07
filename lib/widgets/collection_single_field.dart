import 'package:findrobe_app/constants/arguments.dart';
import 'package:findrobe_app/global/popup_modal.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CollectionSingleField extends StatelessWidget {
  final String name;
  final String image;

  const CollectionSingleField({
    super.key,
    required this.name,
    required this.image
  });

  @override
  Widget build(BuildContext context) {
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
                image,
                width: 65,
                height: 65,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 30.0),
            Expanded(
              child: Text(
                name,
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
                            itemName: name
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
                            print("Deleted $name");
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