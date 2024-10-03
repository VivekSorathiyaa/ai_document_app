import 'package:ai_document_app/utils/primary_text_button.dart';
import 'package:ai_document_app/utils/static_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../utils/color.dart';
import '../../utils/app_asset.dart';
import '../../utils/app_text_style.dart';
import '../../utils/dotted_border_grid_widget.dart';

class PlansPricingView extends StatelessWidget {
  static const String name = 'plans';

  const PlansPricingView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
    return Scaffold(
      backgroundColor: primaryBlack,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          _buildPlanBackground(isDesktop),
          SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                _buildPlanHeader(isDesktop),
                _buildPlanTitle(isDesktop),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildPlanHeader(isDesktop) {
  return Container(
    height: 70,
    decoration: BoxDecoration(
        color: bgBlackColor, borderRadius: BorderRadius.circular(18)),
    child: Row(
      children: [
        IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            CupertinoIcons.back,
            color: primaryWhite,
          ),
        ),
        SvgPicture.asset(
          AppAsset.logo,
          width: 50,
          height: 50,
        ),
        customWidth(16),
        Expanded(
          child: Text(
            'PDF to AI Conversation',
            style: AppTextStyle.normalSemiBold16,
            textAlign: TextAlign.start,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          constraints: const BoxConstraints(maxWidth: 120),
          child: PrimaryTextButton(
            title: 'Join Now',
            onPressed: () {},
            height: 38,
            fontSize: 14,
          ),
        ),
        width20,
      ],
    ),
  );
}

Widget _buildPlanBackground(isDesktop) {
  var opacity = .3;

  return Stack(
    children: [
      Positioned(
        top: 160,
        left: isDesktop ? -72 : -100,
        child: Opacity(
          opacity: opacity,
          child: Container(
            width: 272,
            height: isDesktop ? 272 : 160,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [orangeColor, purpleColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
      ),
      Positioned(
        top: 230,
        right: isDesktop ? 308 : 100,
        child: Opacity(
          opacity: opacity,
          child: Container(
            width: 65,
            height: 65,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [orangeColor, purpleColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        left: isDesktop ? 200 : 80,
        child: Opacity(
          opacity: opacity,
          child: Container(
            width: 65,
            height: 65,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [orangeColor, purpleColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 30,
        right: isDesktop ? 24 : 10,
        child: Opacity(
          opacity: opacity,
          child: Container(
            width: 65,
            height: 65,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [purpleColor, bgBlackColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
      ),
      Positioned(
        top: 363,
        left: isDesktop ? 453 : 150,
        child: Opacity(
          opacity: opacity,
          child: Container(
            width: 65,
            height: 65,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [purpleColor, bgBlackColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
      ),
      const DottedBorderGridWidget(),
    ],
  );
}

Widget _buildPlanTitle(isDesktop) {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: Text(
              'Plans & Pricing',
              style: AppTextStyle.normalSemiBold40,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                "Whether your time-saving automation needs are large or small, we’re here to help you scale.",
                style: AppTextStyle.normalRegular18
                    .copyWith(color: tableTextColor),
                maxLines: 2,
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
