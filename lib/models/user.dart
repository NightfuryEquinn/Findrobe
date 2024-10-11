import 'package:cloud_firestore/cloud_firestore.dart';

class FindrobeUser {
  final String userId;
  final String username;
  final String password;
  final String email;
  final Timestamp dateRegistered;
  final String profilePic;

  const FindrobeUser({
    required this.userId,
    required this.username,
    required this.password,
    required this.email,
    required this.dateRegistered,
    required this.profilePic,
  });

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "username": username,
      "password": password,
      "email": email,
      "dateRegistered": dateRegistered,
      "profilePic": profilePic
    };
  }

  factory FindrobeUser.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
    
    return FindrobeUser(
      userId: map["userId"], 
      username: map["username"], 
      password: map["password"], 
      email: map["email"], 
      dateRegistered: map["dateRegistered"], 
      profilePic: map["profilePic"]
    );
  }
}