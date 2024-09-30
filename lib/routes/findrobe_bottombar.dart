import 'package:findrobe_app/providers/bottombar_index_provider.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/views/findrobe_page.dart';
import 'package:findrobe_app/views/postrobe_add_page.dart';
import 'package:findrobe_app/views/postrobe_page.dart';
import 'package:findrobe_app/views/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FindrobeBottomBar extends ConsumerWidget {
  const FindrobeBottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomBarIndex = ref.watch(bottomBarIndexProvider);

    return Scaffold(
      body: IndexedStack(
        index: bottomBarIndex,
        children: const [
          PostrobePage(),
          PostrobeAddPage(),
          FindrobePage(),
          ProfilePage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: AppColors.grey,
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: const IconThemeData(
          size: 36.0,
          color: AppColors.white
        ),
        unselectedIconTheme: const IconThemeData(
          size: 26.0,
          color: Color(0xFF797979)
        ),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: bottomBarIndex,
        onTap: (value) {
          ref.read(bottomBarIndexProvider.notifier).update((state) => value);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.home
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.plus_app
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.folder
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.profile_circled
            ),
            label: "",
          ),
        ]
      ),
    );
  }
}