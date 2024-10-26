import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminGraphIndexNotifier extends StateNotifier<int> {
  final int maxIndex;

  AdminGraphIndexNotifier({
    required this.maxIndex
  }) : super(0);

  void next() {
    state = (state + 1) % maxIndex;
  }

  void previous() {
    state = (state - 1) % maxIndex;
  }
}

final adminGraphIndexProvider = StateNotifierProvider<AdminGraphIndexNotifier, int>((ref) {
  const maxIndex = 4;
  return AdminGraphIndexNotifier(maxIndex: maxIndex);
});