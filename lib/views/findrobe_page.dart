import 'dart:io';

import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:findrobe_app/widgets/findrobe_button.dart';
import 'package:findrobe_app/widgets/findrobe_header.dart';
import 'package:findrobe_app/widgets/findrobe_imagepicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FindrobePage extends StatefulWidget {
  const FindrobePage({super.key});

  @override
  State<FindrobePage> createState() => _FindrobePageState();
}

class _FindrobePageState extends State<FindrobePage> {
  final ImagePicker _picker = ImagePicker();
  File? _topWearImage;
  File? _bottomWearImage;
  File? _shoesImage;

  Future<void> _pickImage(String type, ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        if (type == "Top Wear") {
          _topWearImage = File(pickedFile.path);
        } else if (type == "Bottom Wear") {
          _bottomWearImage = File(pickedFile.path);
        } else if (type == "Footwear") {
          _shoesImage = File(pickedFile.path);
        }
      });
    }
  }

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
                  _pickImage(type, ImageSource.camera);
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
                  _pickImage(type, ImageSource.gallery);
                  Navigator.of(context).pop();
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
                        },
                        image: _topWearImage,
                      ),
                      const SizedBox(height: 5.0),
                      FindrobeImagepicker(
                        labelText: "Bottom Wear", 
                        height: 250.0,
                        onTap: () {
                          _showImageSourceDialog(context, "Bottom Wear");
                        },
                        image: _bottomWearImage,
                      ),
                      const SizedBox(height: 5.0),
                      FindrobeImagepicker(
                        labelText: "Footwear", 
                        height: 100.0,
                        onTap: () {
                          _showImageSourceDialog(context, "Footwear");
                        },
                        image: _shoesImage,
                        boxfit: BoxFit.cover,
                      ),
                      const SizedBox(height: 30.0),
                      FindrobeButton(
                        buttonText: "View Collection", 
                        onPressed: () => Navigator.pushNamed(context, "/collection")
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