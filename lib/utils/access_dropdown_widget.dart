import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_text_style.dart';
import 'color.dart';

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
              child: SelectableText(
                value,
                style: AppTextStyle.normalRegular14
                    .copyWith(color: tableTextColor),
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
