import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingState extends StateNotifier<bool> {
  LoadingState() : super(false);

  void show() => state = true;
  void hide() => state = false;
}

final loadingProvider = StateNotifierProvider<LoadingState, bool>((ref) {
  return LoadingState();
});