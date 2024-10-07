import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/widgets/collection_single_field.dart';
import 'package:findrobe_app/widgets/findrobe_header.dart';
import 'package:flutter/material.dart';

class CollectionSinglePage extends StatefulWidget {
  const CollectionSinglePage({super.key});

  @override
  State<CollectionSinglePage> createState() => _CollectionSinglePageState();
}

class _CollectionSinglePageState extends State<CollectionSinglePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.grey,
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: [
              FindrobeHeader(headerTitle: "Collection"),
              SizedBox(height: 30.0),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CollectionSingleField(
                        name: "Jeans", 
                        image: "https://image.uniqlo.com/UQ/ST3/AsianCommon/imagesgoods/467134/sub/goods_467134_sub14.jpg?width=494"
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