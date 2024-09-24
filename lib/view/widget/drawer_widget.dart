import 'package:ai_document_app/controllers/home_controller.dart';
import 'package:ai_document_app/utils/static_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../model/menu_model.dart';
import '../../utils/app_asset.dart';
import '../../utils/app_text_style.dart';
import '../../utils/color.dart';
import '../../utils/network_image_widget.dart';
import '../../utils/primary_text_button.dart';

class DrawerWidget extends StatelessWidget {
  HomeController homeController;
  DrawerWidget({super.key, required this.homeController});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;

    return Container(
        width: 300,
        margin: EdgeInsets.only(
            right: ResponsiveBreakpoints.of(context).isDesktop ? 16 : 0),
        decoration: BoxDecoration(
          color: bgBlackColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: CustomScrollView(shrinkWrap: true, slivers: [
          SliverFillRemaining(
            fillOverscroll: true,
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SvgPicture.asset(
                    AppAsset.logo,
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(height: 11),
                  Text(
                    'PDF to AI Conversation',
                    style: AppTextStyle.normalSemiBold16,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: darkDividerColor, height: 0),
                  const SizedBox(height: 40),
                  Obx(
                    () => Column(
                      children: homeController.menuList.value.map((element) {
                        return MenuTileWidget(
                          model: element,
                          onTap: () {
                            homeController.selectedMenuModel.value = element;
                            homeController.selectedMenuModel.refresh();
                            if (!isDesktop) {
                              Navigator.of(context).pop();
                            }
                          },
                          isSelect:
                              homeController.selectedMenuModel.value == element,
                        );
                      }).toList(),
                    ),
                  ),
                  height20,
                  const Spacer(),
                  Column(
                    children: [
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
                                    child: Text(
                                      "Go unlimited with PRO",
                                      style: AppTextStyle.normalBold18,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 23),
                                    child: Text(
                                      "Get your AI Project to another level and start doing more with Horizon AI Template PRO!",
                                      style: AppTextStyle.normalRegular12
                                          .copyWith(color: textGreyColor),
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
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
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: SvgPicture.asset(
                                AppAsset.pro,
                                // width: 143,
                                height: 127,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      const Divider(color: darkDividerColor, height: 0),
                      const SizedBox(height: 20),
                      Container(
                        height: 62,
                        decoration: BoxDecoration(
                          color: primaryBlack,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Row(
                            children: [
                              NetworkImageWidget(
                                height: 34,
                                width: 34,
                                borderRadius: BorderRadius.circular(34),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Adela Parkson',
                                  style: AppTextStyle.normalBold14,
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]));
  }
}

Widget MenuTileWidget({
  required MenuModel model,
  required VoidCallback onTap,
  required bool isSelect,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          gradient: isSelect
              ? const LinearGradient(
                  colors: [orangeColor, purpleColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              SvgPicture.asset(
                model.icon,
                width: 20,
                height: 20,
                color: primaryWhite,
                fit: BoxFit.scaleDown,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  model.name,
                  style: AppTextStyle.normalBold16,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 10),
              if (model.subTitle != null)
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Container(
                    height: 22,
                    decoration: BoxDecoration(
                      color: yellowColor,
                      borderRadius: BorderRadius.circular(39),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            model.subTitle.toString(),
                            style: AppTextStyle.normalBold12
                                .copyWith(color: primaryBlack),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    ),
  );
}
