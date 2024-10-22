import 'package:collection/collection.dart';
import 'package:findrobe_app/providers/client/posts_data_provider.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentButtonBlock extends ConsumerWidget {
  final String postId;

  const CommentButtonBlock({
    super.key,
    required this.postId
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final post = ref.watch(postsDataNotifierProvider.select(
      (state) => state.allPosts.firstWhereOrNull((p) => p.postId == postId)
    ));

    return Row(
      children: [
        Material(
          color: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(5.0),
            onTap: () {
              print("Comment");
            },
            child: const Padding(
              padding: EdgeInsets.all(5.0),
              child: Icon(
                CupertinoIcons.chat_bubble,
                color: AppColors.white,
                size: 20.0,  
              ),
            )
          ),
        ),
        const SizedBox(width: 10.0),
        Text(
          "${post?.comments?.length ?? 'NaN'}",
          style: AppFonts.poiret12
        )
      ],
    );
  }
}