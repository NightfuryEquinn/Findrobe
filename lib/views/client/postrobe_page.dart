import 'package:findrobe_app/global/loading_overlay.dart';
import 'package:findrobe_app/models/post.dart';
import 'package:findrobe_app/providers/client/posts_data_provider.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/widgets/findrobe_header.dart';
import 'package:findrobe_app/widgets/findrobe_post_card.dart';
import 'package:findrobe_app/widgets/findrobe_empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostrobePage extends ConsumerStatefulWidget {
  const PostrobePage({super.key});

  @override
  ConsumerState<PostrobePage> createState() => _PostrobePageState();
}

class _PostrobePageState extends ConsumerState<PostrobePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() => ref.read(postsDataNotifierProvider.notifier).fetchAllPosts());
  }

  Future<void> _refreshPosts() async {
    await ref.read(postsDataNotifierProvider.notifier).fetchAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    final List<FindrobePost>? posts = ref.watch(postsDataNotifierProvider).allPosts;

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
                const FindrobeHeader(headerTitle: "Postrobes"),
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
                    ),
                  )
                ),
              ],
            ),
          ),
        ),
    );
  }
}