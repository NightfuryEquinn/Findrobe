import 'package:flutter/material.dart';

class ViewUserPage extends StatefulWidget {
  const ViewUserPage({super.key});

  @override
  State<ViewUserPage> createState() => _ViewUserPageState();
}

class _ViewUserPageState extends State<ViewUserPage> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('ViewUser'),
        ),
      ),
    );
  }
}