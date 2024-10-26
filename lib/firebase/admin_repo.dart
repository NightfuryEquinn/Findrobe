import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findrobe_app/constants/firebase_collection.dart';
import 'package:findrobe_app/firebase/auth_repo.dart';
import 'package:findrobe_app/models/comment.dart';
import 'package:findrobe_app/models/post.dart';
import 'package:findrobe_app/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AdminRepo {
  final AuthRepo authRepo = AuthRepo();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<FindrobeUser>> fetchAllUsers() async {
    try {
      QuerySnapshot querySnapshot = await usersCollection
        .where("role", isEqualTo: "user")
        .get();

      List<FindrobeUser> users = await Future.wait(querySnapshot.docs.map((doc) async {
        return FindrobeUser.fromMap(doc);
      }).toList());

      return users;
    } catch (e) {
      print("Failed to fetch all users: $e");
      return [];
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
      print("Failed to fetch all users: $e");
      return [];
    }
  }

  Future<bool> restrictUser(String userId) async {
    try {
      DocumentReference doc = usersCollection.doc(userId);

      Map<String, dynamic> updated = {
        "isRestricted": true
      };

      await doc.update(updated);
      return true;
    } catch (e) {
      print("Failed to restrict users: $e");
      return false;
    }
  }

  Future<bool> unrestrictUser(String userId) async {
    try {
      DocumentReference doc = usersCollection.doc(userId);

      Map<String, dynamic> updated = {
        "isRestricted": false
      };

      await doc.update(updated);
      return true;
    } catch (e) {
      print("Failed to restrict users: $e");
      return false;
    }
  }

  Future<int> fetchAllComments() async {
    try {
      int totalComments = 0;

      QuerySnapshot commentsSnapshot = await _firestore.collectionGroup(commentsInPostCollection).get();

      totalComments = commentsSnapshot.size;

      return totalComments;
    } catch (e) {
      print("Failed to fetch all users: $e");
      return 0;
    }
  }

  Future<int> fetchAllClothings() async {
    try {
      int totalClothings = 0;

      QuerySnapshot clothingSnapshot = await _firestore.collectionGroup(categoryInClothingCollection).get();

      totalClothings = clothingSnapshot.size;
      
      return totalClothings;
    } catch (e) {
      print("Failed to fetch all users: $e");
      return 0;
    }
  }

  Future<int> fetchAllLikes() async {
    try {
      int totalLikes = 0;

      QuerySnapshot likeSnapshot = await _firestore.collectionGroup(likedInPostCollection).get();

      totalLikes += likeSnapshot.size;
      
      return totalLikes;
    } catch (e) {
      print("Failed to fetch all users: $e");
      return 0;
    }
  }

  Future<Map<String, int>> fetchAllClothingsByMonth() async {
    Map<String, int> clothings = {};

    try {
      QuerySnapshot querySnapshot = await _firestore.collectionGroup(categoryInClothingCollection).get();

      for (var doc in querySnapshot.docs) {
        Timestamp createdAt = doc["createdAt"];
        DateTime date = createdAt.toDate();

        String monthKey = "${date.year}-${date.month.toString().padLeft(2, '0')}";
        clothings.update(monthKey, (index) => index + 1, ifAbsent: () => 1);
      }

      return clothings;
    } catch (e) {
      print("Failed to fetch clothings by month: $e");
      return {};
    }
  }

  Future<Map<String, int>> fetchAllUsersByMonth() async {
    Map<String, int> users = {};

    try {
      QuerySnapshot querySnapshot = await usersCollection
        .where("role", isEqualTo: "user")
        .get();

      for (var doc in querySnapshot.docs) {
        Timestamp dateRegistered = doc["dateRegistered"];
        DateTime date = dateRegistered.toDate();

        String monthKey = "${date.year}-${date.month.toString().padLeft(2, '0')}";
        users.update(monthKey, (index) => index + 1, ifAbsent: () => 1);
      }

      return users;
    } catch (e) {
      print("Failed to fetch users by month: $e");
      return {};
    }
  }

  Future<Map<String, int>> fetchAllPostsByMonth() async {
    Map<String, int> posts = {};

    try {
      QuerySnapshot querySnapshot = await postsCollection.get();

      for (var doc in querySnapshot.docs) {
        Timestamp createdAt = doc["createdAt"];
        DateTime date = createdAt.toDate();

        String monthKey = "${date.year}-${date.month.toString().padLeft(2, '0')}";
        posts.update(monthKey, (index) => index + 1, ifAbsent: () => 1);
      }

      return posts;
    } catch (e) {
      print("Failed to fetch users by month: $e");
      return {};
    }
  }

  Future<Map<String, int>> fetchAllCommentsByMonth() async {
    Map<String, int> comments = {};

    try {
      QuerySnapshot querySnapshot = await _firestore.collectionGroup(commentsInPostCollection).get();

      for (var doc in querySnapshot.docs) {
        Timestamp commentedAt = doc["commentedAt"];
        DateTime date = commentedAt.toDate();

        String monthKey = "${date.year}-${date.month.toString().padLeft(2, '0')}";
        comments.update(monthKey, (index) => index + 1, ifAbsent: () => 1);
      }

      return comments;
    } catch (e) {
      print("Failed to fetch users by month: $e");
      return {};
    }
  }
}