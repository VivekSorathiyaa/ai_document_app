import 'package:ai_document_app/controllers/settings_controller.dart';
import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/color.dart';
import 'package:ai_document_app/utils/static_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsReferralCreditCouponWidget extends StatelessWidget {
  SettingsReferralCreditCouponWidget({super.key});
  SettingsController settingsController = Get.put(SettingsController());
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 2),
      children: [
        Center(
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: <Color>[
                orangeColor,
                purpleColor,
              ],
            ).createShader(bounds),
            child: Text(
              'Stay tuned, something epic is coming soon! 🎉👀 Get ready for the surprises! 🚀😄',
              style: AppTextStyle.normalSemiBold26,
              textAlign: TextAlign.center,
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        customHeight(200),
      ],
    );
  }
}