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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<FindrobePost?> fetchSinglePost(String postId) async {
    try {
      DocumentReference postRef = postsCollection.doc(postId);
      QuerySnapshot commentsSnapshot = await postRef.collection(commentsInPostCollection).get();
      QuerySnapshot likesSnapshot = await postRef.collection(likedInPostCollection).get();

      DocumentSnapshot postSnapshot = await postRef.get();
      FindrobePost thePost = FindrobePost.fromMap(postSnapshot);

      List<PostrobeComment> comments = [];
      for (var commentDoc in commentsSnapshot.docs) {
        String userId = commentDoc["userId"];
        DocumentSnapshot userDoc = await usersCollection.doc(userId).get();
        
        PostrobeComment comment = PostrobeComment.fromMap(commentDoc);
        comment.user = FindrobeUser.fromMap(userDoc);

        comments.add(comment);
      }
      comments.sort((a, b) => b.commentedAt.compareTo(a.commentedAt));

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

        CollectionReference commentsCollection = doc.reference.collection(commentsInPostCollection);
        QuerySnapshot commentsSnapshot = await commentsCollection.get();

        List<PostrobeComment> comments = commentsSnapshot.docs.map((commentDoc) {
          return PostrobeComment.fromMap(commentDoc);
        }).toList();
        comments.sort((a, b) => b.commentedAt.compareTo(a.commentedAt));

        post.comments = comments;

        return post;
      }).toList());

      posts.sort((a, b) => b.createdAt.compareTo(a.createdAt));

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

        CollectionReference commentsCollection = doc.reference.collection(commentsInPostCollection);
        QuerySnapshot commentsSnapshot = await commentsCollection.get();

        List<PostrobeComment> comments = commentsSnapshot.docs.map((commentDoc) {
          return PostrobeComment.fromMap(commentDoc);
        }).toList();
        comments.sort((a, b) => b.commentedAt.compareTo(a.commentedAt));

        post.comments = comments;

        return post;
      }).toList());

      posts.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return posts;
    } catch (e) {
      print("Failed to fetch user posts: $e");

      return [];
    }
  }

  Future<int> fetchCommentCountByUserId(String userId) async {
    try {
      QuerySnapshot postSnapshot = await postsCollection.get();

      int commentCount = 0;

      for (QueryDocumentSnapshot postDoc in postSnapshot.docs) {
        CollectionReference commentsCollection = postDoc.reference.collection(commentsInPostCollection);

        QuerySnapshot commentsSnapshot = await commentsCollection
          .where("userId", isEqualTo: userId)
          .get();

        commentCount += commentsSnapshot.size;  
    }
      
      return commentCount;
    } catch (e) {
      print("Failed to fetch user comment count: $e");
      return 0;
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

      await postRef.set(findrobePost.toMap());

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
        postId: postId,
        commentedAt: Timestamp.fromDate(DateTime.now())
      );

      await postRef
        .collection(commentsInPostCollection)
        .doc(commentRef.id)
        .set(comment.toMap());

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

      QuerySnapshot likeSnapshot = await likeRef.get();
      List<PostrobeLike> currentLikes = likeSnapshot.docs.map((likeDoc) {
        return PostrobeLike.fromMap(likeDoc);
      }).toList();

      PostrobeLike? existingLike = currentLikes.firstWhere(
        (like) => like.userId == userId,
        orElse: () => const PostrobeLike(userId: "", postId: "")
      );

      if (existingLike.userId == userId) {
        DocumentReference likeDoc = likeRef.doc(existingLike.userId);
        await likeDoc.delete();
      } else {
        PostrobeLike like = PostrobeLike(
          userId: userId, 
          postId: postId
        );

        await likeRef.doc(userId).set(like.toMap());
      }

      return true;
    } catch (e) {
      print("Failed to toggle like: $e");
      return false;
    }
  }

  Future<bool> deletePost(String postId) async {
    try {
      DocumentReference postRef = postsCollection.doc(postId);
      CollectionReference commentsCollection = postRef.collection(commentsInPostCollection);
      QuerySnapshot commentsSnapshot = await commentsCollection.get();

      for (QueryDocumentSnapshot commentDoc in commentsSnapshot.docs) {
        await commentDoc.reference.delete();
      }

      await postRef.delete();

      return true;
    } catch (e) {
      print("Failed to delete post: $e");
      return false;
    }
  }

  Future<bool> deleteComment(String postId, String commentId) async {
    try {
      DocumentReference commentRef = postsCollection
        .doc(postId)
        .collection(commentsInPostCollection)
        .doc(commentId);

      if (commentRef.id == commentId) {
        await commentRef.delete();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Failed to delete comment: $e");
      return false;
    }
  }
}