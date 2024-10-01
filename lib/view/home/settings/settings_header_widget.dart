import 'package:ai_document_app/controllers/settings_controller.dart';
import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class SettingsHeaderWidget extends StatelessWidget {
  final SettingsController settingsController;

  SettingsHeaderWidget({super.key, required this.settingsController});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "Settings",
            style: AppTextStyle.normalSemiBold18,
            overflow: TextOverflow.ellipsis, // Handle overflow gracefully
          ),
        ),
      ],
    );
  }
}
