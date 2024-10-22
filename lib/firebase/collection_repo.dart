import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findrobe_app/constants/firebase_collection.dart';
import 'package:findrobe_app/models/clothing.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CollectionRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<FindrobeClothing>> fetchClothing(String userId, String category) async {
    try {
      QuerySnapshot clothingDoc = await clothingCollection
        .doc(userId)
        .collection(clothingsByUserCollection)
        .doc(category)
        .collection(categoryInClothingCollection)
        .get();

      List<FindrobeClothing> clothings = clothingDoc.docs.map((clothingDoc) {
        return FindrobeClothing.fromMap(clothingDoc);
      }).toList();

      return clothings;
    } catch (e) {
      print("Failed to fetch clothing: $e");
      return [];
    }
  }

  Future<bool> addClothing(String name, String category, File image, String userId) async {
    try {
      DocumentReference clothingRef = clothingCollection
        .doc(userId)
        .collection(clothingsByUserCollection)
        .doc(category)
        .collection(categoryInClothingCollection)
        .doc();

      String imageUrl = await uploadImage(image, category, clothingRef.id, userId);

      FindrobeClothing findrobeClothing = FindrobeClothing(
        clothingId: clothingRef.id, 
        name: name, 
        category: category, 
        image: imageUrl, 
        createdAt: Timestamp.fromDate(DateTime.now()),
        userId: userId
      );

      await clothingRef.set(findrobeClothing.toMap());

      return true;
    } catch (e) {
      print("Failed to add clothing: $e");
      return false;
    }
  }

  Future<void> updateClothing(String clothingId, String name, String category, dynamic image, String userId) async {
    String? clothingImage;

    if (image is File) {
      clothingImage = await uploadImage(image, category, clothingId, userId);
    } else if (image is String) {
      clothingImage = image;
    } else {
      print("Failed to read type String and File");
      return;
    }

    try {
      DocumentReference clothingRef = clothingCollection
        .doc(userId)
        .collection(clothingsByUserCollection)
        .doc(category)
        .collection(categoryInClothingCollection)
        .doc(clothingId);

      Map<String, dynamic> updatedClothing = {
        "name": name,
        "category": category,
        "image": clothingImage
      };

      await clothingRef.update(updatedClothing); 
    } catch (e) {
      print("Failed to update clothing: $e");
    }
  }

  Future<bool> deleteClothing(String clothingId, String category, String userId) async {
    try {
      DocumentReference clothingRef = clothingCollection
        .doc(userId)
        .collection(clothingsByUserCollection)
        .doc(category)
        .collection(categoryInClothingCollection)
        .doc(clothingId);

      if (clothingRef.id == clothingId) {
        await clothingRef.delete();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Failed to delete clothing: $e");
      return false;
    }
  }

  Future<String> uploadImage(File imageFile, String category, String clothingId, String userId) async {
    try {
      final storageRef = _storage.ref().child("clothingImages/$userId/$category/${clothingId}_${DateTime.now()}.jpg");
      final uploadTask = await storageRef.putFile(imageFile);
      final imageUrl = await uploadTask.ref.getDownloadURL();

      return imageUrl;
    } catch (e) {
      print("Failed to upload image: $e");

      return "";
    }
  }
}