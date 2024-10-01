import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/widgets/findrobe_header.dart';
import 'package:flutter/material.dart';

class PostrobeAddPage extends StatefulWidget {
  const PostrobeAddPage({super.key});

  @override
  State<PostrobeAddPage> createState() => _PostrobeAddPageState();
}

class _PostrobeAddPageState extends State<PostrobeAddPage> {
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
              FindrobeHeader(headerTitle: "Add Post"),
              SizedBox(height: 30.0),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                  
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