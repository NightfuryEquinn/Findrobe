class FindrobePost {
  final String postId;
  final String title;
  final String body;
  final String userId;

  const FindrobePost({
    required this.postId,
    required this.title,
    required this.body,
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

  factory FindrobePost.fromMap(Map<String, dynamic> map) {
    return FindrobePost(
      postId: map["postId"], 
      title: map["title"], 
      body: map["body"], 
      userId: map["userId"]
    );
  }
}

// Images of posts are saved within the post subcollection