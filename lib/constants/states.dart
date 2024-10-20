import 'package:findrobe_app/models/post.dart';
import 'package:findrobe_app/models/user.dart';

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

class UserDataState {
  final FindrobeUser? currentUser;
  final FindrobeUser? otherUser;

  UserDataState({
    this.currentUser,
    this.otherUser
  });

  factory UserDataState.initial() {
    return UserDataState(
      currentUser: null,
      otherUser: null
    );
  }

  UserDataState copyWith({
    FindrobeUser? currentUser,
    FindrobeUser? otherUser
  }) {
    return UserDataState(
      currentUser: currentUser ?? this.currentUser,
      otherUser: otherUser ?? this.otherUser
    );
  }
}

class LikeButtonState {
  final bool isLiked;
  final int likeCount;

  LikeButtonState({
    required this.isLiked,
    required this.likeCount
  });
}

class FollowState {
  final int followersCount;
  final bool isFollowing;

  FollowState({
    required this.followersCount,
    required this.isFollowing
  });

  FollowState copyWith({
    int? followersCount,
    bool? isFollowing,
  }) {
    return FollowState(
      followersCount: followersCount ?? this.followersCount, 
      isFollowing: isFollowing ?? this.isFollowing
    );
  }
}