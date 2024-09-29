import 'package:findrobe_app/firebase_options.dart';
import 'package:findrobe_app/views/collection_add_page.dart';
import 'package:findrobe_app/views/collection_page.dart';
import 'package:findrobe_app/views/collection_single_page.dart';
import 'package:findrobe_app/views/findrobe_page.dart';
import 'package:findrobe_app/views/login_page.dart';
import 'package:findrobe_app/views/postrobe_add_page.dart';
import 'package:findrobe_app/views/postrobe_page.dart';
import 'package:findrobe_app/views/postrobe_single_page.dart';
import 'package:findrobe_app/views/profile_page.dart';
import 'package:findrobe_app/views/register_page.dart';
import 'package:findrobe_app/views/reset_page.dart';
import 'package:findrobe_app/views/view_user_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
    
    print("Firebase initialized successfully.");
  } catch (error) {
    print("Error initializing Firebase: $error");
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/login",
      routes: {
        "/collection_add": (context) => const CollectionAddPage(),
        "/collection": (context) => const CollectionPage(),
        "/collection_single": (context) => const CollectionSinglePage(),
        "/findrobe": (context) => const FindrobePage(),
        "/login": (context) => const LoginPage(),
        "/postrobe_add": (context) => const PostrobeAddPage(),
        "/postrobe": (context) => const PostrobePage(),
        "/postrobe_single": (context) => const PostrobeSinglePage(),
        "/profile": (context) => const ProfilePage(),
        "/register": (context) => const RegisterPage(),
        "/reset": (context) => const ResetPage(),
        "/view_user": (context) => const ViewUserPage()
      },
    );
  }
}
