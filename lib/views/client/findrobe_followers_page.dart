import 'package:findrobe_app/constants/arguments.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/widgets/findrobe_empty.dart';
import 'package:findrobe_app/widgets/findrobe_follower_button.dart';
import 'package:findrobe_app/widgets/findrobe_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FindrobeFollowersPage extends ConsumerStatefulWidget {
  final FollowersArgs args;

  const FindrobeFollowersPage({
    super.key,
    required this.args
  });

  @override
  ConsumerState<FindrobeFollowersPage> createState() => _FindrobeFollowersPageState();
}

class _FindrobeFollowersPageState extends ConsumerState<FindrobeFollowersPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const FindrobeHeader(headerTitle: "My Followers"),
              const SizedBox(height: 30.0),
              Expanded(
                child: widget.args.followers.isEmpty ?
                  const FindrobeEmpty(labelText: "No followers...")
                :
                  ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: widget.args.followers.length,
                    itemBuilder: (context, index) {
                      final user = widget.args.followers[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: FindrobeFollowerButton(
                          user: user,
                          onTap: () {
                            Navigator.pushNamed(
                              context, 
                              "/view_user",
                              arguments: ViewUserArgs(
                                userId: user.userId
                              )  
                            );
                          }
                        )
                      );
                    }
                  )
              )
            ],
          )
        )
      ),
    );
  }
}