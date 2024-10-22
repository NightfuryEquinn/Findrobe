import 'dart:io';

import 'package:findrobe_app/constants/states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class FindrobeImageNotifier extends StateNotifier<FindrobeImageState> {
  final ImagePicker _picker = ImagePicker();

  FindrobeImageNotifier() : super(FindrobeImageState());

  Future<void> pickImageFromPhone(String type, ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      final newImage = File(pickedFile.path);

      if (type == "Top Wear") {
        state = state.copyWith(topWearImage: newImage);
      } else if (type == "Bottom Wear") {
        state = state.copyWith(bottomWearImage: newImage);
      } else if (type == "Footwear") {
        state = state.copyWith(footwearImage: newImage);
      }
    }
  }

  void pickImageFromFirebase(String type, String url) {
    if (type == "Top Wear") {
      state = state.copyWith(topWearImage: url);
    } else if (type == "Bottom Wear") {
      state = state.copyWith(bottomWearImage: url);
    } else if (type == "Footwear") {
      state = state.copyWith(footwearImage: url);
    }
  }
}

final findrobeImageProvider = StateNotifierProvider<FindrobeImageNotifier, FindrobeImageState>((ref) {
  return FindrobeImageNotifier();
});