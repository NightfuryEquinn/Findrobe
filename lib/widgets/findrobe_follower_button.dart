import 'package:findrobe_app/models/user.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FindrobeFollowerButton extends ConsumerWidget {
  final FindrobeUser user;
  final VoidCallback onTap;

  const FindrobeFollowerButton({
    super.key,
    required this.user,
    required this.onTap
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: AppColors.overlayBlack,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: InkWell(
        onTap: onTap,
        splashColor: AppColors.overlayBeige,
        borderRadius: BorderRadius.circular(10.0),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: user.profilePic.isEmpty ? 
                  Image.network(
                    "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                :
                  Image.network(
                    user.profilePic,
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                ),
              const SizedBox(width: 30.0),
              Text(
                user.username,
                style: AppFonts.poiret24
              ),
            ],
          )
        )
      )
    );
  }
}