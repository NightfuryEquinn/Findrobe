import 'package:findrobe_app/constants/findrobe_collection.dart';
import 'package:findrobe_app/providers/dropdown_provider.dart';
import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DropdownSection<T> {
  final String sectionTitle;
  final List<T> items;

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
    final dropdownNotifier = ref.read(dropdownProvider.notifier);

    List<DropdownSection<dynamic>> sections = [
      DropdownSection(
        sectionTitle: "Top Wear",
        items: TopWear.values
      ),
      DropdownSection(
        sectionTitle: "Bottom Wear",
        items: BottomWear.values
      ),
      DropdownSection(
        sectionTitle: "Footwear",
        items: Footwear.values
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
            value: selectedValue,
            hint: Text(
              "Select a Category",
              style: AppFonts.forum16white,
            ),
            onChanged: (newValue) {
              dropdownNotifier.selectItem(newValue);
            },
            menuMaxHeight: 450.0,
            borderRadius: BorderRadius.circular(10.0),
            dropdownColor: AppColors.white,
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
                      color: AppColors.black,
                      borderRadius: BorderRadius.circular(5.0)
                    ),
                    child: Text(
                      section.sectionTitle,
                      style: AppFonts.poiret20,
                    )
                  )
                ),
                ...section.items.map((item) {
                  return DropdownMenuItem<String>(
                    value: item.toString().toUpperCase(),
                    child: Text(
                      item.toString().split('.').last[0].toUpperCase() + item.toString().split('.').last.substring(1),
                      style: AppFonts.forum16black,
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