import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/widgets/findrobe_button.dart';
import 'package:findrobe_app/widgets/findrobe_textbutton.dart';
import 'package:findrobe_app/widgets/findrobe_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
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