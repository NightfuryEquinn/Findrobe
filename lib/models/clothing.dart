import 'package:cloud_firestore/cloud_firestore.dart';

class FindrobeClothing {
  final String clothingId;
  final String name;
  final String category;
  final String image;
  final Timestamp createdAt;
  final String userId;

  const FindrobeClothing({
    required this.clothingId,
    required this.name,
    required this.category,
    required this.image,
    required this.createdAt,
    required this.userId
  });

  Map<String, dynamic> toMap() {
    return {
      "clothingId": clothingId,
      "name": name,
      "category": category,
      "image": image,
      "createdAt": createdAt,
      "userId": userId
    };
  }

  factory FindrobeClothing.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> map = doc.data() as Map<String, dynamic>;

    return FindrobeClothing(
      clothingId: map["clothingId"], 
      name: map["name"], 
      category: map["category"], 
      image: map["image"], 
      createdAt: map["createdAt"],
      userId: map["userId"]
    );
  }
}