import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LikeButtonBlock extends StatefulWidget {
  final int likeCount;
  
  const LikeButtonBlock({
    super.key,
    required this.likeCount
  });

  @override
  State<LikeButtonBlock> createState() => _LikeButtonBlockState();
}

class _LikeButtonBlockState extends State<LikeButtonBlock> {
  bool isLiked = false;
  late int likeCount;

  @override
  void initState() {
    super.initState();
    likeCount = widget.likeCount;
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likeCount += isLiked ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              toggleLike();
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                !isLiked ? CupertinoIcons.hand_thumbsup : CupertinoIcons.hand_thumbsup_fill,
                color: AppColors.white,
                size: 20.0,  
              ),
            )
          ),
        ),
        const SizedBox(width: 10.0),
        Text(
          likeCount.toString(),
          style: AppFonts.poiret12
        ),
      ],
    );
  }
}