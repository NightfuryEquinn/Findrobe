import 'package:cloud_firestore/cloud_firestore.dart';

class PostrobeComment {
  final String commentId;
  final String content;
  final String userId;
  final String postId;

  const PostrobeComment({
    required this.commentId,
    required this.content,
    required this.userId,
    required this.postId
  });

  Map<String, dynamic> toMap() {
    return {
      "commentId": commentId,
      "content": content,
      "userId": userId,
      "postId": postId
    };
  }

  factory PostrobeComment.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> map = doc.data() as Map<String, dynamic>;

    return PostrobeComment(
      commentId: map["commentId"],
      content: map["content"],
      userId: map["userId"],
      postId: map["postId"]
    );
  }
}