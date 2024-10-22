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
  final CollectionArgs args;

  const CollectionPage({
    super.key,
    required this.args
  });

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
                      widget.args.type == "Top Wear" && widget.args.isFromCollection ?
                        Wrap(
                          spacing: 1.0,
                          runSpacing: 1.0,
                          children: [
                            const CollectionHeader(headerText: "Top Wear"),
                            const SizedBox(height: 5.0),
                            ...TopWearList.values.map(
                              (topWear) => Padding(
                                padding: const EdgeInsetsDirectional.symmetric(vertical: 2.5),
                                child: CollectionButton(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context, 
                                      "/collection_single",
                                      arguments: CollectionSingleArgs(
                                        category: topWear.name,
                                        type: widget.args.type,
                                        isFromCollection: widget.args.isFromCollection
                                      )
                                    );
                                  },
                                  placeholderImage: topWear.image, 
                                  title: topWear.name, 
                                  punchline: topWear.punchline
                                )
                              ),
                            ),
                            const SizedBox(height: 30.0)
                          ],
                        )
                      : widget.args.type == "" && !widget.args.isFromCollection ?
                        Wrap(
                          spacing: 1.0,
                          runSpacing: 1.0,
                          children: [
                            const CollectionHeader(headerText: "Top Wear"),
                            const SizedBox(height: 5.0),
                            ...TopWearList.values.map(
                              (topWear) => Padding(
                                padding: const EdgeInsetsDirectional.symmetric(vertical: 2.5),
                                child: CollectionButton(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context, 
                                      "/collection_single",
                                      arguments: CollectionSingleArgs(
                                        category: topWear.name,
                                        type: widget.args.type,
                                      )
                                    );
                                  },
                                  placeholderImage: topWear.image, 
                                  title: topWear.name, 
                                  punchline: topWear.punchline
                                )
                              ),
                            ),
                            const SizedBox(height: 30.0)
                          ],
                        )
                      :
                        const SizedBox.shrink(),
                      widget.args.type == "Bottom Wear" && widget.args.isFromCollection ?
                        Wrap(
                          spacing: 1.0,
                          runSpacing: 1.0,
                          children: [
                            const CollectionHeader(headerText: "Bottom Wear"),
                            const SizedBox(height: 5.0),
                            ...BottomWearList.values.map(
                            (bottomWear) => Padding(
                                padding: const EdgeInsetsDirectional.symmetric(vertical: 2.5),
                                child: CollectionButton(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context, 
                                      "/collection_single",
                                      arguments: CollectionSingleArgs(
                                        category: bottomWear.name,
                                        type: widget.args.type,
                                        isFromCollection: widget.args.isFromCollection
                                      )
                                    );
                                  },
                                  placeholderImage: bottomWear.image, 
                                  title: bottomWear.name, 
                                  punchline: bottomWear.punchline
                                )
                              ),
                            ),
                            const SizedBox(height: 30.0),
                          ],
                        )
                      : widget.args.type == "" && !widget.args.isFromCollection ?
                        Wrap(
                          spacing: 1.0,
                          runSpacing: 1.0,
                          children: [
                            const CollectionHeader(headerText: "Bottom Wear"),
                            const SizedBox(height: 5.0),
                            ...BottomWearList.values.map(
                            (bottomWear) => Padding(
                                padding: const EdgeInsetsDirectional.symmetric(vertical: 2.5),
                                child: CollectionButton(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context, 
                                      "/collection_single",
                                      arguments: CollectionSingleArgs(
                                        category: bottomWear.name,
                                        type: widget.args.type,
                                      )
                                    );
                                  },
                                  placeholderImage: bottomWear.image, 
                                  title: bottomWear.name, 
                                  punchline: bottomWear.punchline
                                )
                              ),
                            ),
                            const SizedBox(height: 30.0),
                          ],
                        )
                      :
                        const SizedBox.shrink(),
                      widget.args.type == "Footwear" && widget.args.isFromCollection ?
                        Wrap(
                          spacing: 1.0,
                          runSpacing: 1.0,
                          children: [
                            const CollectionHeader(headerText: "Footwear"),
                            const SizedBox(height: 5.0),
                            ...FootwearList.values.map(
                              (footwear) => Padding(
                                padding: const EdgeInsetsDirectional.symmetric(vertical: 2.5),
                                child: CollectionButton(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context, 
                                      "/collection_single",
                                      arguments: CollectionSingleArgs(
                                        category: footwear.name,
                                        type: widget.args.type,
                                        isFromCollection: widget.args.isFromCollection
                                      )
                                    );
                                  },
                                  placeholderImage: footwear.image, 
                                  title: footwear.name, 
                                  punchline: footwear.punchline
                                )
                              ),
                            )
                          ],
                        )
                      : widget.args.type == "" && !widget.args.isFromCollection ?
                        Wrap(
                          spacing: 1.0,
                          runSpacing: 1.0,
                          children: [
                            const CollectionHeader(headerText: "Footwear"),
                            const SizedBox(height: 5.0),
                            ...FootwearList.values.map(
                              (footwear) => Padding(
                                padding: const EdgeInsetsDirectional.symmetric(vertical: 2.5),
                                child: CollectionButton(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context, 
                                      "/collection_single",
                                      arguments: CollectionSingleArgs(
                                        category: footwear.name,
                                        type: widget.args.type,
                                      )
                                    );
                                  },
                                  placeholderImage: footwear.image, 
                                  title: footwear.name, 
                                  punchline: footwear.punchline
                                )
                              ),
                            )
                          ],
                        )
                      :
                        const SizedBox.shrink()
                    ]
                  )
                )
              ),
              const SizedBox(height: 30.0),
              !widget.args.isFromCollection ?
                FindrobeButton(
                  buttonText: "Add Clothing to Collection", 
                  onPressed: () {
                    Navigator.pushNamed(context, "/collection_add");
                  }
                )
              :
                const SizedBox.shrink()
            ]
          )
        )
      )
    );
  }
}