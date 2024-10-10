import 'package:findrobe_app/animations/fade_route.dart';
import 'package:findrobe_app/constants/arguments.dart';
import 'package:findrobe_app/firebase/auth_repo.dart';
import 'package:findrobe_app/firebase_options.dart';
import 'package:findrobe_app/routes/findrobe_bottombar.dart';
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
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepo = AuthRepo();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: authRepo.getCurrentUser() != null ? const FindrobeBottomBar() : const LoginPage(),
      onGenerateRoute: (RouteSettings settings) {
        Widget page;

        switch (settings.name) {
          case "/collection_add":
            final EditCollectionArgs? args = settings.arguments as EditCollectionArgs?;

            page = CollectionAddPage(
              args: args
            );
            break;
          case "/collection":
            page = const CollectionPage();
            break;
          case "/collection_single":
            page = const CollectionSinglePage();
            break;
          case "/findrobe":
            page = const FindrobePage();
            break;
          case "/login":
            page = const LoginPage();
            break;
          case "/postrobe_add":
            page = const PostrobeAddPage();
            break;
          case "/postrobe":
            page = const PostrobePage();
            break;
          case "/postrobe_single":
            page = const PostrobeSinglePage();
            break;
          case "/profile":
            page = const ProfilePage();
            break;
          case "/register":
            page = const RegisterPage();
            break;
          case "/reset":
            page = const ResetPage();
            break;
          case "/view_user":
            page = const ViewUserPage();
            break;
          case "/home":
            page = const FindrobeBottomBar();
            break;
          default:
            page = const LoginPage();
        }

        return FadeRoute(page: page);
      },
       
    );
  }
}
