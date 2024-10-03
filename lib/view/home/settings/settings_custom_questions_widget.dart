import 'package:ai_document_app/controllers/settings_controller.dart';
import 'package:ai_document_app/utils/color.dart';
import 'package:ai_document_app/utils/input_text_field_widget.dart';
import 'package:ai_document_app/utils/primary_text_button.dart';
import 'package:ai_document_app/utils/static_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SettingsCustomQuestionsWidget extends StatelessWidget {
  SettingsCustomQuestionsWidget({super.key});
  SettingsController settingsController = Get.put(SettingsController());
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 2),
      children: [
        const TextFormFieldWidget(
          controller: null,
          hintText: "Enter Your Question",
          borderColor: tableButtonColor,
          labelText: 'Enter Your Question',
          filledColor: bgContainColor,
        ),
        customHeight(20),
        const TextFormFieldWidget(
          controller: null,
          hintText: "Enter a description...",
          borderColor: tableButtonColor,
          maxLines: 10,
          minLines: 10,
          contentPadding: EdgeInsets.all(16),
          labelText: 'Description',
          filledColor: bgContainColor,
        ),
        _buildSaveWidget(context),
        customHeight(200),
      ],
    );
  }
}

Widget _buildSaveWidget(BuildContext context) {
  bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
  return Column(
    children: [
      height20,
      Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isDesktop ? 288.0 : Get.width),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: PrimaryTextButton(
                    title: "Cancel",
                    gradientColors: [primaryWhite, primaryWhite],
                    textColor: primaryBlack,
                    onPressed: () {}),
              ),
              customWidth(12),
              Expanded(
                  child: PrimaryTextButton(title: "Save", onPressed: () {})),
            ],
          ),
        ),
      )
    ],
  );
}
