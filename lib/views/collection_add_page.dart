import 'package:flutter/material.dart';

class CollectionAddPage extends StatefulWidget {
  const CollectionAddPage({super.key});

  @override
  State<CollectionAddPage> createState() => _CollectionAddPageState();
}

class _CollectionAddPageState extends State<CollectionAddPage> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('CollectionAdd'),
        ),
      ),
    );
  }
}