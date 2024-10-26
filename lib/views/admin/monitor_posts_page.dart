import 'package:findrobe_app/global/loading_overlay.dart';
import 'package:findrobe_app/models/post.dart';
import 'package:findrobe_app/providers/admin/admin_monitor_provider.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/widgets/findrobe_empty.dart';
import 'package:findrobe_app/widgets/findrobe_header.dart';
import 'package:findrobe_app/widgets/findrobe_post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MonitorPostsPage extends ConsumerStatefulWidget {
  const MonitorPostsPage({super.key});

  @override
  ConsumerState<MonitorPostsPage> createState() => _MonitorPostsPageState();
}

class _MonitorPostsPageState extends ConsumerState<MonitorPostsPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() => ref.read(adminMonitorNotifierProvider.notifier).fetchAllPosts());
  }

  Future<void> _refreshPosts() async {
    await ref.read(adminMonitorNotifierProvider.notifier).fetchAllPosts();
  }
  
  @override
  Widget build(BuildContext context) {
    final List<FindrobePost>? posts = ref.watch(adminMonitorNotifierProvider).allPosts;
    
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: posts == null ?
        const LoadingOverlay() :
        SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                const FindrobeHeader(headerTitle: "All Posts"),
                const SizedBox(height: 30.0),
                Expanded(
                  child: RefreshIndicator(
                    color: AppColors.black,
                    backgroundColor: AppColors.beige,
                    onRefresh: _refreshPosts,
                    child: posts.isEmpty ?
                      const FindrobeEmpty(labelText: "Fetching posts...") 
                    :
                      ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: FindrobePostCard(post: post)
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