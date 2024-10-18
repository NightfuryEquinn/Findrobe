import 'dart:io';

import 'package:findrobe_app/global/date_formatter.dart';
import 'package:findrobe_app/global/loading_overlay.dart';
import 'package:findrobe_app/models/post.dart';
import 'package:findrobe_app/models/user.dart';
import 'package:findrobe_app/providers/auth_data_provider.dart';
import 'package:findrobe_app/providers/others/add_image_provider.dart';
import 'package:findrobe_app/providers/others/loading_provider.dart';
import 'package:findrobe_app/providers/posts_data_provider.dart';
import 'package:findrobe_app/providers/user_data_provider.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:findrobe_app/widgets/findrobe_button.dart';
import 'package:findrobe_app/widgets/findrobe_header.dart';
import 'package:findrobe_app/widgets/findrobe_post_card.dart';
import 'package:findrobe_app/widgets/findrobe_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final ImagePicker picker = ImagePicker();
  final TextEditingController userCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    final currentUser = ref.read(authDataNotifierProvider);
    
    Future.microtask(() => ref.read(userDataNotifierProvider.notifier).fetchUserData());
    Future.microtask(() => ref.read(postsDataNotifierProvider.notifier).fetchPostByUserId(currentUser!.uid));
    Future.microtask(() => ref.read(postsDataNotifierProvider.notifier).fetchCommentCountByUserId(currentUser!.uid));
  }

  Future<void> _refreshPosts() async {
    final currentUser = ref.read(authDataNotifierProvider);

    if (currentUser != null) {
      await ref.read(postsDataNotifierProvider.notifier).fetchPostByUserId(currentUser.uid);
      await ref.read(postsDataNotifierProvider.notifier).fetchCommentCountByUserId(currentUser.uid);
    }
  }

  Future<void> _pickImage(WidgetRef ref, ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      ref.read(addImageProvider.notifier).state = File(pickedFile.path);
    }
  }

  void showImageSourceDialog(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      backgroundColor: AppColors.white,
      context: context, 
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0), 
          topRight: Radius.circular(10.0)
        )
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0), 
                    topRight: Radius.circular(10.0)
                  ),
                ),
                leading: const Icon(
                  CupertinoIcons.camera,
                  size: 24.0,
                  color: AppColors.black,
                ),
                title: Text(
                  "Camera",
                  style: AppFonts.forum16black,
                ),
                onTap: () {
                  _pickImage(ref, ImageSource.camera);
                  Navigator.of(context).pop();
                }
              ),
              ListTile(
                leading: const Icon(
                  CupertinoIcons.photo,
                  size: 24.0,
                  color: AppColors.black,
                ),
                title: Text(
                  "Gallery",
                  style: AppFonts.forum16black,
                ),
                onTap: () {
                  _pickImage(ref, ImageSource.gallery);
                  Navigator.of(context).pop();
                }
              ),
            ],
          )
        );
      }
    );
  }

  Future<void> _updateProfile(BuildContext context, WidgetRef ref, String username, dynamic profilePic, String email) async {
    ref.read(loadingProvider.notifier).show();

    final bool updated = await ref.read(userDataNotifierProvider.notifier)
      .updateProfile(
        username, 
        profilePic, 
        email
      );

    if (updated) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.beige,
          content: Text(
            "Profile updated!",
            style: AppFonts.forum16black,
          ),
          duration: const Duration(seconds: 3)
        )
      );

      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.beige,
          content: Text(
            "Failed to update profile. Please try again!",
            style: AppFonts.forum16black,
          ),
          duration: const Duration(seconds: 3)
        )
      );
    }

    ref.watch(addImageProvider.notifier).state = null;

    ref.read(loadingProvider.notifier).hide();
  }

  @override
  Widget build(BuildContext context) {
    final FindrobeUser? user = ref.watch(userDataNotifierProvider);
    final List<FindrobePost> userPosts = ref.watch(postsDataNotifierProvider).userPosts;
    final int userCommentCount = ref.watch(postsDataNotifierProvider).userCommentCount;

    if (user != null) {
      userCtrl.text = user.username;
      emailCtrl.text = user.email;
    }
   
    final newProfilePic = ref.watch(addImageProvider);
    
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
                const FindrobeHeader(headerTitle: "My Profile"),
                const SizedBox(height: 30.0),
                Expanded(
                  child: RefreshIndicator(
                    color: AppColors.black,
                    backgroundColor: AppColors.beige,
                    onRefresh: _refreshPosts,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    showImageSourceDialog(context, ref);
                                  },
                                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: user.profilePic.isEmpty && newProfilePic == null ? 
                                      Image.network(
                                        "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg",
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      )
                                    : user.profilePic.isNotEmpty ?
                                      Image.network(
                                        user.profilePic,
                                        fit: BoxFit.cover,
                                        width: 100,
                                        height: 100,
                                      )
                                    :
                                      Image.file(
                                        newProfilePic!,
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
                                        "20",
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
                          const SizedBox(height: 10.0),
                          const Divider(
                            indent: 25.0,
                            endIndent: 25.0,
                            thickness: 2.0,
                            color: AppColors.overlayBlack,
                          ),
                          const SizedBox(height: 10.0),
                          FindrobeTextfield(labelText: "Username", controller: userCtrl),
                          const SizedBox(height: 20.0),
                          FindrobeTextfield(labelText: "Email Address", controller: emailCtrl, isEmail: true),
                          const SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FindrobeButton(
                                width: 150.0,
                                buttonText: "Log Out", 
                                alternative: true,
                                buttonColor: AppColors.black,
                                onPressed: () {
                                  ref.read(userDataNotifierProvider.notifier).logoutUser();
                                  Navigator.pushReplacementNamed(context, "/login");
                                }
                              ),
                              FindrobeButton(
                                width: 150.0,
                                buttonText: "Update", 
                                onPressed: () {
                                  if (newProfilePic == null) {
                                    _updateProfile(
                                      context, 
                                      ref, 
                                      userCtrl.text, 
                                      user.profilePic, 
                                      emailCtrl.text
                                    );
                                  } else {
                                    _updateProfile(
                                      context, 
                                      ref, 
                                      userCtrl.text, 
                                      newProfilePic, 
                                      emailCtrl.text
                                    );
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
                        ],
                      )
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