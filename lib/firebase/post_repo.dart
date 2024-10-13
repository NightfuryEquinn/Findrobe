import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findrobe_app/constants/firebase_collection.dart';
import 'package:findrobe_app/firebase/auth_repo.dart';
import 'package:findrobe_app/models/post.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PostRepo {
  final authRepo = AuthRepo();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<FindrobePost>> fetchAllPosts() async {
    try {
      QuerySnapshot querySnapshot = await postsCollection.get();

      List<FindrobePost> posts = await Future.wait(querySnapshot.docs.map((doc) async {
        FindrobePost post = FindrobePost.fromMap(doc);

        CollectionReference imageUrlsCollection = doc.reference.collection(imagesInPostCollection);
        QuerySnapshot imageUrlsSnapshot = await imageUrlsCollection.get();

        List<String> imageUrls = imageUrlsSnapshot.docs.map((imageDoc) {
          return imageDoc["imageUrl"] as String;
        }).toList();

        post.imageUrls = imageUrls;

        return post;
      }).toList());

      return posts;
    } catch (e) {
      print("Failed to fetch all posts: $e");

      return [];
    }
  }

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
      print("Failed to upload image: $e");

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
        imageUrls: [],
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
      print("Failed to create post: $e");
    }
    
    return false;
  }
}