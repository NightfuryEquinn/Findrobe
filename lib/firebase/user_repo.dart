import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findrobe_app/constants/firebase_collection.dart';
import 'package:findrobe_app/firebase/auth_repo.dart';
import 'package:findrobe_app/models/user.dart';

class UserRepo {
  final _authRepo = AuthRepo();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<FindrobeUser?> fetchUserData() async {
    final user = _authRepo.getCurrentUser();

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

  Future<void> logoutUser() async {
    try {
      await _authRepo.logoutUser();
    } catch (e) {
      print("Failed to log out: $e");
    }
  }
}