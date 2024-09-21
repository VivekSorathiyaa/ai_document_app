import 'package:ai_document_app/controllers/home_controller.dart';
import 'package:ai_document_app/model/menu_model.dart';
import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../utils/static_decoration.dart';
import 'widget/common_appbar_widget.dart';

class HomeView extends StatelessWidget {
  static const String name = 'home';

  var homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: constraints.maxHeight,
            child: SingleChildScrollView(
              child: ResponsiveRowColumn(
                columnCrossAxisAlignment: CrossAxisAlignment.start,
                columnMainAxisAlignment: MainAxisAlignment.start,
                rowMainAxisAlignment: MainAxisAlignment.start,
                rowCrossAxisAlignment:
                    CrossAxisAlignment.start, // Center alignment
                layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                    ? ResponsiveRowColumnType.COLUMN
                    : ResponsiveRowColumnType.ROW,
                children: [
                  // if (ResponsiveBreakpoints.of(context).isDesktop)
                  //   DrawerWidget(
                  //       homeController: homeController,
                  //       constraints: constraints),
                  // ResponsiveRowColumnItem(
                  //     rowFlex: 9,
                  //     child: Column(
                  //       children: [
                  CommonAppBarWidget(context: context),
                  // ],
                  // ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget MenuTileWidget(
    {required MenuModel model,
    required VoidCallback onTap,
    required bool isSelect}) {
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
            borderRadius: BorderRadius.circular(8)),
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
              width10,
              Expanded(
                child: Text(
                  model.name,
                  style: AppTextStyle.normalBold16,
                ),
              ),
              width10,
              if (model.subTitle != null)
                Container(
                  height: 22,
                  decoration: BoxDecoration(
                    color: yellowColor,
                    borderRadius: BorderRadius.circular(39),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          model.subTitle.toString(),
                          style: AppTextStyle.normalBold12
                              .copyWith(color: primaryBlack),
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
