import 'package:flutter/material.dart';

class FindrobePage extends StatefulWidget {
  const FindrobePage({super.key});

  @override
  State<FindrobePage> createState() => _FindrobePageState();
}

class _FindrobePageState extends State<FindrobePage> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Findrobe'),
        ),
      ),
    );
  }
}