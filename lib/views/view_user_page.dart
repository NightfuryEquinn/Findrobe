import 'package:findrobe_app/constants/arguments.dart';
import 'package:findrobe_app/global/date_formatter.dart';
import 'package:findrobe_app/global/image_modal.dart';
import 'package:findrobe_app/global/loading_overlay.dart';
import 'package:findrobe_app/models/post.dart';
import 'package:findrobe_app/models/user.dart';
import 'package:findrobe_app/providers/others/follow_provider.dart';
import 'package:findrobe_app/providers/posts_data_provider.dart';
import 'package:findrobe_app/providers/user_data_provider.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:findrobe_app/widgets/findrobe_button.dart';
import 'package:findrobe_app/widgets/findrobe_header.dart';
import 'package:findrobe_app/widgets/findrobe_post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewUserPage extends ConsumerStatefulWidget {
  final ViewUserArgs args;

  const ViewUserPage({
    super.key,
    required this.args
  });

  @override
  ConsumerState<ViewUserPage> createState() => _ViewUserPageState();
}

class _ViewUserPageState extends ConsumerState<ViewUserPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() => ref.read(userDataNotifierProvider.notifier).fetchViewUserData(widget.args.userId));
    Future.microtask(() => ref.read(postsDataNotifierProvider.notifier).fetchPostByUserId(widget.args.userId));
    Future.microtask(() => ref.read(postsDataNotifierProvider.notifier).fetchCommentCountByUserId(widget.args.userId));
  }

  @override
  Widget build(BuildContext context) {
    final FindrobeUser? user = ref.watch(userDataNotifierProvider).otherUser;
    final List<FindrobePost> userPosts = ref.watch(postsDataNotifierProvider).userPosts;
    final int userCommentCount = ref.watch(postsDataNotifierProvider).userCommentCount;

    final followState = ref.watch(followNotifierProvider(widget.args.userId));

    return Scaffold(
      backgroundColor: AppColors.grey,
      body: user == null ?
        const LoadingOverlay() :
        SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                const FindrobeHeader(headerTitle: "User Profile"),
                const SizedBox(height: 30.0),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  showImageDialog(context, user.profilePic);
                                },
                                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: user.profilePic.isEmpty ?
                                    Image.network(
                                      "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg",
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )
                                  :
                                    Image.network(
                                      user.profilePic,
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: 100,
                                    )
                                )
                              ),
                            ),
                            const SizedBox(width: 15.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  user.username,
                                  style: AppFonts.poiret24
                                ),
                                const SizedBox(height: 5.0),
                                SizedBox(
                                  width: 200.0,
                                  child: Text(
                                    "Registered since ${formatTimestamp(timestamp: user.dateRegistered)}",
                                    style: AppFonts.poiret12,
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 30.0),
                        SizedBox(
                          width: double.infinity,
                          child: Material(
                            color: AppColors.beige,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5.0))
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, "/followers");
                              },
                              splashColor: AppColors.overlayBlack,
                              borderRadius: BorderRadius.circular(5.0),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                  child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total Followers",
                                      style: AppFonts.forum16black
                                    ),
                                    Text(
                                      "${followState.followersCount}",
                                      style: AppFonts.forum16black
                                    )
                                  ],
                                ),
                              ),
                            )
                          )
                        ),
                        const SizedBox(height: 15.0),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Posts Written",
                                        style: AppFonts.poiret16
                                      ),
                                      Text(
                                        "${userPosts.length}",
                                        style: AppFonts.poiret16
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15.0),
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Comments Written",
                                        style: AppFonts.poiret16
                                      ),
                                      Text(
                                        "$userCommentCount",
                                        style: AppFonts.poiret16
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          )
                        ),
                        const SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FindrobeButton(
                              width: 150.0,
                              buttonText: followState.isFollowing ? "Unfollow" : "Follow", 
                              onPressed: () {
                                if (followState.isFollowing) {
                                  ref.read(followNotifierProvider(widget.args.userId).notifier).unfollowUser(ref);
                                } else {
                                  ref.read(followNotifierProvider(widget.args.userId).notifier).followUser(ref);
                                }
                              }
                            )
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        const Divider(
                          indent: 25.0,
                          endIndent: 25.0,
                          thickness: 2.0,
                          color: AppColors.overlayBlack,
                        ),
                        const SizedBox(height: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Recent Posts",
                              style: AppFonts.poiret24,
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 5.0),
                            for (FindrobePost userPost in userPosts)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: FindrobePostCard(post: userPost)
                              )
                          ]
                        )
                      ]
                    )
                  )
                )
              ]
            )
          )
        )
    );
  }
}