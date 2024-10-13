import 'package:cloud_firestore/cloud_firestore.dart';

class FindrobeFollower {
  final int followerId;
  final int userId;

  const FindrobeFollower({
    required this.followerId,
    required this.userId
  });

  Map<String, dynamic> toMap() {
    return {
      "followerId": followerId,
      "userId": userId,
    };
  }

  factory FindrobeFollower.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> map = doc.data() as Map<String, dynamic>;

    return FindrobeFollower(
      followerId: map["followerId"],
      userId: map["userId"]
    );
  }
}