import 'dart:io';

import 'package:findrobe_app/firebase/post_repo.dart';
import 'package:findrobe_app/models/post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostDataNotifier extends StateNotifier<FindrobePost?> {
  final PostRepo _postRepo;

  PostDataNotifier(this._postRepo) : super(null);

  Future<bool> createPost(String title, String body, List<File> imageFiles) async {
    try {
      await _postRepo.createPost(title, body, imageFiles);
      return true;
    } catch (e) {
      print("Error creating post: $e");
      return false;
    }
  }

  // TODO: Single post fetch
}

final postDataProvider = Provider<PostRepo>((ref) {
  return PostRepo();
});

final postDataNotifierProvider = StateNotifierProvider<PostDataNotifier, FindrobePost?>((ref) {
  final postRepo = ref.watch(postDataProvider);
  return PostDataNotifier(postRepo);
});