import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findrobe_app/models/comment.dart';
import 'package:findrobe_app/models/like.dart';
import 'package:findrobe_app/models/user.dart';

class FindrobePost {
  final String postId;
  final String title;
  final String body;
  final Timestamp createdAt;
  final String userId;
  List<String>? imageUrls; // Optional, not saved in Firestore
  List<PostrobeComment>? comments; // Optional, not saved in Firestore
  List<PostrobeLike>? likes; // Optional, not saved in Firestore
  FindrobeUser? user; // Optional, not saved in Firestore

  FindrobePost({
    required this.postId,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.userId,
    this.imageUrls,
    this.comments,
    this.likes,
    this.user,
  });

  Map<String, dynamic> toMap() {
    return {
      "postId": postId,
      "title": title,
      "body": body,
      "createdAt": createdAt,
      "userId": userId,
      "comments": comments
    };
  }

  factory FindrobePost.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
    
    return FindrobePost(
      postId: map["postId"], 
      title: map["title"], 
      body: map["body"], 
      createdAt: map["createdAt"],
      userId: map["userId"]
    );
  }
}