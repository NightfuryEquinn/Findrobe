import 'package:findrobe_app/constants/arguments.dart';
import 'package:findrobe_app/constants/findrobe_display.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/widgets/collection_button.dart';
import 'package:findrobe_app/widgets/collection_header.dart';
import 'package:findrobe_app/widgets/findrobe_button.dart';
import 'package:findrobe_app/widgets/findrobe_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CollectionPage extends ConsumerStatefulWidget {
  const CollectionPage({super.key});

  @override
  ConsumerState<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends ConsumerState<CollectionPage> {
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
              const FindrobeHeader(headerTitle: "Collection"),
              const SizedBox(height: 30.0),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const CollectionHeader(headerText: "Top Wear"),
                      const SizedBox(height: 5.0),
                      for (var topWear in TopWearList.values)
                        Padding(
                          padding: const EdgeInsetsDirectional.symmetric(vertical: 2.5),
                          child: CollectionButton(
                            onTap: () {
                              Navigator.pushNamed(
                                context, 
                                "/collection_single",
                                arguments: CollectionSingleArgs(
                                  category: topWear.name
                                )
                              );
                            },
                            placeholderImage: topWear.image, 
                            title: topWear.name, 
                            punchline: topWear.punchline
                          )
                        ),
                      const SizedBox(height: 30.0),
                      const CollectionHeader(headerText: "Bottom Wear"),
                      const SizedBox(height: 5.0),
                      for (var bottomWear in BottomWearList.values)
                        Padding(
                          padding: const EdgeInsetsDirectional.symmetric(vertical: 2.5),
                          child: CollectionButton(
                            onTap: () {
                              Navigator.pushNamed(
                                context, 
                                "/collection_single",
                                arguments: CollectionSingleArgs(
                                  category: bottomWear.name
                                )
                              );
                            },
                            placeholderImage: bottomWear.image, 
                            title: bottomWear.name, 
                            punchline: bottomWear.punchline
                          )
                        ),
                      const SizedBox(height: 30.0),
                      const CollectionHeader(headerText: "Footwear"),
                      const SizedBox(height: 5.0),
                      for (var footwear in FootwearList.values)
                        Padding(
                          padding: const EdgeInsetsDirectional.symmetric(vertical: 2.5),
                          child: CollectionButton(
                            onTap: () {
                              Navigator.pushNamed(
                                context, 
                                "/collection_single",
                                arguments: CollectionSingleArgs(
                                  category: footwear.name
                                )
                              );
                            },
                            placeholderImage: footwear.image, 
                            title: footwear.name, 
                            punchline: footwear.punchline
                          )
                        ),
                    ]
                  )
                )
              ),
              const SizedBox(height: 30.0),
              FindrobeButton(
                buttonText: "Add Clothing to Collection", 
                onPressed: () {
                  Navigator.pushNamed(context, "/collection_add");
                }
              )
            ]
          )
        )
      )
    );
  }
}