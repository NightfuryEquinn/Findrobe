import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/widgets/findrobe_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FindrobeFollowersPage extends ConsumerStatefulWidget {
  const FindrobeFollowersPage({super.key});

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
    return const Scaffold(
      backgroundColor: AppColors.grey,
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: [
              FindrobeHeader(headerTitle: "My Followers"),
              SizedBox(height: 30.0),
              Expanded(
                child: SingleChildScrollView(
                )
              )
            ],
          )
        )
      ),
    );
  }
}