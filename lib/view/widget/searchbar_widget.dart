import 'package:ai_document_app/controllers/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../utils/app_text_style.dart';
import '../../utils/color.dart';
import '../../utils/input_text_field_widget.dart';

class SearchbarWidget extends StatelessWidget {
  HomeController homeController;
  SearchbarWidget({super.key, required this.homeController});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;

    return Obx(
      () => TextFormFieldWidget(
        hintText: "Search",
        maxLines: 1,
        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Icon(
            CupertinoIcons.search,
            color: primaryWhite,
            size: 20,
          ),
        ),
        suffixIcon: homeController.isSearchOpen.value
            ? IconButton(
                onPressed: () {
                  homeController.isSearchOpen.value = false;
                },
                icon: const Icon(
                  Icons.close,
                  color: primaryWhite,
                  size: 20,
                ),
              )
            : const SizedBox.shrink(),
        hintStyle: AppTextStyle.normalRegular14,
        filledColor: isDesktop ? primaryBlack : bgBlackColor,
        borderColor: primaryBlack,
        borderRadius: 30,
        onChanged: (value) {
          homeController.isSearchOpen.value = true;
        },
        controller: TextEditingController(),
      ),
    );
  }
}
