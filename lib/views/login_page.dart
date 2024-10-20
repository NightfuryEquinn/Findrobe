import 'package:findrobe_app/global/loading_overlay.dart';
import 'package:findrobe_app/providers/auth_data_provider.dart';
import 'package:findrobe_app/providers/others/loading_provider.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:findrobe_app/widgets/findrobe_button.dart';
import 'package:findrobe_app/widgets/findrobe_textbutton.dart';
import 'package:findrobe_app/widgets/findrobe_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  bool isOverlayShown = false;
  bool workAround = false;

  Future<void> _signInUser(BuildContext context, WidgetRef ref, String email, String password) async {
    ref.read(loadingProvider.notifier).show();

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        User? user = await ref.read(authDataNotifierProvider.notifier).signInUser(email, password);

        if (user != null) {
          Navigator.pushReplacementNamed(context, "/home");
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.beige,
              content: Text(
                "Login failed. Please check your credentials!",
                style: AppFonts.forum16black,
              ),
              duration: const Duration(seconds: 3)
            )
          );
        }

        if (!workAround) {
          workAround = true; 

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.beige,
              content: Text(
                "Please press login again...",
                style: AppFonts.forum16black,
              ),
              duration: const Duration(seconds: 3)
            )
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.beige,
            content: Text(
              "An error occured: $e",
              style: AppFonts.forum16black,
            ),
            duration: const Duration(seconds: 2)
          )
        );
      }
    }

    ref.read(loadingProvider.notifier).hide();
  }

  @override
  Widget build(BuildContext context) {  
    final isLoading = ref.watch(loadingProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isLoading && !isOverlayShown) {
        isOverlayShown = true;

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const LoadingOverlay();
          }
        );
      } else if (!isLoading && isOverlayShown) {
        if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
          isOverlayShown = false;
        }
      }
    });

    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [                  
                Image.asset(
                  "assets/logo.png",
                  width: 250,
                  height: 250,
                ),
                const SizedBox(height: 10.0),
                FindrobeTextfield(
                  labelText: "Email Address", 
                  controller: emailCtrl,
                  isEmail: true,
                ),
                const SizedBox(height: 20.0),
                FindrobeTextfield(
                  labelText: "Password", 
                  controller: passwordCtrl,
                  isSecure: true,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FindrobeTextbutton(
                    labelText: "Forgot Password?",
                    onPressed: () => Navigator.pushNamed(context, "/reset"),
                  )
                ),
                const SizedBox(height: 120.0),
                FindrobeButton(
                  buttonText: "Login", 
                  onPressed: () {
                    _signInUser(
                      context,
                      ref, 
                      emailCtrl.text, 
                      passwordCtrl.text
                    );
                  },
                  width: 140.0,
                ),
                const SizedBox(height: 15.0),
                Align(
                  alignment: Alignment.center,
                  child: FindrobeTextbutton(
                    labelText: "Don't have an account yet?",
                    onPressed: () => Navigator.pushNamed(context, "/register"),
                  )
                ),
              ],
            ),
          )
        )
      )
    );
  }
}