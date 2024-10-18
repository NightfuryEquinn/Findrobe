import 'package:findrobe_app/models/post.dart';

class PostsDataState {
  final List<FindrobePost> allPosts;
  final List<FindrobePost> userPosts;
  final int userCommentCount;

  PostsDataState({
    required this.allPosts,
    required this.userPosts,
    required this.userCommentCount
  });

  factory PostsDataState.initial() {
    return PostsDataState(
      allPosts: [], 
      userPosts: [],
      userCommentCount: 0
    );
  }

  PostsDataState copyWith({
    List<FindrobePost>? allPosts,
    List<FindrobePost>? userPosts,
    int? userCommentCount
  }) {
    return PostsDataState(
      allPosts: allPosts ?? this.allPosts, 
      userPosts: userPosts ?? this.userPosts,
      userCommentCount: userCommentCount ?? this.userCommentCount
    );
  }
}