import 'package:flutter/material.dart';

class CollectionSinglePage extends StatefulWidget {
  const CollectionSinglePage({super.key});

  @override
  State<CollectionSinglePage> createState() => _CollectionSinglePageState();
}

class _CollectionSinglePageState extends State<CollectionSinglePage> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('CollectionSingle'),
        ),
      ),
    );
  }
}