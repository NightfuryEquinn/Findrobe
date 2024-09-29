import 'package:flutter/material.dart';

class PostrobeSinglePage extends StatefulWidget {
  const PostrobeSinglePage({super.key});

  @override
  State<PostrobeSinglePage> createState() => _PostrobeSinglePageState();
}

class _PostrobeSinglePageState extends State<PostrobeSinglePage> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('PostrobeSingle'),
        ),
      ),
    );
  }
}