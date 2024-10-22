import 'dart:io';

import 'package:findrobe_app/firebase/collection_repo.dart';
import 'package:findrobe_app/models/clothing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CollectionDataNotifier extends StateNotifier<List<FindrobeClothing>> {
  final CollectionRepo _collectionRepo;

  CollectionDataNotifier(this._collectionRepo) : super([]);

  Future<void> fetchClothing(String userId, String category) async {
    try {
      final List<FindrobeClothing> clothings = await _collectionRepo.fetchClothing(userId, category);
      state = clothings;
    } catch (e) {
      print("Error fetching clothing: $e");
    }
  }

  Future<bool> addClothing(String name, String category, File image, String userId) async {
    try {
      final bool added = await _collectionRepo.addClothing(name, category, image, userId);
      return added;
    } catch (e) {
      print("Error adding clothing: $e");
      return false;
    }
  }

  Future<bool> updateClothing(String clothingId, String name, String category, dynamic image, String userId) async {
    try {
      await _collectionRepo.updateClothing(clothingId, name, category, image, userId);
      return true;
    } catch (e) {
      print("Error updating clothing: $e");
      return false;
    }
  }

  Future<bool> deleteClothing(String clothingId, String category, String userId) async {
    try {
      final bool deleted = await _collectionRepo.deleteClothing(clothingId, category, userId);
      return deleted;
    } catch (e) {
      print("Error deleting clothing: $e");
      return false;
    }
  }
}

final collectionDataProvider = Provider<CollectionRepo>((ref) {
  return CollectionRepo();
});

final collectionDataNotifierProvider = StateNotifierProvider<CollectionDataNotifier, List<FindrobeClothing>>((ref) {
  final collectionRepo = ref.watch(collectionDataProvider);
  return CollectionDataNotifier(collectionRepo);
});