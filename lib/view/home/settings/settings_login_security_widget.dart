import 'package:ai_document_app/controllers/settings_controller.dart';
import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/color.dart';
import 'package:ai_document_app/utils/input_text_field_widget.dart';
import 'package:ai_document_app/utils/static_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../utils/active_session_widget.dart';

class SettingsLoginSecurityWidget extends StatelessWidget {
  SettingsLoginSecurityWidget({super.key});
  SettingsController settingsController = Get.put(SettingsController());
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 2),
      children: [
        _buildPasswordWidget(context),
        _buildSessionWidget(context),
        customHeight(200)
      ],
    );
  }
}

Widget _buildPasswordWidget(BuildContext context) {
  bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
  return Column(
    children: [
      customHeight(10),
      const Divider(
        color: tableButtonColor,
        height: 1,
      ),
      height20,
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDesktop)
            Expanded(
              child: Text(
                "Password",
                style: AppTextStyle.normalRegular16
                    .copyWith(color: tableTextColor),
              ),
            ),
          Expanded(
            child: Column(
              children: [
                PasswordWidget(
                  controller: null,
                  hintText: "Enter Your Current Password",
                  borderColor: tableButtonColor,
                  labelText: isDesktop ? null : "Current password",
                  filledColor: bgContainColor,
                ),
                height20,
                PasswordWidget(
                  controller: null,
                  hintText: "Enter Your New Password",
                  borderColor: tableButtonColor,
                  labelText: isDesktop ? null : "New Password",
                  filledColor: bgContainColor,
                ),
                height20,
                PasswordWidget(
                  controller: null,
                  hintText: "Enter Your Confirm New Password",
                  borderColor: tableButtonColor,
                  labelText: isDesktop ? null : "Confirm New Password",
                  filledColor: bgContainColor,
                ),
              ],
            ),
          ),
        ],
      )
    ],
  );
}

_sessionLableWidget() {
  return Padding(
    padding: const EdgeInsets.only(right: 32),
    child: Column(
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                "Where you’re logged in",
                style:
                    AppTextStyle.normalBold16.copyWith(color: tableTextColor),
              ),
            ),
            customWidth(4),
            const Icon(
              CupertinoIcons.question_circle,
              color: tableTextColor,
              size: 18,
            )
          ],
        ),
        customHeight(5),
        Row(
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: AppTextStyle.normalRegular16
                      .copyWith(color: tableTextColor),
                  children: <TextSpan>[
                    TextSpan(
                      text: "We’ll alert you via ",
                      style: AppTextStyle.normalRegular16
                          .copyWith(color: tableTextColor),
                    ),
                    TextSpan(
                      text: "olivia@untitledui.com",
                      style: AppTextStyle.normalRegular16.copyWith(
                        color: tableTextColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    TextSpan(
                      text:
                          " if there is any unusual activity on your account.",
                      style: AppTextStyle.normalRegular16
                          .copyWith(color: tableTextColor, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Widget _buildSessionWidget(BuildContext context) {
  bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
  return Column(
    children: [
      customHeight(32),
      const Divider(
        color: tableButtonColor,
        height: 1,
      ),
      height20,
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDesktop) Expanded(child: _sessionLableWidget()),
          Expanded(
            child: Column(
              children: [
                if (isDesktop == false)
                  Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: _sessionLableWidget(),
                  ),
                ...List.generate(3, (index) {
                  return const ActiveSessionWidget();
                })
              ],
            ),
          )
        ],
      )
    ],
  );
}
