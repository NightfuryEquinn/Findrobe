import 'package:cloud_firestore/cloud_firestore.dart';

class PostrobeLike {
  final int likeId;
  final int userId;
  final int postId;

  const PostrobeLike({
    required this.likeId,
    required this.userId,
    required this.postId
  });

  Map<String, dynamic> toMap() {
    return {
      "likeId": likeId,
      "userId": userId,
      "postId": postId
    };
  }

  factory PostrobeLike.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> map = doc.data() as Map<String, dynamic>;

    return PostrobeLike(
      likeId: map["likeId"],
      userId: map["userId"],
      postId: map["postId"]
    );
  }
}