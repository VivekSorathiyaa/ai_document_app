import 'package:ai_document_app/controllers/plan_controller.dart';
import 'package:ai_document_app/model/plan_model.dart';
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

  PlansPricingView({super.key});

  var planController = Get.put(PlanController());

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
    return Scaffold(
      backgroundColor: primaryBlack,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            _buildPlanBackground(isDesktop),
            SingleChildScrollView(
              padding: EdgeInsets.all(isDesktop ? 16 : 0),
              child: Column(
                children: [
                  _buildPlanHeader(context, isDesktop),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 926.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: isDesktop ? 0 : 20),
                          child: _buildPlanTitle(isDesktop),
                        ),
                      ],
                    ),
                  ),
                  customHeight(20),
                  ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1020.0),
                      child: isDesktop
                          ? _buildDesktopPlanView()
                          : _buildMobilePlanView()),
                  customHeight(100),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPlanHeader(context, isDesktop) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
          color: bgBlackColor, borderRadius: BorderRadius.circular(18)),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              CupertinoIcons.back,
              color: primaryWhite,
            ),
          ),
          SvgPicture.asset(
            AppAsset.logo,
            width: isDesktop ? 50 : 40,
            height: isDesktop ? 50 : 40,
            fit: BoxFit.scaleDown,
          ),
          customWidth(isDesktop ? 16 : 12),
          Expanded(
            child: SelectableText(
              'PDF to AI Conversation',
              style: AppTextStyle.normalSemiBold16
                  .copyWith(fontSize: isDesktop ? 16 : 14),
              textAlign: TextAlign.start,
              maxLines: 1,
            ),
          ),
          customWidth(isDesktop ? 16 : 12),
          Container(
            constraints: BoxConstraints(maxWidth: isDesktop ? 120 : 80),
            child: PrimaryTextButton(
              title: 'Join Now',
              onPressed: () {},
              height: isDesktop ? 38 : 30,
              fontSize: isDesktop ? 14 : 12,
              borderRadius: BorderRadius.circular(8),
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
                gradient: LinearGradient(
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
                gradient: LinearGradient(
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
                gradient: LinearGradient(
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
                gradient: LinearGradient(
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
                gradient: LinearGradient(
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

  Widget _buildDesktopPlanView() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: Get.width,
          height: 490,
          decoration: BoxDecoration(
              color: bgBlackColor, borderRadius: BorderRadius.circular(26)),
        ),
        Obx(() => Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: planList.value.map((element) {
                return Expanded(child: _buildPlan(element));
              }).toList(),
            ))
      ],
    );
  }

  Widget _buildMobilePlanView() {
    return Obx(
      () => Column(
        children: planList.value.map((element) {
          return _buildPlan(element);
        }).toList(),
      ),
    );
  }

  Widget _buildPlan(PlanModel plan) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: plan.isPopular
              ? [orangeColor, purpleColor]
              : [bgContainColor, bgContainColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: tableButtonColor),
      ),
      child: Column(
        children: [
          if (plan.isPopular)
            Row(
              children: [
                const Spacer(),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: purpleColor),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 7),
                      child: SelectableText(
                        "MOST POPULAR",
                        style: AppTextStyle.normalBold10,
                        maxLines: 1,
                      ),
                    ),
                  ),
                )
              ],
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(colors: <Color>[
                    plan.isPopular ? primaryWhite : orangeColor,
                    plan.isPopular ? primaryWhite : purpleColor,
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
                      .createShader(bounds),
                  child: SelectableText(
                    '\$${plan.price}',
                    style: AppTextStyle.normalSemiBold36.copyWith(height: 1.2),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
              ),
              customWidth(14),
              Flexible(
                child: SelectableText(
                  '/${plan.isMonthly ? "month" : "yearly"}',
                  style: AppTextStyle.normalRegular17
                      .copyWith(color: tableTextColor),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          customHeight(20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(colors: <Color>[
                    plan.isPopular ? primaryWhite : orangeColor,
                    plan.isPopular ? primaryWhite : purpleColor,
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
                      .createShader(bounds),
                  child: SelectableText(
                    plan.name,
                    style: AppTextStyle.normalSemiBold28,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
          customHeight(10),
          Row(
            children: [
              Expanded(
                child: SelectableText(
                  plan.description,
                  style: AppTextStyle.normalRegular15,
                  maxLines: 2,
                ),
              ),
            ],
          ),
          customHeight(20),
          Column(
            children: plan.features.map((element) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    element.isNotEmpty
                        ? SvgPicture.asset(AppAsset.check,
                            height: 20, width: 20, fit: BoxFit.scaleDown)
                        : const SizedBox(
                            height: 20,
                            width: 20,
                          ),
                    width10,
                    Expanded(
                      child: SelectableText(
                        element,
                        style: AppTextStyle.normalRegular15,
                        maxLines: 1,
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          ),
          customHeight(20),
          PrimaryTextButton(
            height: 44,
            title: "Choose plan",
            onPressed: () {},
            gradientColors:
                plan.isPopular ? [lightPurpleColor, lightPurpleColor] : null,
            borderRadius: BorderRadius.circular(32),
            textStyle:
                AppTextStyle.normalRegular15.copyWith(color: primaryWhite),
          )
        ],
      ),
    );
  }

  Widget _buildPlanTitle(isDesktop) {
    return Column(
      children: [
        customHeight(isDesktop ? 50 : 30),
        Row(
          children: [
            Expanded(
              child: SelectableText(
                'Plans & Pricing',
                style: AppTextStyle.normalSemiBold40
                    .copyWith(fontSize: isDesktop ? 40 : 24),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: isDesktop ? 20 : 10),
          child: isDesktop
              ? Row(
                  children: [
                    Expanded(child: _buildPlanInfo(isDesktop)),
                    customWidth(isDesktop ? 140 : 10),
                    Flexible(
                      flex: 0,
                      child: _buildOption(isDesktop),
                    )
                  ],
                )
              : Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: _buildPlanInfo(isDesktop)),
                      ],
                    ),
                    customHeight(20),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 0,
                          child: _buildOption(isDesktop),
                        ),
                      ],
                    )
                  ],
                ),
        ),
      ],
    );
  }

  Widget _buildPlanInfo(isDesktop) {
    return SelectableText(
      "Whether your time-saving automation needs are large or small, we’re here to help you scale.",
      style: AppTextStyle.normalRegular18
          .copyWith(color: tableTextColor, fontSize: isDesktop ? 18 : 14),
    );
  }

  Widget _buildOption(isDesktop) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: tableButtonColor),
          borderRadius: BorderRadius.circular(22),
          color: bgContainColor),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              planController.isMonthlySelect.value = true;
            },
            child: Obx(
              () => Container(
                width: isDesktop ? 110 : 90,
                height: isDesktop ? 42 : 36,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: planController.isMonthlySelect.value
                        ? purpleColor
                        : bgContainColor),
                child: Center(
                  child: SelectableText(
                    "MONTHLY",
                    style: AppTextStyle.normalRegular12.copyWith(
                        color: planController.isMonthlySelect.value
                            ? primaryWhite
                            : purpleColor),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              planController.isMonthlySelect.value = false;
            },
            child: Obx(
              () => Container(
                width: isDesktop ? 110 : 90,
                height: isDesktop ? 42 : 36,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: !planController.isMonthlySelect.value
                        ? purpleColor
                        : bgContainColor),
                child: Center(
                  child: SelectableText(
                    "YEARLY",
                    style: AppTextStyle.normalRegular12.copyWith(
                        color: !planController.isMonthlySelect.value
                            ? primaryWhite
                            : purpleColor),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
