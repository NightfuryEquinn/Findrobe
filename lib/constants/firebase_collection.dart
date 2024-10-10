import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

final CollectionReference usersCollection = _firestore.collection("users");
final CollectionReference postsCollection = _firestore.collection("posts");
final CollectionReference clothingCollection = _firestore.collection("clothings");

const imagesInPostCollection = "images";
const likedInPostCollection = "likes";
const commentsInPostCollection = "comments";
const followersInUserCollection = "followers";