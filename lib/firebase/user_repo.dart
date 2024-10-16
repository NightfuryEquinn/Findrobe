import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findrobe_app/constants/firebase_collection.dart';
import 'package:findrobe_app/firebase/auth_repo.dart';
import 'package:findrobe_app/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserRepo {
  final _authRepo = AuthRepo();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<FindrobeUser?> fetchUserData() async {
    final user = _authRepo.getCurrentUser();

    if (user == null) {
      return null;
    }

    try {
      DocumentSnapshot doc = await usersCollection
        .doc(user.uid)
        .get();

      if (doc.exists) {
        return FindrobeUser.fromMap(doc);
      } else {
        return null;
      }
    } catch (e) {
      print("Failed to fetch user data: $e");

      return null;
    }
  }

  Future<String> uploadImage(File profilePic, String userId) async {
    try {
      final storageRef = _storage.ref().child("profilePic/$userId/image_${DateTime.now()}.jpg");
      final uploadTask = await storageRef.putFile(profilePic);
      final profilePicUrl = await uploadTask.ref.getDownloadURL();

      return profilePicUrl;
    } catch (e) {
      print("Failed to upload image: $e");
      return "";
    }
  }

  Future<void> updateProfile(String username, dynamic profilePic, String email) async {
    final user = _authRepo.getCurrentUser();

    if (user == null) {
      return;
    }

    String? profilePicUrl;

    if (profilePic is File) {
      profilePicUrl = await uploadImage(profilePic, user.uid);
    } else if (profilePic is String) {
      profilePicUrl = profilePic;
    } else {
      print("Failed to read type String and File");
      return;
    }

    try {
      DocumentReference doc = usersCollection.doc(user.uid);

      Map<String, dynamic> updatedProfile = {
        "username": username,
        "email": email,
        "profilePic": profilePicUrl
      };

      await doc.update(updatedProfile);
    } catch (e) {
      print("Failed to update profile: $e");
    }
  }

  Future<void> logoutUser() async {
    try {
      await _authRepo.logoutUser();
    } catch (e) {
      print("Failed to log out: $e");
    }
  }
}