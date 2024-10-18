import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findrobe_app/models/user.dart';

class PostrobeComment {
  final String commentId;
  final String content;
  final String userId;
  final String postId;
  final Timestamp commentedAt;
  FindrobeUser? user;

  PostrobeComment({
    required this.commentId,
    required this.content,
    required this.userId,
    required this.postId,
    required this.commentedAt,
    this.user
  });

  Map<String, dynamic> toMap() {
    return {
      "commentId": commentId,
      "content": content,
      "userId": userId,
      "postId": postId,
      "commentedAt": commentedAt
    };
  }

  factory PostrobeComment.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> map = doc.data() as Map<String, dynamic>;

    return PostrobeComment(
      commentId: map["commentId"],
      content: map["content"],
      userId: map["userId"],
      postId: map["postId"],
      commentedAt: map["commentedAt"]
    );
  }
}