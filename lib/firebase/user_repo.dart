import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findrobe_app/constants/firebase_collection.dart';
import 'package:findrobe_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? _getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<FindrobeUser?> fetchUserData() async {
    final user = _getCurrentUser();

    if (user == null) {
      return null;
    }

    try {
      final DocumentSnapshot doc = await usersCollection.doc(user.uid).get();

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
}