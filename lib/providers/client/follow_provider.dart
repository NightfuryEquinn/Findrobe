import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findrobe_app/constants/firebase_collection.dart';
import 'package:findrobe_app/constants/states.dart';
import 'package:findrobe_app/models/user.dart';
import 'package:findrobe_app/providers/client/auth_data_provider.dart';
import 'package:findrobe_app/providers/client/user_data_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FollowNotifier extends StateNotifier<FollowState> {
  final String currentUserId;
  final String followUserId;

  FollowNotifier({
    required this.currentUserId,
    required this.followUserId,
    required int followersCount,
    required bool isFollowing,
    required List<FindrobeUser> followers,
  }) : super(
    FollowState(
      followersCount: followersCount, 
      isFollowing: isFollowing,
      followers: followers
    )
  ) {
    _checkIfFollowed();
    fetchFollowers(currentUserId);
  }

  Future<void> _checkIfFollowed() async {
    try {
      DocumentSnapshot followDoc = await usersCollection
      .doc(followUserId)
      .collection(followersInUserCollection)
      .doc(currentUserId)
      .get();

      if (followDoc.exists) {
        state = state.copyWith(isFollowing: true);
      } else {
        state = state.copyWith(isFollowing: false);
      }
    } catch (e) {
      print("Failed to check following status: $e");
    }
  }

  Future<void> fetchFollowers(String userId) async {
    QuerySnapshot followersSnapshot = await usersCollection
      .doc(userId)
      .collection(followersInUserCollection)
      .get();

    List<String> followers = followersSnapshot.docs.map((followDoc) {
      return followDoc.id;
    }).toList();

    List<FindrobeUser> followersDetail = [];
    for (String follower in followers) {
      DocumentSnapshot followerDoc = await usersCollection.doc(follower).get();

      if (followerDoc.exists) {
        followersDetail.add(FindrobeUser.fromMap(followerDoc));
      }
    }

    state = state.copyWith(
      followers: followersDetail,
      followersCount: followersDetail.length
    );
  }

  Future<void> followUser(WidgetRef ref) async {
    await ref.read(userDataNotifierProvider.notifier).followUser(currentUserId, followUserId);

    state = state.copyWith(
      isFollowing: true,
      followersCount: state.followersCount + 1
    );
  }

  Future<void> unfollowUser(WidgetRef ref) async {
    await ref.read(userDataNotifierProvider.notifier).unfollowUser(currentUserId, followUserId);

    state = state.copyWith(
      isFollowing: false,
      followersCount: state.followersCount - 1
    );
  }
}

final followNotifierProvider = StateNotifierProvider.family<FollowNotifier, FollowState, String?>((ref, followUserId) {
  final currentUserId = ref.watch(authDataNotifierProvider)?.uid;

  return FollowNotifier(
    currentUserId: currentUserId!, 
    followUserId: followUserId ?? "", 
    followersCount: 0, 
    isFollowing: false,
    followers: []
  );
});