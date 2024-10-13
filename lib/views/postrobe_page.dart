import 'package:findrobe_app/global/loading_overlay.dart';
import 'package:findrobe_app/models/post.dart';
import 'package:findrobe_app/providers/posts_data_provider.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/widgets/findrobe_header.dart';
import 'package:findrobe_app/widgets/findrobe_post_card.dart';
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

  @override
  Widget build(BuildContext context) {
    final List<FindrobePost>? posts = ref.watch(postsDataNotifierProvider);

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
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: posts.map((post) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: FindrobePostCard(post: post)
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}