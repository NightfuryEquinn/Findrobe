import 'package:findrobe_app/global/date_formatter.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:flutter/material.dart';

class PostrobeComment extends StatelessWidget {
  const PostrobeComment({
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
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/view_user");
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
                  Row(
                    children: [
                      SizedBox(
                        width: 100.0,
                        child: Text(
                          "Nightfury",
                          style: AppFonts.poiret16,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(width: 30.0),
                      Text(
                        "OA",
                        style: AppFonts.poiret16
                      )
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    formatDate(dateTime: DateTime.now()),
                    style: AppFonts.forum12
                  ),
                ],
              ),
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
          Text(
            "Check out my outfit! Lorem ipsum dolor sit actem. Check out my outfit! Lorem ipsum dolor sit actem. Check out my outfit! Lorem ipsum dolor sit actem. Check out my outfit! Lorem ipsum dolor sit actem.",
            style: AppFonts.forum12,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}