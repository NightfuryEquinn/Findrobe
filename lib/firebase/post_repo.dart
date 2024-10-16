import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findrobe_app/constants/firebase_collection.dart';
import 'package:findrobe_app/firebase/auth_repo.dart';
import 'package:findrobe_app/models/comment.dart';
import 'package:findrobe_app/models/like.dart';
import 'package:findrobe_app/models/post.dart';
import 'package:findrobe_app/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PostRepo {
  final authRepo = AuthRepo();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<FindrobePost?> fetchSinglePost(String postId) async {
    try {
      DocumentReference postRef = postsCollection.doc(postId);
      QuerySnapshot commentsSnapshot = await postRef.collection(commentsInPostCollection).get();
      QuerySnapshot likesSnapshot = await postRef.collection(likedInPostCollection).get();

      DocumentSnapshot postSnapshot = await postRef.get();
      FindrobePost thePost = FindrobePost.fromMap(postSnapshot);

      List<PostrobeComment> comments = commentsSnapshot.docs.map((commentDoc) {
        return PostrobeComment.fromMap(commentDoc);
      }).toList();

      List<PostrobeLike> likes = likesSnapshot.docs.map((likeDoc) {
        return PostrobeLike.fromMap(likeDoc);
      }).toList();

      thePost.comments = comments;
      thePost.likes = likes;

      return thePost;
    } catch (e) {
      print("Failed to fetch single post: $e");
      return null;
    }
  }

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

        String userId = post.userId;

        DocumentSnapshot userSnapshot = await usersCollection
          .doc(userId)
          .get();

        post.user = FindrobeUser.fromMap(userSnapshot);

        return post;
      }).toList());

      return posts;
    } catch (e) {
      print("Failed to fetch all posts: $e");

      return [];
    }
  }

  Future<List<FindrobePost>> fetchPostByUserId(String userId) async {
    try {
      QuerySnapshot querySnapshot = await postsCollection
        .where("userId", isEqualTo: userId)
        .get();

      List<FindrobePost> posts = await Future.wait(querySnapshot.docs.map((doc) async {
        FindrobePost post = FindrobePost.fromMap(doc);

        CollectionReference imageUrlsCollection = doc.reference.collection(imagesInPostCollection);
        QuerySnapshot imageUrlsSnapshot = await imageUrlsCollection.get();

        List<String> imageUrls = imageUrlsSnapshot.docs.map((imageDoc) {
          return imageDoc["imageUrl"] as String;
        }).toList();

        post.imageUrls = imageUrls;

        String userId = post.userId;

        DocumentSnapshot userSnapshot = await usersCollection
          .doc(userId)
          .get();

        post.user = FindrobeUser.fromMap(userSnapshot);

        return post;
      }).toList());

      return posts;
    } catch (e) {
      print("Failed to fetch user posts: $e");

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

      return imageUrls;
    } catch (e) {
      print("Failed to upload image: $e");

      return [];
    }
  }

  Future<bool> createPost(String title, String body, List<File> imageFiles) async {
    try {
      DocumentReference postRef = postsCollection.doc();

      List<String> imageUrls = await uploadImages(imageFiles, postRef.id);

      FindrobePost findrobePost = FindrobePost(
        postId: postRef.id, 
        title: title, 
        body: body, 
        createdAt: Timestamp.fromDate(DateTime.now()),
        userId: authRepo.getCurrentUser()!.uid,
        imageUrls: [],
        user: null
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
      return false;
    }
  }

  Future<bool> commentPost(String content, String userId, String postId) async {
    try {
      DocumentReference postRef = postsCollection.doc(postId);
      DocumentReference commentRef = postRef.collection(commentsInPostCollection).doc();

      PostrobeComment comment = PostrobeComment(
        commentId: commentRef.id,
        content: content,
        userId: userId,
        postId: postId
      );

      await postRef
        .collection(commentsInPostCollection)
        .add(comment.toMap());

      return true;
    } catch (e) {
      print("Failed to comment post: $e");
      return false;
    }
  }

  Future<bool> toggleLike(String userId, String postId) async {
    try {
      DocumentReference postRef = postsCollection.doc(postId);
      CollectionReference likeRef = postRef.collection(likedInPostCollection);

      DocumentSnapshot likeSnapshot = await likeRef.doc(userId).get();

      if (likeSnapshot.exists) {
        await likeRef.doc(userId).delete();
      } else {
        DocumentReference newLikeRef = likeRef.doc();

        PostrobeLike like = PostrobeLike(
          userId: userId, 
          postId: postId
        );

        await newLikeRef.set(like.toMap());
      }

      return true;
    } catch (e) {
      print("Failed to toggle like: $e");
      return false;
    }
  }
}