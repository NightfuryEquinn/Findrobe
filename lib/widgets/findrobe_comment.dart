import 'package:findrobe_app/constants/arguments.dart';
import 'package:findrobe_app/global/date_formatter.dart';
import 'package:findrobe_app/models/comment.dart';
import 'package:findrobe_app/models/user.dart';
import 'package:findrobe_app/providers/auth_data_provider.dart';
import 'package:findrobe_app/providers/loading_provider.dart';
import 'package:findrobe_app/providers/post_data_provider.dart';
import 'package:findrobe_app/providers/posts_data_provider.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FindrobeComment extends ConsumerWidget {
  final PostrobeComment comment;
  final FindrobeUser? user;
  final int levelCount;

  const FindrobeComment({
    super.key,
    required this.comment,
    required this.user,
    required this.levelCount
  });

  Future<void> _deleteComment(BuildContext context, WidgetRef ref, String commentId, String postId) async {
    ref.read(loadingProvider.notifier).show();

    final bool deleted = await ref.read(postDataNotifierProvider.notifier).deleteComment(postId, commentId);

    if (deleted) {
      await ref.read(postsDataNotifierProvider.notifier).fetchAllPosts();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.beige,
          content: Text(
            "Comment deleted!",
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
            "Failed to delete comment. Please try again!",
            style: AppFonts.forum16black,
          ),
          duration: const Duration(seconds: 3)
        )
      );
    }

    ref.read(postDataNotifierProvider.notifier).fetchSinglePost(postId);
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
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  if (user!.userId == currentUser?.uid) {
                    Navigator.pushNamed(context, "/profile");
                  } else {
                    Navigator.pushNamed(
                      context, 
                      "/view_user",
                      arguments: ViewUserArgs(
                        userId: user!.userId
                      )  
                    );
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: user!.profilePic.isEmpty ?
                    Image.network(
                      "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                  : 
                    Image.network(
                      user!.profilePic,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    )
                )
              ),
              const SizedBox(width: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 100.0,
                        child: Text(
                          user!.username,
                          style: AppFonts.poiret16,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(width: 30.0),
                      Text(
                        "${levelCount}L",
                        style: AppFonts.poiret16
                      )
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    formatTimestamp(timestamp: comment.commentedAt),
                    style: AppFonts.forum12
                  ),
                ],
              ),
              const Spacer(),
              Material(
                color: Colors.transparent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))
                ),
                child: currentUser?.uid == comment.userId ?
                  InkWell(
                    borderRadius: BorderRadius.circular(5.0),
                    onTap: () {
                      _deleteComment(context, ref, comment.commentId, comment.postId);
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
            ]
          ),
          const SizedBox(height: 10.0),
          const Divider(
            indent: 25.0,
            endIndent: 25.0,
            thickness: 2.0,
            color: AppColors.grey,
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: double.infinity,
            child: Text(
              comment.content,
              style: AppFonts.forum12,
              textAlign: TextAlign.left,
            ),
          )
        ],
      ),
    );
  }
}