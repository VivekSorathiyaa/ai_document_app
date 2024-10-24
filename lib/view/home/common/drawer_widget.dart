import 'package:ai_document_app/controllers/home_controller.dart';
import 'package:ai_document_app/main.dart';
import 'package:ai_document_app/utils/common_method.dart';
import 'package:ai_document_app/utils/static_decoration.dart';
import 'package:ai_document_app/view/home/plans_pricing_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../utils/app_asset.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/color.dart';
import '../../../utils/network_image_widget.dart';
import '../../../utils/primary_text_button.dart';

class DrawerWidget extends StatelessWidget {
  HomeController homeController;
  DrawerWidget({super.key, required this.homeController});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;

    return Obx(() => AnimatedContainer(
        width: homeController.isDrawerExpand.value ? 250 : 80,
        margin: EdgeInsets.only(
            right: ResponsiveBreakpoints.of(context).isDesktop ? 16 : 0),
        decoration: BoxDecoration(
          color: bgBlackColor,
          borderRadius: BorderRadius.circular(18),
        ),
        duration:
            const Duration(milliseconds: 300), // Smoother transition duration
        curve: Curves.easeInOut,
        child: CustomScrollView(shrinkWrap: true, slivers: [
          SliverFillRemaining(
            fillOverscroll: true,
            hasScrollBody: false,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding:
                  EdgeInsets.all(homeController.isDrawerExpand.value ? 16 : 10),
              child: Column(
                children: [
                  SvgPicture.asset(
                    AppAsset.logo,
                    width: 50,
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 11, bottom: 20),
                    child: SelectableText(
                      'PDF to AI Conversation',
                      style: homeController.isDrawerExpand.value
                          ? AppTextStyle.normalSemiBold14
                          : AppTextStyle.normalSemiBold12,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Divider(color: darkDividerColor, height: 0),
                  const SizedBox(height: 30),
                  Obx(
                    () => Column(
                      children: menuList.value.map((element) {
                        return InkWell(
                          onTap: () {
                            homeController.selectedMenuModel.value = element;
                            homeController.selectedMenuModel.refresh();
                            if (!isDesktop) {
                              Navigator.of(context).pop();
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 9),
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                gradient:
                                    homeController.selectedMenuModel.value ==
                                            element
                                        ? const LinearGradient(
                                            colors: [orangeColor, purpleColor],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          )
                                        : null,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      homeController.isDrawerExpand.value
                                          ? MainAxisAlignment.start
                                          : MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Flexible(
                                      flex: 0,
                                      child: SvgPicture.asset(
                                        element.icon,
                                        width: 18,
                                        height: 18,
                                        color: primaryWhite,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                    if (homeController.isDrawerExpand.value)
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: SelectableText(
                                            element.name,
                                            style: AppTextStyle.normalBold14,
                                            maxLines: 1,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                    // if (homeController.isDrawerExpand.value &&
                                    //     element.subTitle != null)
                                    //   Expanded(
                                    //     flex: 2,
                                    //     child: Align(
                                    //       alignment: Alignment.centerLeft,
                                    //       child: Container(
                                    //         height: 22,
                                    //         padding: const EdgeInsets.symmetric(
                                    //             horizontal: 9),
                                    //         decoration: BoxDecoration(
                                    //           color: yellowColor,
                                    //           borderRadius:
                                    //               BorderRadius.circular(39),
                                    //         ),
                                    //         child: FittedBox(
                                    //           fit: BoxFit.scaleDown,
                                    //           child: SelectableText(
                                    //             element.subTitle.toString(),
                                    //             style: AppTextStyle.normalBold12
                                    //                 .copyWith(
                                    //                     color: primaryBlack),
                                    //             maxLines: 1,
                                    //             textAlign: TextAlign.center,
                                    //
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  height20,
                  const Spacer(),
                  if (homeController.isDrawerExpand.value)
                    Column(
                      children: [
                        if (homeController.isProPlanExpand.value)
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 43),
                                child: Container(
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    color: primaryBlack,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 88),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 23),
                                        child: SelectableText(
                                          "Go unlimited with PRO",
                                          style: AppTextStyle.normalBold16,
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 23),
                                        child: SelectableText(
                                          "Get your AI Project to another level and start doing more with Horizon AI Template PRO!",
                                          style: AppTextStyle.normalRegular10
                                              .copyWith(color: textGreyColor),
                                          textAlign: TextAlign.center,
                                          maxLines: 3,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: PrimaryTextButton(
                                          title: 'Get started with PRO',
                                          onPressed: () {
                                            navigateTo(
                                                context, PlansPricingView.name);
                                          },
                                          height: 37,
                                          fontSize: 14,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -10,
                                right: 0,
                                left: 0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: SvgPicture.asset(
                                    AppAsset.pro,
                                    height: 124,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    homeController.isProPlanExpand.value =
                                        false;
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 38),
                                    padding: const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: orangeColor,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.close,
                                        color: primaryWhite,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        const SizedBox(height: 25),
                        const Divider(color: darkDividerColor, height: 0),
                        const SizedBox(height: 20),
                        Container(
                          height: 62,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: primaryBlack,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: NetworkImageWidget(
                                  height: 32,
                                  width: 32,
                                  fit: BoxFit.cover,
                                  borderRadius: BorderRadius.circular(34),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: SelectableText(
                                    'Adela Parkson',
                                    style: AppTextStyle.normalBold12,
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: InkWell(
                                  onTap: () {
                                    CommonMethod.showLogoutDialog(context);
                                  },
                                  child: SvgPicture.asset(
                                    AppAsset.logout,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 10),
                  const Divider(color: darkDividerColor, height: 20),
                  Align(
                    alignment: homeController.isDrawerExpand.value
                        ? Alignment.centerRight
                        : Alignment.center,
                    child: IconButton(
                        onPressed: () {
                          homeController.isDrawerExpand.value =
                              !homeController.isDrawerExpand.value;
                        },
                        icon: Icon(
                          homeController.isDrawerExpand.value
                              ? CupertinoIcons.back
                              : CupertinoIcons.right_chevron,
                          color: primaryWhite,
                          size: 20,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ])));
  }
}
