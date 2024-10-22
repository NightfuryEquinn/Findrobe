import 'package:findrobe_app/constants/arguments.dart';
import 'package:findrobe_app/providers/findrobe_image_provider.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:findrobe_app/widgets/findrobe_button.dart';
import 'package:findrobe_app/widgets/findrobe_header.dart';
import 'package:findrobe_app/widgets/findrobe_imagepicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class FindrobePage extends ConsumerStatefulWidget {
  const FindrobePage({super.key});

  @override
  ConsumerState<FindrobePage> createState() => _FindrobePageState();
}

class _FindrobePageState extends ConsumerState<FindrobePage> {
  void _showImageSourceDialog(BuildContext context, String type) {
    showModalBottomSheet(
      backgroundColor: AppColors.white,
      context: context, 
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0), 
          topRight: Radius.circular(10.0)
        )
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0), 
                    topRight: Radius.circular(10.0)
                  ),
                ),
                leading: const Icon(
                  CupertinoIcons.camera,
                  size: 24.0,
                  color: AppColors.black,
                ),
                title: Text(
                  "Camera",
                  style: AppFonts.forum16black,
                ),
                onTap: () {
                  ref.read(findrobeImageProvider.notifier).pickImageFromPhone(type, ImageSource.camera);
                  Navigator.of(context).pop();
                }
              ),
              ListTile(
                leading: const Icon(
                  CupertinoIcons.photo,
                  size: 24.0,
                  color: AppColors.black,
                ),
                title: Text(
                  "Gallery",
                  style: AppFonts.forum16black,
                ),
                onTap: () {
                  ref.read(findrobeImageProvider.notifier).pickImageFromPhone(type, ImageSource.gallery);
                  Navigator.of(context).pop();
                }
              ),
              ListTile(
                leading: const Icon(
                  CupertinoIcons.collections,
                  size: 24.0,
                  color: AppColors.black,
                ),
                title: Text(
                  "My Collection",
                  style: AppFonts.forum16black,
                ),
                onTap: () {
                  Navigator.of(context).pop();

                  Navigator.pushNamed(
                    context,
                    "/collection",
                    arguments: CollectionArgs(
                      type: type,
                      isFromCollection: true,
                    )
                  );
                }
              ),
            ],
          )
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final findrobeImage = ref.watch(findrobeImageProvider);

    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const FindrobeHeader(headerTitle: "Findrobe"),
              const SizedBox(height: 30.0),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FindrobeImagepicker(
                        labelText: "Top Wear", 
                        height: 200.0,
                        onTap: () {
                          _showImageSourceDialog(context, "Top Wear");
                          print(findrobeImage.topWearImage);
                        },
                        image: findrobeImage.topWearImage,
                      ),
                      const SizedBox(height: 5.0),
                      FindrobeImagepicker(
                        labelText: "Bottom Wear", 
                        height: 250.0,
                        onTap: () {
                          _showImageSourceDialog(context, "Bottom Wear");
                        },
                        image: findrobeImage.bottomWearImage,
                      ),
                      const SizedBox(height: 5.0),
                      FindrobeImagepicker(
                        labelText: "Footwear", 
                        height: 150.0,
                        onTap: () {
                          _showImageSourceDialog(context, "Footwear");
                        },
                        image: findrobeImage.footwearImage,
                        boxfit: BoxFit.cover,
                      ),
                      const SizedBox(height: 10.0),
                      FindrobeButton(
                        buttonText: "View Collection", 
                        onPressed: () => Navigator.pushNamed(
                          context, 
                          "/collection",
                          arguments: CollectionArgs(
                            isFromCollection: false,
                            type: ""
                          )
                        )
                      )
                    ],
                  )
                )
              )
            ]
          ) 
        )
      )
    );
  }
}