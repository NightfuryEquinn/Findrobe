import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentButtonBlock extends StatefulWidget {
  final int commentCount;

  const CommentButtonBlock({
    super.key,
    required this.commentCount
  });

  @override
  State<CommentButtonBlock> createState() => _CommentButtonBlockState();
}

class _CommentButtonBlockState extends State<CommentButtonBlock> {
  late int commentCount;

  @override
  void initState() {
    super.initState();
    commentCount = widget.commentCount;
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
          "13",
          style: AppFonts.poiret12
        )
      ],
    );
  }
}