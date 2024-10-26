import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:findrobe_app/providers/admin/admin_bottombar_index_provider.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/views/admin/analytics_page.dart';
import 'package:findrobe_app/views/admin/monitor_posts_page.dart';
import 'package:findrobe_app/views/admin/monitor_users_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminFindrobeBottomBar extends ConsumerWidget {
  const AdminFindrobeBottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomBarIndex = ref.watch(adminBottomBarIndexProvider);

    return Scaffold(
      body: IndexedStack(
        index: bottomBarIndex,
        children: const [
          AnalyticsPage(),
          MonitorUsersPage(),
          MonitorPostsPage()
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
          ref.read(adminBottomBarIndexProvider.notifier).update((state) => value);
        },
        items: [
          Icon(
            CupertinoIcons.chart_bar_alt_fill,
            size: 24.0,
            color: bottomBarIndex == 0 ? AppColors.black : AppColors.beige,
          ),
          Icon(
            CupertinoIcons.person_2_fill,
            size: 24.0,
            color: bottomBarIndex == 1 ? AppColors.black : AppColors.beige,
          ),
          Icon(
            CupertinoIcons.rectangle_dock,
            size: 24.0,
            color: bottomBarIndex == 2 ? AppColors.black : AppColors.beige,
          )
        ],
      ),
    );
  }
}