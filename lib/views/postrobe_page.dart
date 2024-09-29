import 'package:flutter/material.dart';

class PostrobePage extends StatefulWidget {
  const PostrobePage({super.key});

  @override
  State<PostrobePage> createState() => _PostrobePageState();
}

class _PostrobePageState extends State<PostrobePage> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Postrobe'),
        ),
      ),
    );
  }
}