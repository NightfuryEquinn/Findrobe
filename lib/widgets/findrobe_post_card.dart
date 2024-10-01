import 'package:findrobe_app/global/date_formatter.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:findrobe_app/widgets/customs/comment_button_block.dart';
import 'package:findrobe_app/widgets/customs/image_grid.dart';
import 'package:findrobe_app/widgets/customs/like_button_block.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FindrobePostCard extends StatelessWidget {
  const FindrobePostCard({
    super.key
  });

  @override
  Widget build(BuildContext context) {
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
                  Navigator.pushNamed(context, "/profile");
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.network(
                    "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                )
              ),
              const SizedBox(width: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nightfury",
                    style: AppFonts.poiret16
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    formatDate(dateTime: DateTime.now()),
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
                child: InkWell(
                  borderRadius: BorderRadius.circular(5.0),
                  onTap: () {
                    print("Delete");
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Icon(
                      CupertinoIcons.delete,
                      color: AppColors.white,
                      size: 20.0,  
                    ),
                  )
                ),
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
            "Today's Tea Time Wear",
            style: AppFonts.poiret20
          ),
          const SizedBox(height: 15.0),
          SizedBox(
            height: 100,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: buildImageGrid(
                context,
                [
                  "https://www.uniqlo.com/jp/ja/contents/feature/masterpiece/common/img/product/item_03_kv.jpg?240829",
                  "https://www.uniqlo.com/jp/ja/contents/feature/masterpiece/common/img/product/item_03_kv.jpg?240829",
                  "https://www.uniqlo.com/jp/ja/contents/feature/masterpiece/common/img/product/item_03_kv.jpg?240829",
                  "https://www.uniqlo.com/jp/ja/contents/feature/masterpiece/common/img/product/item_03_kv.jpg?240829",
                ]
              ),
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
          const Row(
            children: [
              LikeButtonBlock(likeCount: 13),
              SizedBox(width: 25.0),
              CommentButtonBlock(commentCount: 10)
            ],
          )
        ],
      ),
    );
  }
}