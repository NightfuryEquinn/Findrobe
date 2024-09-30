import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/widgets/findrobe_button.dart';
import 'package:findrobe_app/widgets/findrobe_textbutton.dart';
import 'package:findrobe_app/widgets/findrobe_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmCtrl = TextEditingController();
  final TextEditingController usernameCtrl = TextEditingController();

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