import 'package:cloud_firestore/cloud_firestore.dart';

class PostrobeLike {
  final String userId;
  final String postId;

  const PostrobeLike({
    required this.userId,
    required this.postId
  });

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "postId": postId
    };
  }

  factory PostrobeLike.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> map = doc.data() as Map<String, dynamic>;

    return PostrobeLike(
      userId: map["userId"],
      postId: map["postId"]
    );
  }
}