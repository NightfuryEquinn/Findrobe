import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findrobe_app/constants/firebase_collection.dart';
import 'package:findrobe_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<FindrobeUser?> registerNewUser(String email, String password, String username) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );

      User? user = userCredential.user;

      if (user != null) {
        FindrobeUser findrobeUser = FindrobeUser(
          userId: user.uid, 
          username: username, 
          password: password, 
          email: email, 
          dateRegistered: Timestamp.fromDate(DateTime.now()), 
          profilePic: ""
        );

        await usersCollection
          .doc(user.uid)
          .set(findrobeUser.toMap());

        return findrobeUser;
      }
    } on FirebaseAuthException catch (e) {
      print("Firebase register error: ${e.message}");
    } catch (e) {
      print("Error registering user: $e");
    }
    
    return null;
  }

  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );

      User? user = userCredential.user;

      return user;
    } on FirebaseAuthException catch (e) {
      print("Firebase sign in error: ${e.message}");
    } catch (e) {
      print("Error signing in: $e");
    }

    return null;
  }

  Future<bool> checkAdminStatus(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await usersCollection
        .doc(userId)
        .get();

      if (userSnapshot.exists) {
        String role = FindrobeUser.fromMap(userSnapshot).role;

        if (role == "admin") {
          return true;
        } else if (role == "user") {
          return false;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print("Error checking admin status: $e");
      return false;
    }
  }

  Future<bool> checkRestricted(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await usersCollection
        .doc(userId)
        .get();
      
      if (userSnapshot.exists) {
        bool isRestricted = FindrobeUser.fromMap(userSnapshot).isRestricted;

        if (isRestricted) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print("Error checking restricted: $e");
      return false;
    }
  }

  Future<void> logoutUser() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      print("Firebase logout error: ${e.message}");
    } catch (e) {
      print("Error logout: $e");
    }
  }
}