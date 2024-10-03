import 'package:flutter_riverpod/flutter_riverpod.dart';

class DropdownNotifier extends StateNotifier<String?> {
  DropdownNotifier() : super(null);

  void selectItem(String? newItem) {
    state = newItem;
  }
}

final dropdownProvider = StateNotifierProvider<DropdownNotifier, String?>((ref) => DropdownNotifier());