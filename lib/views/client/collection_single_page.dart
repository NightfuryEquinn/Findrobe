import 'package:findrobe_app/constants/arguments.dart';
import 'package:findrobe_app/models/clothing.dart';
import 'package:findrobe_app/providers/client/auth_data_provider.dart';
import 'package:findrobe_app/providers/client/collection_data_provider.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/widgets/collection_single_field.dart';
import 'package:findrobe_app/widgets/collection_single_select.dart';
import 'package:findrobe_app/widgets/findrobe_empty.dart';
import 'package:findrobe_app/widgets/findrobe_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CollectionSinglePage extends ConsumerStatefulWidget {
  final CollectionSingleArgs args;

  const CollectionSinglePage({
    super.key,
    required this.args
  });

  @override
  ConsumerState<CollectionSinglePage> createState() => _CollectionSinglePageState();
}

class _CollectionSinglePageState extends ConsumerState<CollectionSinglePage> {
  @override
  void initState() {
    super.initState();

    final currentUser = ref.read(authDataNotifierProvider);

    if (currentUser != null) {
      Future.microtask(() async {
        await Future.wait([
          ref.read(collectionDataNotifierProvider.notifier).fetchClothing(currentUser.uid, widget.args.category)
        ]);
      });
    }
  }

  Future<void> _refreshCollection() async {
    final currentUser = ref.read(authDataNotifierProvider);

    if (currentUser != null) {
      Future.microtask(() async {
        await Future.wait([
          ref.read(collectionDataNotifierProvider.notifier).fetchClothing(currentUser.uid, widget.args.category)
        ]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<FindrobeClothing> clothings = ref.watch(collectionDataNotifierProvider);
    
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              FindrobeHeader(headerTitle: widget.args.category),
              const SizedBox(height: 30.0),
              Expanded(
                child: RefreshIndicator(
                  color: AppColors.black,
                  backgroundColor: AppColors.beige,
                  onRefresh: _refreshCollection,
                  child: clothings.isEmpty ?
                    const FindrobeEmpty(labelText: "Fetching clothings...")
                  :
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: clothings.length,
                      itemBuilder: (context, index) {
                        final clothing = clothings[index];

                        return !widget.args.isFromCollection ?
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: CollectionSingleField(clothing: clothing)
                          )
                        :
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: CollectionSingleSelect(type: widget.args.type, clothing: clothing)
                          );
                      },
                    ),
                )
              )
            ]
          )
        )
      )
    );
  }
}