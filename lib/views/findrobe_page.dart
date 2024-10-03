import 'dart:io';

import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/widgets/findrobe_button.dart';
import 'package:findrobe_app/widgets/findrobe_header.dart';
import 'package:findrobe_app/widgets/findrobe_imagepicker.dart';
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

  // TODO: Get from saved collection
  Future<void> _pickImage(String type) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

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
                          _pickImage("Top Wear");
                        },
                        image: _topWearImage,
                      ),
                      const SizedBox(height: 5.0),
                      FindrobeImagepicker(
                        labelText: "Bottom Wear", 
                        height: 250.0,
                        onTap: () {
                          _pickImage("Bottom Wear");
                        },
                        image: _bottomWearImage,
                      ),
                      const SizedBox(height: 5.0),
                      FindrobeImagepicker(
                        labelText: "Footwear", 
                        height: 100.0,
                        onTap: () {
                          _pickImage("Footwear");
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