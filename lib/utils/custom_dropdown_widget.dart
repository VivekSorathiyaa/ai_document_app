import 'package:ai_document_app/utils/color.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'app_text_style.dart';

enum SelectionMode { single, multi }

class CustomDropdown extends StatelessWidget {
  final List<dynamic>? items;
  final List<dynamic>? selectedValues;
  final String hintText;
  final ValueChanged<List<dynamic>> onChanged;
  final String Function(dynamic)? displayItem; // Custom display function
  final SelectionMode selectionMode; // Selection mode

  CustomDropdown({
    Key? key,
    this.items,
    this.selectedValues,
    required this.hintText,
    required this.onChanged,
    this.displayItem,
    this.selectionMode = SelectionMode.single,
  }) : super(key: key);

  var dropdownIsOpen = false.obs;

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;

    // Determine button label based on selection mode
    String buttonLabel;
    if (selectionMode == SelectionMode.single) {
      buttonLabel = selectedValues?.isNotEmpty == true
          ? displayItem!(selectedValues!.first)
          : hintText;
    } else {
      // Multi-selection: show names of selected items or hintText
      buttonLabel = selectedValues?.isNotEmpty == true
          ? selectedValues!.map((e) => displayItem!(e)).join(', ')
          : hintText;
    }

    return DropdownButtonHideUnderline(
      child: DropdownButton2<dynamic>(
          menuItemStyleData: MenuItemStyleData(
              height: isDesktop ? 45 : 38,
              padding: EdgeInsets.symmetric(horizontal: isDesktop ? 14 : 10),
              selectedMenuItemBuilder: (context, child) {
                return Row(
                  children: [
                    Expanded(child: child),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 16),
                      child: Icon(
                        Icons.check,
                        color: primaryWhite,
                        size: 20,
                      ),
                    ), // Add checkmark for selected item
                  ],
                );
              }),
          value: selectionMode == SelectionMode.single
              ? (selectedValues?.isNotEmpty == true
                  ? selectedValues!.first
                  : null)
              : null, // For multi, value is set to null
          items: items!.map((item) {
            final isSelected = selectedValues?.contains(item) ?? false;
            return DropdownMenuItem<dynamic>(
              value: item,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      displayItem != null
                          ? displayItem!(item)
                          : item.toString(),
                      style: isDesktop
                          ? AppTextStyle.normalRegular16
                          : AppTextStyle.normalRegular14,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (isSelected &&
                      selectionMode ==
                          SelectionMode
                              .multi) // Show checkmark for selected items
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 16),
                      child: Icon(
                        Icons.check,
                        color: primaryWhite,
                        size: 20,
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
          isExpanded: true,
          isDense: true,
          hint: Row(
            children: [
              Expanded(
                child: Text(
                  buttonLabel,
                  style: isDesktop
                      ? AppTextStyle.normalRegular16
                      : AppTextStyle.normalRegular14,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          onChanged: (newValue) {
            if (newValue != null) {
              if (selectionMode == SelectionMode.single) {
                onChanged([newValue]); // Single selection
              } else {
                final currentSelection =
                    List<dynamic>.from(selectedValues ?? []);
                if (currentSelection.contains(newValue)) {
                  currentSelection.remove(newValue);
                } else {
                  currentSelection.add(newValue);
                }
                onChanged(currentSelection);
              }
            }
          },
          onMenuStateChange: (isOpen) {
            dropdownIsOpen.value = isOpen;
          },
          buttonStyleData: ButtonStyleData(
            height: isDesktop ? 45 : 38,
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: isDesktop ? primaryBlack : bgBlackColor,
            ),
          ),
          iconStyleData: IconStyleData(
            icon: FittedBox(
              fit: BoxFit.scaleDown,
              child: Obx(
                () => Icon(
                  dropdownIsOpen.value
                      ? CupertinoIcons.chevron_up
                      : CupertinoIcons.chevron_down,
                  color: primaryWhite,
                  size: isDesktop ? 25 : 20,
                ),
              ),
            ),
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: isDesktop ? 300 : 200,
            elevation: 1,
            offset: const Offset(0, -10),
            isOverButton: false,
            decoration: BoxDecoration(
              color: isDesktop ? primaryBlack : bgBlackColor,
              borderRadius: BorderRadius.circular(9),
            ),
            scrollbarTheme: ScrollbarThemeData(
              thumbVisibility: MaterialStateProperty.all(true),
              trackVisibility: MaterialStateProperty.all(true),
              thumbColor: MaterialStateProperty.all(hintGreyColor),
              trackColor: MaterialStateProperty.all(darkDividerColor),
              trackBorderColor: MaterialStateProperty.all(darkDividerColor),
              crossAxisMargin: 1.0,
              mainAxisMargin: 1.0,
              minThumbLength: 10.0,
              interactive: true,
            ),
          )),
    );
  }
}

class AccessDropdown extends StatelessWidget {
  final String currentValue;
  final String userId; // Unique identifier for each row/user
  final List<String>
      accessLevels; // Access levels like ['Admin', 'User', 'Guest']
  final ValueChanged<String> onAccessLevelChanged;

  AccessDropdown({
    required this.currentValue,
    required this.userId,
    required this.accessLevels,
    required this.onAccessLevelChanged,
    Key? key,
  }) : super(key: key);
  var dropdownIsOpen = false.obs;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
          value: currentValue,
          isExpanded: true,
          isDense: true,
          items: accessLevels.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: AppTextStyle.normalRegular14
                    .copyWith(color: tableTextColor),
                overflow: TextOverflow.clip,
                textAlign: TextAlign.start,
                maxLines: 1,
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              onAccessLevelChanged(
                  newValue); // Call method to update access level
            }
          },
          onMenuStateChange: (isOpen) {
            dropdownIsOpen.value = isOpen;
          },
          iconStyleData: IconStyleData(
            icon: FittedBox(
              fit: BoxFit.scaleDown,
              child: Obx(
                () => Icon(
                  dropdownIsOpen.value
                      ? CupertinoIcons.chevron_up
                      : CupertinoIcons.chevron_down,
                  color: primaryWhite,
                  size: 20,
                ),
              ),
            ),
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            elevation: 1,
            offset: const Offset(0, 0),
            isOverButton: false,
            decoration: BoxDecoration(
              color: tableHeaderColor,
              borderRadius: BorderRadius.circular(9),
            ),
            scrollbarTheme: ScrollbarThemeData(
              thumbVisibility: MaterialStateProperty.all(true),
              trackVisibility: MaterialStateProperty.all(true),
              thumbColor: MaterialStateProperty.all(hintGreyColor),
              trackColor: MaterialStateProperty.all(darkDividerColor),
              trackBorderColor: MaterialStateProperty.all(darkDividerColor),
              crossAxisMargin: 1.0,
              mainAxisMargin: 1.0,
              minThumbLength: 10.0,
              interactive: true,
            ),
          )),
    );
  }
}
