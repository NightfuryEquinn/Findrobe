import 'package:findrobe_app/firebase/post_repo.dart';
import 'package:findrobe_app/models/post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsDataNotifier extends StateNotifier<List<FindrobePost>?> {
  final PostRepo _postRepo;

  PostsDataNotifier(this._postRepo) : super([]) {
    fetchAllPosts();
  }

  // Getter
  List<FindrobePost>? get allPosts => state;

  Future<void> fetchAllPosts() async {
    try {
      final List<FindrobePost> posts = await _postRepo.fetchAllPosts();
      state = posts;
    } catch (e) {
      print("Error fetching all posts: $e");
    }
  }
}

final postsDataProvider = Provider<PostRepo>((ref) {
  return PostRepo();
});

final postsDataNotifierProvider = StateNotifierProvider<PostsDataNotifier, List<FindrobePost>?>((ref) {
  final postRepo = ref.watch(postsDataProvider);
  return PostsDataNotifier(postRepo);
});