import 'package:findrobe_app/constants/findrobe_collection.dart';
import 'package:findrobe_app/global/text_formatter.dart';
import 'package:findrobe_app/providers/dropdown_provider.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DropdownSection<T> {
  final String sectionTitle;
  final List<String> items;

  DropdownSection({
    required this.sectionTitle,
    required this.items
  });
}

class FindrobeDropdown extends ConsumerWidget {
  final String labelText;

  const FindrobeDropdown({
    super.key,
    required this.labelText
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedValue = ref.watch(dropdownProvider);

    List<DropdownSection<String>> sections = [
      DropdownSection(
        sectionTitle: "Top Wear",
        items: TopWear.values.map((item) => item.toString()).toList()
      ),
      DropdownSection(
        sectionTitle: "Bottom Wear",
        items: BottomWear.values.map((item) => item.toString()).toList()
      ),
      DropdownSection(
        sectionTitle: "Footwear",
        items: Footwear.values.map((item) => item.toString()).toList()
      )
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          labelText,
          style: AppFonts.poiret16,
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 5.0),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.black,
            borderRadius: BorderRadius.circular(10.0)
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: DropdownButton<String>(
            iconSize: 0.0,
            value: selectedValue,
            hint: Text(
              "Select a Category",
              style: AppFonts.forum16white,
            ),
            onChanged: (newValue) {
              ref.read(dropdownProvider.notifier).selectItem(newValue);
            },
            menuMaxHeight: 450.0,
            borderRadius: BorderRadius.circular(10.0),
            dropdownColor: AppColors.black,
            underline: const SizedBox.shrink(),
            items: sections.expand((section) {
              return [
                DropdownMenuItem<String>(
                  enabled: false,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 5.0
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(5.0)
                    ),
                    width: 300.0,
                    child: Text(
                      section.sectionTitle,
                      style: AppFonts.poiret20,
                    )
                  )
                ),
                ...section.items.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      formatFindrobeCollection(category: item),
                      style: AppFonts.forum16white,
                    )
                  );
                }),
              ];
            }).toList()
          )
        )
      ]
    );
  }
}