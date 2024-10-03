import 'package:flutter_riverpod/flutter_riverpod.dart';

class LikeButtonState {
  final bool isLiked;
  final int likeCount;

  LikeButtonState({
    required this.isLiked,
    required this.likeCount
  });
}

class LikeButtonNotifier extends StateNotifier<LikeButtonState> {
  LikeButtonNotifier(int initialCount) :  super(
    LikeButtonState(
      isLiked: false,
      likeCount: initialCount
    )
  );

  void toggleLike() {
    state = LikeButtonState(
      isLiked: !state.isLiked,
      likeCount: state.isLiked ? state.likeCount - 1 : state.likeCount + 1
    );
  }
}

final likeButtonProvider = StateNotifierProvider.family<LikeButtonNotifier, LikeButtonState, String>((ref, postId) {
  int initialCount = ref.read(initialLikeCountProvider(postId));
  return LikeButtonNotifier(initialCount);
});

final initialLikeCountProvider = Provider.family<int, String>((ref, postId) {
  return 10;
});