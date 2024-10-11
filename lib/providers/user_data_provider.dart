import 'package:findrobe_app/firebase/user_repo.dart';
import 'package:findrobe_app/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDataProvider = FutureProvider<FindrobeUser?>((ref) async {
  final userRepo = UserRepo();
  return await userRepo.fetchUserData();
});