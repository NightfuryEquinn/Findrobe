import 'package:flutter/material.dart';

class PostrobeAddPage extends StatefulWidget {
  const PostrobeAddPage({super.key});

  @override
  State<PostrobeAddPage> createState() => _PostrobeAddPageState();
}

class _PostrobeAddPageState extends State<PostrobeAddPage> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('PostrobeAdd'),
        ),
      ),
    );
  }
}