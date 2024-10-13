import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findrobe_app/constants/firebase_collection.dart';
import 'package:findrobe_app/firebase/auth_repo.dart';
import 'package:findrobe_app/models/post.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PostRepo {
  final authRepo = AuthRepo();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<String>> uploadImages(List<File> imageFiles, String postId) async {
    List<String> imageUrls = [];

    try {
      for (int i = 0; i < imageFiles.length; i++) {
        final storageRef = _storage.ref().child("postImages/$postId/image_${i}_${DateTime.now()}.jpg");
        final uploadTask = await storageRef.putFile(imageFiles[i]);
        final imageUrl = await uploadTask.ref.getDownloadURL();

        imageUrls.add(imageUrl);
      }
    } catch (e) {
      print("Error uploading image: $e");

      return [];
    }

    return imageUrls;
  }

  Future<bool> createPost(String title, String body, List<File> imageFiles) async {
    try {
      final postRef = postsCollection.doc();

      List<String> imageUrls = await uploadImages(imageFiles, postRef.id);

      FindrobePost findrobePost = FindrobePost(
        postId: postRef.id, 
        title: title, 
        body: body, 
        userId: authRepo.getCurrentUser()!.uid
      );

      await postRef
        .set(findrobePost.toMap());

      for (String imageUrl in imageUrls) {
        await postRef
          .collection(imagesInPostCollection)
          .add({
            "imageUrl": imageUrl,
            "uploadedAt": Timestamp.fromDate(DateTime.now())
          });
      }

      return true;
    } catch (e) {
      print("Error creating post: $e");
    }
    
    return false;
  }
}