import 'package:findrobe_app/models/post.dart';

class PostsDataState {
  final List<FindrobePost> allPosts;
  final List<FindrobePost> userPosts;

  PostsDataState({
    required this.allPosts,
    required this.userPosts
  });

  factory PostsDataState.initial() {
    return PostsDataState(
      allPosts: [], 
      userPosts: []
    );
  }

  PostsDataState copyWith({
    List<FindrobePost>? allPosts,
    List<FindrobePost>? userPosts
  }) {
    return PostsDataState(
      allPosts: allPosts ?? this.allPosts, 
      userPosts: userPosts ?? this.userPosts
    );
  }
}