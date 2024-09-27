import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../controllers/home_controller.dart';
import 'searchbar_widget.dart';

class DesktopAppBarWidget extends StatelessWidget {
  HomeController homeController;
  DesktopAppBarWidget({super.key, required this.homeController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
          color: bgBlackColor, borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: Obx(
                () => Text(
                  homeController.selectedMenuModel.value.name,
                  style: AppTextStyle.normalSemiBold26,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Expanded(
                flex: 3,
                child: SearchbarWidget(
                  homeController: homeController,
                ))
          ],
        ),
      ),
    );
  }
}
