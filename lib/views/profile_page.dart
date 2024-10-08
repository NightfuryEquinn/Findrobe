import 'package:findrobe_app/firebase/auth_repo.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:findrobe_app/widgets/findrobe_button.dart';
import 'package:findrobe_app/widgets/findrobe_header.dart';
import 'package:findrobe_app/widgets/findrobe_post_card.dart';
import 'package:findrobe_app/widgets/findrobe_textfield.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController userCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();

  Future<void> _logoutUser() async {
    final authRepo = AuthRepo();
    await authRepo.logoutUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const FindrobeHeader(headerTitle: "My Profile"),
              const SizedBox(height: 30.0),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                print("Update image");
                              },
                              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Image.network(
                                  "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg",
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              )
                            ),
                          ),
                          const SizedBox(width: 15.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "Nightfury",
                                style: AppFonts.poiret24
                              ),
                              const SizedBox(height: 5.0),
                              SizedBox(
                                width: 200.0,
                                child: Text(
                                  "Registered since 26 September 2024",
                                  style: AppFonts.poiret12,
                                  softWrap: true,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Posts Written",
                                      style: AppFonts.poiret16
                                    ),
                                    Text(
                                      "20",
                                      style: AppFonts.poiret16
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Comments Written",
                                      style: AppFonts.poiret16
                                    ),
                                    Text(
                                      "20",
                                      style: AppFonts.poiret16
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total Followers",
                                      style: AppFonts.poiret16
                                    ),
                                    Text(
                                      "20",
                                      style: AppFonts.poiret16
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        )
                      ),
                      const SizedBox(height: 10.0),
                      const Divider(
                        indent: 25.0,
                        endIndent: 25.0,
                        thickness: 2.0,
                        color: AppColors.overlayBlack,
                      ),
                      const SizedBox(height: 10.0),
                      FindrobeTextfield(labelText: "Username", controller: userCtrl),
                      const SizedBox(height: 20.0),
                      FindrobeTextfield(labelText: "Email Address", controller: emailCtrl, isEmail: true),
                      const SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FindrobeButton(
                            width: 150.0,
                            buttonText: "Log Out", 
                            alternative: true,
                            buttonColor: AppColors.black,
                            onPressed: () {
                              _logoutUser();
                              Navigator.pushReplacementNamed(context, "/login");
                            }
                          ),
                          FindrobeButton(
                            width: 150.0,
                            buttonText: "Update", 
                            onPressed: () {

                            }
                          )
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      const Divider(
                        indent: 25.0,
                        endIndent: 25.0,
                        thickness: 2.0,
                        color: AppColors.overlayBlack,
                      ),
                      const SizedBox(height: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Recent Posts",
                            style: AppFonts.poiret24,
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 5.0),
                          const FindrobePostCard(postId: "1"),
                          const SizedBox(height: 15.0),
                          const FindrobePostCard(postId: "2"),
                          const SizedBox(height: 15.0),
                          const FindrobePostCard(postId: "3"),
                        ]
                      )
                    ],
                  )
                )
              )
            ]
          )
        )
      )
    );
  }
}