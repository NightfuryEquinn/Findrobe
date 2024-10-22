import 'dart:io';

import 'package:findrobe_app/constants/arguments.dart';
import 'package:findrobe_app/global/text_formatter.dart';
import 'package:findrobe_app/providers/add_image_provider.dart';
import 'package:findrobe_app/providers/auth_data_provider.dart';
import 'package:findrobe_app/providers/collection_data_provider.dart';
import 'package:findrobe_app/providers/dropdown_provider.dart';
import 'package:findrobe_app/providers/loading_provider.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:findrobe_app/widgets/findrobe_button.dart';
import 'package:findrobe_app/widgets/findrobe_dropdown.dart';
import 'package:findrobe_app/widgets/findrobe_header.dart';
import 'package:findrobe_app/widgets/findrobe_imagepicker.dart';
import 'package:findrobe_app/widgets/findrobe_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class CollectionAddPage extends ConsumerStatefulWidget {
  final EditCollectionArgs? args;

  const CollectionAddPage({
    super.key,
    this.args
  });

  @override
  ConsumerState<CollectionAddPage> createState() => _CollectionAddPageState();
}

class _CollectionAddPageState extends ConsumerState<CollectionAddPage> {
  late TextEditingController nameCtrl;

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.args?.clothing.name ?? "");

    Future.microtask(() {
      ref.read(addImageProvider.notifier).state = null;
      ref.read(dropdownProvider.notifier).selectItem(null);

      if (widget.args!.clothing.image.isNotEmpty) {
        ref.read(addImageProvider.notifier).state = widget.args!.clothing.image;
      }
    });
  }

  Future<void> _pickImage(WidgetRef ref, ImageSource source, ImagePicker picker) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      ref.read(addImageProvider.notifier).state = File(pickedFile.path);
    }
  }

  void _showImageSourceDialog(BuildContext context, WidgetRef ref, ImagePicker picker) {
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
                  _pickImage(ref, ImageSource.camera, picker);
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
                  _pickImage(ref, ImageSource.gallery, picker);
                  Navigator.of(context).pop();
                }
              ),
            ],
          )
        );
      }
    );
  }

  Future<void> _addClothing(BuildContext context, WidgetRef ref, String name, String category, File image, String userId) async {
    ref.read(loadingProvider.notifier).show();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.beige,
          content: Text(
            "Name is required!",
            style: AppFonts.forum16black,
          ),
          duration: const Duration(seconds: 3)
        )
      );

      return;
    }

    if (category.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.beige,
          content: Text(
            "Category is required!",
            style: AppFonts.forum16black,
          ),
          duration: const Duration(seconds: 3)
        )
      );

      return;
    }

    bool fileExists = await image.exists();
    if (!fileExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.beige,
          content: Text(
            "Image is required!",
            style: AppFonts.forum16black,
          ),
          duration: const Duration(seconds: 3)
        )
      );

      return;
    }

    final bool added = await ref.read(collectionDataNotifierProvider.notifier).addClothing(name, category, image, userId);

    if (added) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.beige,
          content: Text(
            "Your clothing is recorded!",
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
            "Failed to record your clothing. Please try again!",
            style: AppFonts.forum16black,
          ),
          duration: const Duration(seconds: 3)
        )
      );
    }

    ref.read(loadingProvider.notifier).hide();
  }

  Future<void> _updateClothing(BuildContext context, WidgetRef ref, String clothingId, String name, String category, dynamic image, String userId) async {
    ref.read(loadingProvider.notifier).show();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.beige,
          content: Text(
            "Name is required!",
            style: AppFonts.forum16black,
          ),
          duration: const Duration(seconds: 3)
        )
      );

      return;
    }

    if (image is File) {
      bool fileExists = await image.exists();
      if (!fileExists) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.beige,
            content: Text(
              "Image is required!",
              style: AppFonts.forum16black,
            ),
            duration: const Duration(seconds: 3)
          )
        );

        return;
      }
    }

    if (image is String && image.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.beige,
          content: Text(
            "Image is required!",
            style: AppFonts.forum16black,
          ),
          duration: const Duration(seconds: 3)
        )
      );

      return;
    }

    final bool updated = await ref.read(collectionDataNotifierProvider.notifier).updateClothing(clothingId, name, category, image, userId);

    if (updated) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.beige,
          content: Text(
            "Your clothing is updated!",
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
            "Failed to update your clothing. Please try again!",
            style: AppFonts.forum16black,
          ),
          duration: const Duration(seconds: 3)
        )
      );
    }

    ref.read(loadingProvider.notifier).hide();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(authDataNotifierProvider);
    
    final ImagePicker picker = ImagePicker();

    final selectedValue = ref.watch(dropdownProvider);
    final newAddImage = ref.watch(addImageProvider);
      
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              widget.args?.clothing == null ?
                const FindrobeHeader(headerTitle: "Add New")
              :
                const FindrobeHeader(headerTitle: "Edit Exist"),
              const SizedBox(height: 30.0),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FindrobeTextfield(labelText: "Name", controller: nameCtrl),
                      const SizedBox(height: 20.0),
                      widget.args?.clothing == null ?
                        const Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: FindrobeDropdown(labelText: "Category"),
                        )
                      :
                        const SizedBox.shrink(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Image",
                            style: AppFonts.poiret16,
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 5.0),
                          FindrobeImagepicker(
                            labelText: "Add New", 
                            height: 325.0,
                            onTap: () {
                              _showImageSourceDialog(context, ref, picker);
                            },
                            image: newAddImage,
                          ),
                        ],
                      ),
                      const SizedBox(height: 40.0),
                      widget.args?.clothing == null ?
                        FindrobeButton(
                          buttonText: "Add to Collection", 
                          onPressed: () {
                            _addClothing(
                              context, 
                              ref, 
                              nameCtrl.text, 
                              formatFindrobeCollection(category: selectedValue!), 
                              newAddImage!, 
                              currentUser!.uid
                            );

                            nameCtrl.text = "";
                            ref.read(dropdownProvider.notifier).selectItem(null);
                            ref.read(addImageProvider.notifier).state = null;
                          }
                        )
                      :
                        FindrobeButton(
                          buttonText: "Update Collection", 
                          onPressed: () {
                            _updateClothing(
                              context, 
                              ref, 
                              widget.args!.clothing.clothingId,
                              nameCtrl.text, 
                              widget.args!.clothing.category, 
                              newAddImage, 
                              currentUser!.uid
                            );

                            nameCtrl.text = "";
                            ref.read(dropdownProvider.notifier).selectItem(null);
                            ref.read(addImageProvider.notifier).state = null;
                          }
                        )
                    ]
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