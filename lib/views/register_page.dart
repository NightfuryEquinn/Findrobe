import 'package:findrobe_app/firebase/auth_repo.dart';
import 'package:findrobe_app/global/loading_overlay.dart';
import 'package:findrobe_app/providers/loading_provider.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:findrobe_app/widgets/findrobe_button.dart';
import 'package:findrobe_app/widgets/findrobe_textbutton.dart';
import 'package:findrobe_app/widgets/findrobe_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmCtrl = TextEditingController();
  final TextEditingController usernameCtrl = TextEditingController();
  bool isOverlayShown = false;
  bool workAround = false;

  Future<void> _registerNewUser(BuildContext context, WidgetRef ref, String email, String password, String confirm, String username) async {
    final authRepo = AuthRepo();

    if (email.isEmpty || password.isEmpty || confirm.isEmpty || username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.beige,
          content: Text(
            "All fields are required!",
            style: AppFonts.forum16black,
          ),
          duration: const Duration(seconds: 3)
        )
      );

      return;
    }

    if (password.length <= 7) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.beige,
          content: Text(
            "Use a password more than 8 characters!",
            style: AppFonts.forum16black,
          ),
          duration: const Duration(seconds: 3)
        )
      );

      return;
    }

    if (password != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.beige,
          content: Text(
            "Passwords do not match!",
            style: AppFonts.forum16black,
          ),
          duration: const Duration(seconds: 3)
        )
      );

      return;
    }

    ref.read(loadingProvider.notifier).show();

    final user = await authRepo.registerNewUser(email, password, username);

    if (user != null) {
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.beige,
          content: Text(
            "Registration failed. Please try again! Maybe due to existing email.",
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
            "Please login...",
            style: AppFonts.forum16black,
          ),
          duration: const Duration(seconds: 3)
        )
      );
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
                const SizedBox(height: 20.0),
                FindrobeTextfield(
                  labelText: "Confirm Password", 
                  controller: confirmCtrl,
                  isSecure: true,
                ),
                const SizedBox(height: 20.0),
                FindrobeTextfield(
                  labelText: "Username", 
                  controller: usernameCtrl,
                ),
                const SizedBox(height: 30.0),
                FindrobeButton(
                  buttonText: "Register", 
                  onPressed: () {
                    _registerNewUser(
                      context, 
                      ref, 
                      emailCtrl.text, 
                      passwordCtrl.text, 
                      confirmCtrl.text, 
                      usernameCtrl.text
                    );
                  },
                  width: 140.0,
                ),
                const SizedBox(height: 15.0),
                Align(
                  alignment: Alignment.center,
                  child: FindrobeTextbutton(
                    labelText: "Back",
                    onPressed: () => Navigator.pop(context),
                  )
                ),
              ],
            )
          )
        )
      )
    );
  }
}