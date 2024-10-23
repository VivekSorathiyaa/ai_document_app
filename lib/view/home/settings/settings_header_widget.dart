import 'package:ai_document_app/controllers/settings_controller.dart';
import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../utils/color.dart';

class SettingsHeaderWidget extends StatelessWidget {
  SettingsController settingsController;
  SettingsHeaderWidget({super.key, required this.settingsController});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;

    return Obx(() {
      final selectedMenu = settingsController.selectedSettingMenuModel.value;
      final title = selectedMenu?.title ?? "Settings";
      final subTitle = selectedMenu?.subTitle ?? "";

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (selectedMenu != null)
            InkWell(
              onTap: () {
                settingsController.refreshSettingMenuModel(null);
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 15, top: 4),
                child: Icon(
                  CupertinoIcons.back,
                  color: primaryWhite,
                ),
              ),
            ),
          if (selectedMenu != null && isDesktop == false)
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: AppTextStyle.normalSemiBold18,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  if (selectedMenu != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              subTitle,
                              style: AppTextStyle.normalRegular14
                                  .copyWith(color: tableTextColor),
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
        ],
      );
    });
  }
}
