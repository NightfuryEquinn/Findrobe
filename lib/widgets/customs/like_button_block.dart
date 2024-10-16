import 'package:findrobe_app/providers/others/like_button_provider.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LikeButtonBlock extends ConsumerWidget {
  final String postId;
  final String userId;
  
  const LikeButtonBlock({
    super.key,
    required this.postId,
    required this.userId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likeButtonState = ref.watch(likeButtonProvider(postId));

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
              ref.read(likeButtonProvider(postId).notifier).toggleLike(ref, userId, postId);
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                !likeButtonState.isLiked ? CupertinoIcons.hand_thumbsup : CupertinoIcons.hand_thumbsup_fill,
                color: AppColors.white,
                size: 20.0,  
              ),
            )
          ),
        ),
        const SizedBox(width: 10.0),
        Text(
          likeButtonState.likeCount.toString(),
          style: AppFonts.poiret12
        ),
      ],
    );
  }
}