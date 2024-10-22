import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:findrobe_app/providers/client/auth_data_provider.dart';
import 'package:findrobe_app/providers/client/bottombar_index_provider.dart';
import 'package:findrobe_app/providers/client/follow_provider.dart';
import 'package:findrobe_app/providers/client/posts_data_provider.dart';
import 'package:findrobe_app/providers/client/user_data_provider.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/views/client/findrobe_page.dart';
import 'package:findrobe_app/views/client/postrobe_add_page.dart';
import 'package:findrobe_app/views/client/postrobe_page.dart';
import 'package:findrobe_app/views/client/profile_page.dart';
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
      bottomNavigationBar: CurvedNavigationBar(
        index: bottomBarIndex,
        height: 60.0,
        color: AppColors.black,
        backgroundColor: AppColors.grey,
        buttonBackgroundColor: AppColors.beige,
        animationCurve: Curves.fastEaseInToSlowEaseOut,
        animationDuration: const Duration(milliseconds: 1000),
        onTap: (value) {
          ref.read(bottomBarIndexProvider.notifier).update((state) => value);

          // Indexed stack won't trigger refresh
          // This is only for profile page
          if (value == 3) {
            final currentUser = ref.watch(authDataNotifierProvider);

            if (currentUser != null) {
              ref.read(userDataNotifierProvider.notifier).fetchUserData();
              ref.read(postsDataNotifierProvider.notifier).fetchPostByUserId(currentUser.uid);
              ref.read(postsDataNotifierProvider.notifier).fetchCommentCountByUserId(currentUser.uid);
              ref.read(followNotifierProvider(currentUser.uid).notifier).fetchFollowers(currentUser.uid);
            }
          }
        },
        items: [
          Icon(
            CupertinoIcons.home,
            size: 24.0,
            color: bottomBarIndex == 0 ? AppColors.black : AppColors.beige,
          ),
          Icon(
            CupertinoIcons.plus_app,
            size: 24.0,
            color: bottomBarIndex == 1 ? AppColors.black : AppColors.beige,
          ),
          Icon(
            CupertinoIcons.folder,
            size: 24.0,
            color: bottomBarIndex == 2 ? AppColors.black : AppColors.beige,
          ),
          Icon(
            CupertinoIcons.profile_circled,
            size: 24.0,
            color: bottomBarIndex == 3 ? AppColors.black : AppColors.beige,
          ),
        ],
      ),
    );
  }
}