import 'package:findrobe_app/models/post.dart';
import 'package:findrobe_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthDataState {
  final User? user;
  final bool isAdmin;
  final bool isRestricted;

  AuthDataState({
    this.user,
    this.isAdmin = false,
    this.isRestricted = false
  });

  factory AuthDataState.initial() {
    return AuthDataState(
      user: null, 
      isAdmin: false,
      isRestricted: false
    );
  }

  AuthDataState copyWith({
    User? user,
    bool? isAdmin,
    bool? isRestricted,
  }) {
    return AuthDataState(
      user: user ?? this.user, 
      isAdmin: isAdmin ?? this.isAdmin,
      isRestricted: isRestricted ?? this.isRestricted
    );
  }
}

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
  final List<FindrobeUser> followers;

  FollowState({
    required this.followersCount,
    required this.isFollowing,
    required this.followers
  });

  FollowState copyWith({
    int? followersCount,
    bool? isFollowing,
    List<FindrobeUser>? followers
  }) {
    return FollowState(
      followersCount: followersCount ?? this.followersCount, 
      isFollowing: isFollowing ?? this.isFollowing,
      followers: followers ?? this.followers
    );
  }
}

class FindrobeImageState {
  final dynamic topWearImage;
  final dynamic bottomWearImage;
  final dynamic footwearImage;

  FindrobeImageState({
    this.topWearImage,
    this.bottomWearImage,
    this.footwearImage
  });

  FindrobeImageState copyWith({
    dynamic topWearImage,
    dynamic bottomWearImage,
    dynamic footwearImage
  }) {
    return FindrobeImageState(
      topWearImage: topWearImage ?? this.topWearImage,
      bottomWearImage: bottomWearImage ?? this.bottomWearImage,
      footwearImage: footwearImage ?? this.footwearImage
    );
  }
}

class AdminMonitorState {
  final List<FindrobeUser> allUsers;
  final List<FindrobePost> allPosts;
  final int allComments;
  final int allClothings;
  final int allLikes;

  AdminMonitorState({
    required this.allUsers,
    required this.allPosts,
    required this.allComments,
    required this.allClothings,
    required this.allLikes
  });

  factory AdminMonitorState.initial() {
    return AdminMonitorState(
      allUsers: [],
      allPosts: [],
      allComments: 0,
      allClothings: 0,
      allLikes: 0
    );
  }

  AdminMonitorState copyWith({
    List<FindrobeUser>? allUsers,
    List<FindrobePost>? allPosts,
    int? allComments,
    int? allClothings,
    int? allLikes,
  }) {
    return AdminMonitorState(
      allUsers: allUsers ?? this.allUsers,
      allPosts: allPosts ?? this.allPosts,
      allComments: allComments ?? this.allComments,
      allClothings: allClothings ?? this.allClothings,
      allLikes: allLikes ?? this.allLikes,
    );
  }
}