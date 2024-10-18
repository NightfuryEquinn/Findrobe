import 'package:findrobe_app/constants/states.dart';
import 'package:findrobe_app/firebase/post_repo.dart';
import 'package:findrobe_app/models/post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsDataNotifier extends StateNotifier<PostsDataState> {
  final PostRepo _postRepo;

  PostsDataNotifier(this._postRepo) : super(PostsDataState.initial()) {
    fetchAllPosts();
  }

  Future<void> fetchAllPosts() async {
    try {
      final List<FindrobePost> posts = await _postRepo.fetchAllPosts();
      state = state.copyWith(allPosts: posts);
    } catch (e) {
      print("Error fetching all posts: $e");
    }
  }

  Future<void> fetchPostByUserId(String userId) async {
    try {
      final List<FindrobePost> posts = await _postRepo.fetchPostByUserId(userId);
      state = state.copyWith(userPosts: posts);
    } catch (e) {
      print("Error fetching posts of user: $e");
    }
  }

  Future<void> fetchCommentCountByUserId(String userId) async {
    try {
      final int comments = await _postRepo.fetchCommentCountByUserId(userId);
      state = state.copyWith(userCommentCount: comments);
    } catch (e) {
      print("Error fetching user comment count: $e");
    }
  }
}

final postsDataProvider = Provider<PostRepo>((ref) {
  return PostRepo();
});

final postsDataNotifierProvider = StateNotifierProvider<PostsDataNotifier, PostsDataState>((ref) {
  final postRepo = ref.watch(postsDataProvider);
  return PostsDataNotifier(postRepo);
});