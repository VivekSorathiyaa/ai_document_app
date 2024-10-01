import 'package:ai_document_app/utils/app_asset.dart';
import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/color.dart';
import 'package:ai_document_app/utils/gradient_border_widget.dart';
import 'package:ai_document_app/utils/primary_text_button.dart';
import 'package:ai_document_app/utils/static_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FilterDialog extends StatelessWidget {
  final String title;
  final List<Widget> filterOptions; // Accepts a list of custom widgets
  final Function(List<String>) onApplyFilters;

  FilterDialog({
    required this.title,
    required this.filterOptions,
    required this.onApplyFilters,
  });

  @override
  Widget build(BuildContext context) {
    final selectedFilters =
        <String>[].obs; // Reactive list for selected filters

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: bgBlackColor,
      child: GradientBorderWidget(
        // colors: const [orangeColor, purpleColor],
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
          decoration: BoxDecoration(
            color: bgBlackColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: darkDividerColor),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(AppAsset.filter),
                  width15,
                  Expanded(
                    child: Text(
                      title,
                      style: AppTextStyle.normalBold16
                          .copyWith(color: primaryWhite),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                child: Column(
                  children: filterOptions.map((widget) {
                    return widget;
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(), // Close the dialog
                      child: Text('Cancel',
                          style: AppTextStyle.normalBold16
                              .copyWith(color: primaryWhite)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: PrimaryTextButton(
                      title: "Apply",
                      onPressed: () {
                        onApplyFilters(selectedFilters.toList());
                        Get.back(); // Close the dial
                      },
                      height: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
