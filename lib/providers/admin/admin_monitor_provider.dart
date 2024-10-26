import 'package:findrobe_app/constants/states.dart';
import 'package:findrobe_app/firebase/admin_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminMonitorNotifier extends StateNotifier<AdminMonitorState> {
  final AdminRepo _adminRepo;

  AdminMonitorNotifier(this._adminRepo) : super(AdminMonitorState.initial());

  Future<void> clearAdmin() async {
    state = AdminMonitorState.initial();
  }

  Future<bool> restrictUser(String userId) async {
    final restricted = await _adminRepo.restrictUser(userId);
    return restricted;
  }

  Future<bool> unrestrictUser(String userId) async {
    final unrestricted = await _adminRepo.unrestrictUser(userId);
    return unrestricted;
  }

  Future<void> fetchAllUsers() async {
    final allUsers = await _adminRepo.fetchAllUsers();
    state = state.copyWith(allUsers: allUsers);
  }

  Future<void> fetchAllPosts() async {
    final allPosts = await _adminRepo.fetchAllPosts();
    state = state.copyWith(allPosts: allPosts);
  }

  Future<void> fetchAllComments() async {
    final allComments = await _adminRepo.fetchAllComments();
    state = state.copyWith(allComments: allComments);
  }

  Future<void> fetchAllClothings() async {
    final allClothings = await _adminRepo.fetchAllClothings();
    state = state.copyWith(allClothings: allClothings);
  }

  Future<void> fetchAllLikes() async {
    final allLikes = await _adminRepo.fetchAllLikes();
    state = state.copyWith(allLikes: allLikes);
  }

  Future<void> fetchAllClothingsByMonth() async {
    final clothings = await _adminRepo.fetchAllClothingsByMonth();
    state = state.copyWith(clothingsMonth: clothings);
  }

  Future<void> fetchAllUsersByMonth() async {
    final users = await _adminRepo.fetchAllUsersByMonth();
    state = state.copyWith(usersMonth: users);
  }

  Future<void> fetchAllPostsByMonth() async {
    final posts = await _adminRepo.fetchAllPostsByMonth();
    state = state.copyWith(postsMonth: posts);
  }

  Future<void> fetchAllCommentsByMonth() async {
    final comments = await _adminRepo.fetchAllCommentsByMonth();
    state = state.copyWith(commentsMonth: comments);
  }
}

final adminMonitorProvider = Provider<AdminRepo>((ref) {
  return AdminRepo();
});

final adminMonitorNotifierProvider = StateNotifierProvider<AdminMonitorNotifier, AdminMonitorState>((ref) {
  final adminRepo = ref.watch(adminMonitorProvider);
  return AdminMonitorNotifier(adminRepo);
});