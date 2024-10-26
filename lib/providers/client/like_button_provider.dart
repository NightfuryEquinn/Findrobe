import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findrobe_app/constants/firebase_collection.dart';
import 'package:findrobe_app/constants/states.dart';
import 'package:findrobe_app/providers/client/auth_data_provider.dart';
import 'package:findrobe_app/providers/client/post_data_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LikeButtonNotifier extends StateNotifier<LikeButtonState> {
  final String postId;
  final String userId;

  LikeButtonNotifier({
    required this.postId,
    required this.userId,
    required int initialCount,
  }) : super(
    LikeButtonState(
      isLiked: false,
      likeCount: initialCount
    )
  ) {
    _checkIfLiked();
  }

  Future<void> _checkIfLiked() async {
    DocumentSnapshot likeDoc = await postsCollection
      .doc(postId)
      .collection(likedInPostCollection)
      .doc(userId)
      .get();
    
    if (likeDoc.exists) {
      state = LikeButtonState(isLiked: true, likeCount: state.likeCount);
    }
  }

  Future<void> toggleLike(WidgetRef ref, String userId, String postId) async {
    await ref.read(postDataNotifierProvider.notifier).toggleLike(userId, postId);

    if (state.isLiked) {
      state = LikeButtonState(isLiked: false, likeCount: state.likeCount - 1);
    } else {
      state = LikeButtonState(isLiked: true, likeCount: state.likeCount + 1);
    }
  }
}

final likeButtonProvider = StateNotifierProvider.family<LikeButtonNotifier, LikeButtonState, String>((ref, postId) {
  final currentUser = ref.watch(authDataNotifierProvider);
  final initialCount = ref.watch(initialLikeCountProvider(postId))
    .maybeWhen(
      data: (likeCount) => likeCount,
      orElse: () => 0
    );
  
  return LikeButtonNotifier(
    postId: postId,
    userId: currentUser.user!.uid,
    initialCount: initialCount
  );
});

final initialLikeCountProvider = FutureProvider.family<int, String>((ref, postId) async {
  CollectionReference likesRef = postsCollection.doc(postId).collection(likedInPostCollection);
  QuerySnapshot likesSnapshot = await likesRef.get();

  return likesSnapshot.docs.length;
});