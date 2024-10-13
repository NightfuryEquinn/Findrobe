import 'package:cloud_firestore/cloud_firestore.dart';

class FindrobePost {
  final String postId;
  final String title;
  final String body;
  List<String>? imageUrls;
  final String userId;

  FindrobePost({
    required this.postId,
    required this.title,
    required this.body,
    this.imageUrls,
    required this.userId
  });

  Map<String, dynamic> toMap() {
    return {
      "postId": postId,
      "title": title,
      "body": body,
      "userId": userId,
    };
  }

  factory FindrobePost.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
    
    return FindrobePost(
      postId: map["postId"], 
      title: map["title"], 
      body: map["body"], 
      userId: map["userId"]
    );
  }
}

// Images of posts are saved within the post subcollection