import 'dart:io';

import 'package:findrobe_app/firebase/post_repo.dart';
import 'package:findrobe_app/models/post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostDataNotifier extends StateNotifier<FindrobePost?> {
  final PostRepo _postRepo;

  PostDataNotifier(this._postRepo) : super(null);

  Future<bool> createPost(String title, String body, List<File> imageFiles) async {
    try {
      final bool created = await _postRepo.createPost(title, body, imageFiles);
      return created;
    } catch (e) {
      print("Error creating post: $e");
      return false;
    }
  }

  Future<bool> commentPost(String content, String userId, String postId) async {
    try {
      final bool commented = await _postRepo.commentPost(content, userId, postId);
      return commented;
    } catch (e) {
      print("Error commenting post: $e");
      return false;
    }
  }

  Future<bool> toggleLike(String userId, String postId) async {
    try {
      final bool toggled = await _postRepo.toggleLike(userId, postId);
      return toggled;
    } catch (e) {
      print("Error toggling like: $e");
      return false;
    }
  }

  Future<FindrobePost?> fetchSinglePost(String postId) async {
    try {
      FindrobePost? post = await _postRepo.fetchSinglePost(postId);
      return post;
    } catch (e) {
      print("Error fetching single post: $e");
      return null;
    }
  }
}

final postDataProvider = Provider<PostRepo>((ref) {
  return PostRepo();
});

final postDataNotifierProvider = StateNotifierProvider<PostDataNotifier, FindrobePost?>((ref) {
  final postRepo = ref.watch(postDataProvider);
  return PostDataNotifier(postRepo);
});