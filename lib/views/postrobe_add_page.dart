import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:findrobe_app/widgets/findrobe_button.dart';
import 'package:findrobe_app/widgets/findrobe_header.dart';
import 'package:findrobe_app/widgets/findrobe_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostrobeAddPage extends StatefulWidget {
  const PostrobeAddPage({super.key});

  @override
  State<PostrobeAddPage> createState() => _PostrobeAddPageState();
}

class _PostrobeAddPageState extends State<PostrobeAddPage> {
  final ImagePicker picker = ImagePicker();
  List<XFile> imageFiles = [];
  Set<String> imageHashes = {};
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController contentCtrl = TextEditingController();

  // Helper function to calculate hash
  Future<String> calculateHash(File file) async {
    final bytes = await file.readAsBytes();
    return md5.convert(bytes).toString();
  }

  Future<void> pickImages() async {
    // ignore: unnecessary_nullable_for_final_variable_declarations
    final List<XFile>? pickedImages = await picker.pickMultiImage();

    if (pickedImages != null) {
      for (XFile image in pickedImages) {
        File imageFile = File(image.path);
        String imageHash = await calculateHash(imageFile);

        if (!imageHashes.contains(imageHash)) {
          setState(() {
            imageFiles.add(image);
            imageHashes.add(imageHash);
          });
        }
      }
    }
  }

  void removeImage(int index) async {
    File imageFile = File(imageFiles[index].path);
    String imageHash = await calculateHash(imageFile);

    setState(() {
      imageFiles.removeAt(index);
      imageHashes.remove(imageHash);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const FindrobeHeader(headerTitle: "Create Post"),
              const SizedBox(height: 30.0),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FindrobeTextfield(labelText: "Title", controller: titleCtrl),
                      const SizedBox(height: 20.0),
                      FindrobeTextfield(labelText: "Content", controller: contentCtrl, isMultiline: true),
                      const SizedBox(height: 20.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Image (Optional)",
                            style: AppFonts.poiret16,
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 5.0),
                          imageFiles.isEmpty ? 
                            Material(
                              color: AppColors.black,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0))
                              ),
                              child: InkWell(
                                onTap: () {
                                  pickImages();
                                },
                                splashColor: AppColors.overlayBeige,
                                borderRadius: BorderRadius.circular(10.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Center(
                                      child: Text(
                                        "Select Images",
                                        style: AppFonts.poiret20,
                                      )
                                    )
                                  )
                                )
                              )
                            )
                          : 
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: imageFiles.length + 1,
                                itemBuilder: (context, index) {
                                  if (index < imageFiles.length) {
                                    return Stack(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10.0),
                                            child: Image.file(
                                              File(imageFiles[index].path),
                                              fit: BoxFit.cover,
                                              width: 200,
                                              height: 200
                                            )
                                          ),
                                        ),
                                        Positioned(
                                          top: 5,
                                          right: 15,
                                          child: Material(
                                            color: AppColors.grey,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(5.0))
                                            ),
                                            child: InkWell(
                                              borderRadius: BorderRadius.circular(5.0),
                                              onTap: () {
                                                removeImage(index);
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.all(7.5),
                                                child: Icon(
                                                  CupertinoIcons.delete,
                                                  color: AppColors.white,
                                                  size: 20.0,  
                                                ),
                                              )
                                            ),
                                          ),
                                        ),
                                      ]
                                    );
                                  } else {
                                    return SizedBox( 
                                      width: 100,
                                      child: Material(
                                        color: AppColors.black,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            pickImages();
                                          },
                                          splashColor: AppColors.overlayBeige,
                                          borderRadius: BorderRadius.circular(10.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10.0),
                                              child: Center(
                                                child: Text(
                                                  "Select Images",
                                                  style: AppFonts.poiret20,
                                                  textAlign: TextAlign.center,
                                                )
                                              )
                                            )
                                          )
                                        )
                                      )
                                    );
                                  }
                                },
                              ),
                            )
                        ]
                      ),
                      const SizedBox(height: 30),
                      FindrobeButton(
                        buttonText: "Publish", 
                        onPressed: () {

                        }
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