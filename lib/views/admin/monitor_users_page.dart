import 'package:findrobe_app/global/loading_overlay.dart';
import 'package:findrobe_app/models/user.dart';
import 'package:findrobe_app/providers/admin/admin_monitor_provider.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/widgets/admin_user_card.dart';
import 'package:findrobe_app/widgets/findrobe_empty.dart';
import 'package:findrobe_app/widgets/findrobe_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MonitorUsersPage extends ConsumerStatefulWidget {
  const MonitorUsersPage({super.key});

  @override
  ConsumerState<MonitorUsersPage> createState() => _MonitorUsersPageState();
}

class _MonitorUsersPageState extends ConsumerState<MonitorUsersPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() => ref.read(adminMonitorNotifierProvider.notifier).fetchAllUsers());
  }

  Future<void> _refreshPosts() async {
    await ref.read(adminMonitorNotifierProvider.notifier).fetchAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    final List<FindrobeUser>? users = ref.watch(adminMonitorNotifierProvider).allUsers;
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: users == null ?
        const LoadingOverlay() :
        SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const FindrobeHeader(headerTitle: "All Users"),
              const SizedBox(height: 30.0),
              Expanded(
                child: RefreshIndicator(
                  color: AppColors.black,
                  backgroundColor: AppColors.beige,
                  onRefresh: _refreshPosts,
                  child: users.isEmpty ?
                    const FindrobeEmpty(labelText: "Fetching users...") 
                  :
                    ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: AdminUserCard(user: user)
                        );
                      }
                    )
                )
              )
            ]
          )
        )
      )
    );
  }
}