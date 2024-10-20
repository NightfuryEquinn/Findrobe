import 'package:findrobe_app/global/date_formatter.dart';
import 'package:findrobe_app/models/post.dart';
import 'package:findrobe_app/providers/auth_data_provider.dart';
import 'package:findrobe_app/providers/others/loading_provider.dart';
import 'package:findrobe_app/providers/post_data_provider.dart';
import 'package:findrobe_app/providers/posts_data_provider.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:findrobe_app/widgets/customs/comment_button_block.dart';
import 'package:findrobe_app/widgets/customs/image_grid.dart';
import 'package:findrobe_app/widgets/customs/like_button_block.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FindrobePostCard extends ConsumerWidget {
  final FindrobePost post;

  const FindrobePostCard({
    super.key,
    required this.post
  });

  Future<void> _deletePost(BuildContext context, WidgetRef ref, String postId, String userId) async {
    ref.read(loadingProvider.notifier).show();

    final bool deleted = await ref.read(postDataNotifierProvider.notifier).deletePost(post.postId);

    if (deleted) {
      await ref.read(postsDataNotifierProvider.notifier).fetchAllPosts();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.beige,
          content: Text(
            "Post deleted!",
            style: AppFonts.forum16black,
          ),
          duration: const Duration(seconds: 3)
        )
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.beige,
          content: Text(
            "Failed to delete post. Please try again!",
            style: AppFonts.forum16black,
          ),
          duration: const Duration(seconds: 3)
        )
      );
    }

    ref.read(loadingProvider.notifier).hide();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(authDataNotifierProvider);

    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/view_user");
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: (post.user != null && post.user!.profilePic.isNotEmpty) ? 
                    Image.network(
                      post.user!.profilePic,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                )
              ),
              const SizedBox(width: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.user!.username,
                    style: AppFonts.poiret16
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    formatTimestamp(timestamp: post.createdAt),
                    style: AppFonts.forum12
                  )
                ],
              ),
              const Spacer(),
              Material(
                color: Colors.transparent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))
                ),
                child: currentUser!.uid == post.userId ?
                  InkWell(
                    borderRadius: BorderRadius.circular(5.0),
                    onTap: () {
                      _deletePost(context, ref, post.postId, post.userId);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Icon(
                        CupertinoIcons.delete,
                        color: AppColors.white,
                        size: 20.0,  
                      ),
                    )
                  )
                :
                  const SizedBox.shrink()
              )
            ],
          ),
          const SizedBox(height: 10.0),
          const Divider(
            indent: 25.0,
            endIndent: 25.0,
            thickness: 2.0,
            color: AppColors.grey,
          ),
          const SizedBox(height: 10.0),
          Text(
            post.title,
            style: AppFonts.poiret20
          ),
          const SizedBox(height: 15.0),
          SizedBox(
            height: 100,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: buildImageGrid(
                  context,
                  post,
                  post.imageUrls?.toList() ?? []
                ),
              )
            ) 
          ),
          const SizedBox(height: 10.0),
          const Divider(
            indent: 25.0,
            endIndent: 25.0,
            thickness: 2.0,
            color: AppColors.grey,
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              LikeButtonBlock(postId: post.postId, userId: currentUser.uid),
              const SizedBox(width: 25.0),
              CommentButtonBlock(postId: post.postId)
            ],
          )
        ],
      ),
    );
  }
}