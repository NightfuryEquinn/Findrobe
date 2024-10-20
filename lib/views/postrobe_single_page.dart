import 'package:findrobe_app/constants/arguments.dart';
import 'package:findrobe_app/global/date_formatter.dart';
import 'package:findrobe_app/global/image_modal.dart';
import 'package:findrobe_app/models/comment.dart';
import 'package:findrobe_app/models/post.dart';
import 'package:findrobe_app/providers/auth_data_provider.dart';
import 'package:findrobe_app/providers/others/loading_provider.dart';
import 'package:findrobe_app/providers/post_data_provider.dart';
import 'package:findrobe_app/providers/posts_data_provider.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:findrobe_app/widgets/customs/comment_button_block.dart';
import 'package:findrobe_app/widgets/customs/like_button_block.dart';
import 'package:findrobe_app/widgets/findrobe_button.dart';
import 'package:findrobe_app/widgets/findrobe_empty.dart';
import 'package:findrobe_app/widgets/findrobe_header.dart';
import 'package:findrobe_app/widgets/findrobe_textfield.dart';
import 'package:findrobe_app/widgets/findrobe_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostrobeSinglePage extends ConsumerStatefulWidget {
  final PostrobeSingleArgs args;

  const PostrobeSinglePage({
    super.key,
    required this.args
  });

  @override
  ConsumerState<PostrobeSinglePage> createState() => _PostrobePageState();
}

class _PostrobePageState extends ConsumerState<PostrobeSinglePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() => ref.read(postDataNotifierProvider.notifier).fetchSinglePost(widget.args.post.postId));
  }

  Future<void> _commentPost(BuildContext context, WidgetRef ref, String content, String userId, String postId) async {
    if (content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.beige,
          content: Text(
            "Comment is required!",
            style: AppFonts.forum16black,
          ),
          duration: const Duration(seconds: 3)
        )
      );

      return;
    }

    ref.read(loadingProvider.notifier).show();

    final bool commented = await ref.read(postDataNotifierProvider.notifier).commentPost(content, userId, postId);

    if (commented) {
      await ref.read(postsDataNotifierProvider.notifier).fetchAllPosts();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.beige,
          content: Text(
            "Commented!",
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
            "Failed to comment. Please try again!",
            style: AppFonts.forum16black,
          ),
          duration: const Duration(seconds: 3)
        )
      );
    }

    ref.read(postDataNotifierProvider.notifier).fetchSinglePost(postId);
    ref.read(loadingProvider.notifier).hide();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController commentCtrl = TextEditingController();

    final currentUser = ref.watch(authDataNotifierProvider);
    final FindrobePost? thePost = ref.watch(postDataNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const FindrobeHeader(headerTitle: "The Postrobe"),
              const SizedBox(height: 30.0),
              thePost == null ?
                const FindrobeEmpty(labelText: "Fetching post...") : 
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
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
                                      child: widget.args.post.user!.profilePic.isEmpty ?
                                        Image.network(
                                          "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg",
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        )
                                      : 
                                        Image.network(
                                           widget.args.post.user!.profilePic,
                                          fit: BoxFit.cover,
                                          width: 50,
                                          height: 50,
                                        )
                                      )
                                  ),
                                  const SizedBox(width: 20.0),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                         widget.args.post.user!.username,
                                        style: AppFonts.poiret16
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(
                                        formatTimestamp(timestamp: thePost.createdAt),
                                        style: AppFonts.forum12
                                      )
                                    ],
                                  ),
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
                                thePost.title,
                                style: AppFonts.poiret20
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                thePost.body,
                                style: AppFonts.forum12,
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(height: 20.0),
                              if (widget.args.post.imageUrls!.isNotEmpty) 
                                for (String urls in  widget.args.post.imageUrls!)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10.0),
                                    child: InkWell(
                                      onTap: () {
                                        showImageDialog(context, urls);
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5.0),
                                        child: Image.network(
                                          urls,
                                          fit: BoxFit.cover
                                        )
                                      ),
                                    ),
                                  ),
                              const SizedBox(height: 15.0),
                              const Divider(
                                indent: 25.0,
                                endIndent: 25.0,
                                thickness: 2.0,
                                color: AppColors.grey,
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                children: [
                                  LikeButtonBlock(postId: thePost.postId, userId: currentUser!.uid),
                                  const SizedBox(width: 25.0),
                                  CommentButtonBlock(postId: thePost.postId)
                                ],
                              )
                            ]
                          )
                        ),
                        const SizedBox(height: 15.0),
                        FindrobeTextfield(labelText: "", controller: commentCtrl),
                        const SizedBox(height: 5.0),
                        FindrobeButton(
                          buttonText: "Comment",
                          onPressed: () {
                            _commentPost(
                              context, 
                              ref, 
                              commentCtrl.text, 
                              currentUser!.uid, 
                              thePost.postId
                            );

                            commentCtrl.text = "";
                          }
                        ),
                        const SizedBox(height: 30.0),
                        if (thePost.comments != null)
                          ...thePost.comments!.asMap().entries.map((entry) {
                            int index = entry.key;
                            PostrobeComment comment = entry.value;

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: FindrobeComment(comment: comment, user: comment.user, levelCount: thePost.comments!.length - 1 - index)
                            );
                          }
                        ), 
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