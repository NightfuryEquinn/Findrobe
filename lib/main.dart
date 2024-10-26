import 'package:findrobe_app/animations/fade_route.dart';
import 'package:findrobe_app/constants/arguments.dart';
import 'package:findrobe_app/firebase_options.dart';
import 'package:findrobe_app/providers/client/auth_data_provider.dart';
import 'package:findrobe_app/routes/admin_findrobe_bottombar.dart';
import 'package:findrobe_app/routes/findrobe_bottombar.dart';
import 'package:findrobe_app/views/client/collection_add_page.dart';
import 'package:findrobe_app/views/client/collection_page.dart';
import 'package:findrobe_app/views/client/collection_single_page.dart';
import 'package:findrobe_app/views/client/findrobe_followers_page.dart';
import 'package:findrobe_app/views/client/login_page.dart';
import 'package:findrobe_app/views/client/postrobe_add_page.dart';
import 'package:findrobe_app/views/client/postrobe_page.dart';
import 'package:findrobe_app/views/client/postrobe_single_page.dart';
import 'package:findrobe_app/views/client/profile_page.dart';
import 'package:findrobe_app/views/client/register_page.dart';
import 'package:findrobe_app/views/client/reset_page.dart';
import 'package:findrobe_app/views/client/view_user_page.dart';
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
    final currentUser = ref.watch(authDataNotifierProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // State delayed sometimes causing admin boolean ignored
      // Which redirect admin to user screen
      // Temp solution is to exit the app and reload
      home: currentUser.user == null || currentUser.isRestricted ?
        const LoginPage()
      : currentUser.isAdmin ?
        const AdminFindrobeBottomBar()
      :
        const FindrobeBottomBar(),
      onGenerateRoute: (RouteSettings settings) {
        Widget page;

        switch (settings.name) {
          case "/admin_home":
            page = const AdminFindrobeBottomBar();
            break;
          case "/collection_add":
            final EditCollectionArgs? args = settings.arguments as EditCollectionArgs?;
            page = CollectionAddPage(
              args: args
            );
            break;
          case "/collection":
            final CollectionArgs args = settings.arguments as CollectionArgs;
            page = CollectionPage(
              args: args
            );
            break;
          case "/collection_single":
            final CollectionSingleArgs args = settings.arguments as CollectionSingleArgs;
            page = CollectionSinglePage(
              args: args,
            );
            break;
          case "/followers":
            final FollowersArgs args = settings.arguments as FollowersArgs;
            page = FindrobeFollowersPage(
              args: args
            );
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
            final PostrobeSingleArgs args = settings.arguments as PostrobeSingleArgs;
            page = PostrobeSinglePage(
              args: args,
            );
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
            final ViewUserArgs args = settings.arguments as ViewUserArgs;
            page = ViewUserPage(
              args: args,
            );
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
