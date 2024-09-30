import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:findrobe_app/widgets/findrobe_button.dart';
import 'package:findrobe_app/widgets/findrobe_textbutton.dart';
import 'package:findrobe_app/widgets/findrobe_textfield.dart';
import 'package:flutter/material.dart';

class ResetPage extends StatefulWidget {
  const ResetPage({super.key});

  @override
  State<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  final TextEditingController emailCtrl = TextEditingController();

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                const SizedBox(height: 120.0),
                FindrobeButton(
                  buttonText: "Send Link", 
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Link sent! Check email.",
                          style: AppFonts.forum16white,
                        ), 
                        duration: const Duration(seconds: 2)
                      )
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
          ),
        )
      )  
    );
  }
}