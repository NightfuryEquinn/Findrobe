import 'package:findrobe_app/constants/findrobe_collection.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/widgets/collection_button.dart';
import 'package:findrobe_app/widgets/collection_header.dart';
import 'package:findrobe_app/widgets/findrobe_button.dart';
import 'package:findrobe_app/widgets/findrobe_header.dart';
import 'package:flutter/material.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
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
                      for (var topWear in TopWear.values)
                        Padding(
                          padding: const EdgeInsetsDirectional.symmetric(vertical: 2.5),
                          child: CollectionButton(
                            onTap: () {
                              Navigator.pushNamed(context, "/collection_single");
                            },
                            placeholderImage: "https://image.uniqlo.com/UQ/ST3/AsianCommon/imagesgoods/467134/sub/goods_467134_sub14.jpg?width=600", 
                            title: topWear.name, 
                            punchline: "Plain and never fails..."
                          )
                        ),
                      const SizedBox(height: 30.0),
                      const CollectionHeader(headerText: "Bottom Wear"),
                      const SizedBox(height: 5.0),
                      for (var bottomWear in BottomWear.values)
                        Padding(
                          padding: const EdgeInsetsDirectional.symmetric(vertical: 2.5),
                          child: CollectionButton(
                            onTap: () {
                              print("Selected: $bottomWear.name");
                            },
                            placeholderImage: "https://image.uniqlo.com/UQ/ST3/AsianCommon/imagesgoods/467134/sub/goods_467134_sub14.jpg?width=600", 
                            title: bottomWear.name, 
                            punchline: "Plain and never fails..."
                          )
                        ),
                      const SizedBox(height: 30.0),
                      const CollectionHeader(headerText: "Footwear"),
                      const SizedBox(height: 5.0),
                      for (var footwear in Footwear.values)
                        Padding(
                          padding: const EdgeInsetsDirectional.symmetric(vertical: 2.5),
                          child: CollectionButton(
                            onTap: () {
                              print("Selected: $footwear.name");
                            },
                            placeholderImage: "https://image.uniqlo.com/UQ/ST3/AsianCommon/imagesgoods/467134/sub/goods_467134_sub14.jpg?width=600", 
                            title: footwear.name, 
                            punchline: "Plain and never fails..."
                          )
                        ),
                    ]
                  )
                )
              ),
              const SizedBox(height: 30.0),
              FindrobeButton(
                buttonText: "Add Clothing", 
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