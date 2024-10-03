import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/widgets/findrobe_header.dart';
import 'package:findrobe_app/widgets/findrobe_post_card.dart';
import 'package:flutter/material.dart';

class PostrobePage extends StatefulWidget {
  const PostrobePage({super.key});

  @override
  State<PostrobePage> createState() => _PostrobePageState();
}

class _PostrobePageState extends State<PostrobePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.grey,
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: [
              FindrobeHeader(headerTitle: "Postrobe"),
              SizedBox(height: 30.0),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FindrobePostCard(postId: "1"),
                      SizedBox(height: 15.0),
                      FindrobePostCard(postId: "2"),
                      SizedBox(height: 15.0),
                      FindrobePostCard(postId: "3"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}