import 'package:ai_document_app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../utils/app_asset.dart';
import '../../utils/app_text_style.dart';
import '../../utils/color.dart';
import '../../utils/network_image_widget.dart';
import '../../utils/primary_text_button.dart';
import '../../utils/static_decoration.dart';
import '../home_view.dart';

ResponsiveRowColumnItem DrawerWidget(
    {required HomeController homeController,
    required BoxConstraints constraints}) {
  return ResponsiveRowColumnItem(
      child: Container(
    width: 300,
    height: constraints.maxHeight - 50,
    margin: const EdgeInsets.all(24),
    decoration: BoxDecoration(
        color: bgBlackColor, borderRadius: BorderRadius.circular(18)),
    child: IntrinsicHeight(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                customHeight(8),
                SvgPicture.asset(
                  AppAsset.logo,
                  width: 50,
                  height: 50,
                ),
                customHeight(11),
                Text(
                  'PDF to AI Conversation',
                  style: AppTextStyle.normalSemiBold16,
                  textAlign: TextAlign.center,
                ),
                height20,
                const Divider(
                  color: darkDividerColor,
                  height: 0,
                ),
                customHeight(40),
                Obx(
                  () => Column(
                    children: homeController.menuList.value.map((element) {
                      return MenuTileWidget(
                          model: element,
                          onTap: () {
                            homeController.selectedMenuModel.value = element;
                            homeController.selectedMenuModel.refresh();
                          },
                          isSelect: homeController.selectedMenuModel.value ==
                              element);
                    }).toList(),
                  ),
                ),
                // customHeight(178),
                // Spacer(),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 43),
                      child: Container(
                        decoration: BoxDecoration(
                            color: primaryBlack,
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          children: [
                            customHeight(88),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 23),
                              child: Text(
                                "Go unlimited with PRO",
                                style: AppTextStyle.normalBold18,
                              ),
                            ),
                            customHeight(6),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 23),
                              child: Text(
                                "Get your AI Project to another level and start doing more with Horizon AI Template PRO!",
                                style: AppTextStyle.normalRegular12
                                    .copyWith(color: textGreyColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            customHeight(6),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: PrimaryTextButton(
                                title: 'Get started with PRO',
                                onPressed: () {},
                                height: 37,
                                fontSize: 14,
                                borderRadius: BorderRadius.circular(8),
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
                      child: SvgPicture.asset(
                        AppAsset.pro,
                        width: 143,
                        height: 127,
                      ),
                    ),
                  ],
                ),
                customHeight(25),
                const Divider(
                  color: darkDividerColor,
                  height: 0,
                ),
                height20,
                Container(
                  height: 62,
                  decoration: BoxDecoration(
                      color: primaryBlack,
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      children: [
                        NetworkImageWidget(
                          imageUrl:
                              "https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=928&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                          height: 34,
                          width: 34,
                          borderRadius: BorderRadius.circular(34),
                        ),
                        customWidth(8),
                        Expanded(
                          child: Text(
                            'Adela Parkson',
                            style: AppTextStyle.normalBold14,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SvgPicture.asset(
                          AppAsset.logout,
                          height: 34,
                          width: 34,
                          fit: BoxFit.scaleDown,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  ));
}
