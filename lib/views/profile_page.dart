import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/widgets/findrobe_header.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
              FindrobeHeader(headerTitle: "My Profile"),
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