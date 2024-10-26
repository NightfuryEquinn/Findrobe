import 'package:findrobe_app/global/date_formatter.dart';
import 'package:findrobe_app/models/user.dart';
import 'package:findrobe_app/providers/admin/admin_monitor_provider.dart';
import 'package:findrobe_app/providers/client/loading_provider.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminUserCard extends ConsumerWidget {
  final FindrobeUser user;

  const AdminUserCard({
    super.key,
    required this.user
  });

  Future<void> _restrictUser(BuildContext context, WidgetRef ref, String userId) async {
    ref.read(loadingProvider.notifier).show();

    final bool restricted = await ref.read(adminMonitorNotifierProvider.notifier).restrictUser(userId);

    if (restricted) {
      await ref.read(adminMonitorNotifierProvider.notifier).fetchAllUsers();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.beige,
          content: Text(
            "User restricted!",
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
            "Failed to restrict user. Please try again!",
            style: AppFonts.forum16black,
          ),
          duration: const Duration(seconds: 3)
        )
      );
    }

    ref.read(loadingProvider.notifier).hide();
  }

  Future<void> _unrestrictUser(BuildContext context, WidgetRef ref, String userId) async {
    ref.read(loadingProvider.notifier).show();

    final bool unrestricted = await ref.read(adminMonitorNotifierProvider.notifier).unrestrictUser(userId);

    if (unrestricted) {
      await ref.read(adminMonitorNotifierProvider.notifier).fetchAllUsers();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.beige,
          content: Text(
            "User unrestricted!",
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
            "Failed to unrestrict user. Please try again!",
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
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(10.0),
      ),
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
              )
          ),
          const SizedBox(width: 15.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.username,
                  style: AppFonts.poiret16
                ),
                const SizedBox(height: 5.0),
                user.isRestricted ?
                  Text(
                    "Account access revoked...",
                    style: AppFonts.forum12,
                  )
                :
                  SizedBox(
                    child: Text(
                      "Registered since ${formatTimestamp(timestamp: user.dateRegistered)}",
                      style: AppFonts.forum12,
                    ),
                  )
              ],
            ),
          ),
          const SizedBox(width: 15.0),
          user.isRestricted ?
            Material(
              color: Colors.transparent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(5.0),
                onTap: () {
                  _unrestrictUser(context, ref, user.userId);
                },
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(
                    CupertinoIcons.checkmark_alt_circle,
                    color: AppColors.white,
                    size: 20.0,  
                  ),
                )
              )
            )
          :
            Material(
              color: Colors.transparent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(5.0),
                onTap: () {
                  _restrictUser(context, ref, user.userId);
                },
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(
                    CupertinoIcons.xmark_circle,
                    color: AppColors.white,
                    size: 20.0,  
                  ),
                )
              )
            )
        ],
      )
    );
  }
}