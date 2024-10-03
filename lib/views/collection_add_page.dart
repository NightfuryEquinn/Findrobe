import 'dart:io';

import 'package:findrobe_app/providers/add_image_provider.dart';
import 'package:findrobe_app/providers/dropdown_provider.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:findrobe_app/widgets/findrobe_button.dart';
import 'package:findrobe_app/widgets/findrobe_dropdown.dart';
import 'package:findrobe_app/widgets/findrobe_header.dart';
import 'package:findrobe_app/widgets/findrobe_imagepicker.dart';
import 'package:findrobe_app/widgets/findrobe_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class CollectionAddPage extends ConsumerWidget {
  const CollectionAddPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ImagePicker picker = ImagePicker();

    final TextEditingController nameCtrl = TextEditingController();
    final selectedValue = ref.watch(dropdownProvider);
    final newAddImage = ref.watch(addImageProvider);

    Future<void> pickImage(WidgetRef ref) async {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        ref.read(addImageProvider.notifier).state = File(pickedFile.path);
      }
    }
      
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const FindrobeHeader(headerTitle: "Add New"),
              const SizedBox(height: 30.0),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FindrobeTextfield(labelText: "Name", controller: nameCtrl),
                      const SizedBox(height: 20.0),
                      const FindrobeDropdown(labelText: "Category"),
                      const SizedBox(height: 20.0),
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
                              pickImage(ref);
                            },
                            image: newAddImage,
                          ),
                        ],
                      ),
                      const SizedBox(height: 40.0),
                      FindrobeButton(
                        buttonText: "Add to Collection", 
                        onPressed: () {
                          print("$nameCtrl.text $selectedValue");
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