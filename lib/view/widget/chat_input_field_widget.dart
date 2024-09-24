import 'package:ai_document_app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../utils/app_asset.dart';
import '../../utils/app_text_style.dart';
import '../../utils/color.dart';
import '../../utils/input_text_field_widget.dart';
import '../../utils/primary_text_button.dart';
import '../../utils/static_decoration.dart';

class ChatInputFieldWidget extends StatelessWidget {
  HomeController homeController;
  ChatInputFieldWidget({super.key, required this.homeController});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 908.0),
      child: Column(
        children: [
          SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      width16,
                      Row(
                          children: homeController.suggestionList.value
                              .map((element) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              right: 16, bottom: 16, top: 16),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    orangeColor.withOpacity(.1),
                                    purpleColor.withOpacity(.2)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  AppAsset.aiAvatar,
                                  height: 16,
                                  width: 16,
                                  fit: BoxFit.scaleDown,
                                ),
                                width10,
                                Text(element.name,
                                    style: AppTextStyle.normalRegular12),
                              ],
                            ),
                          ),
                        );
                      }).toList()),
                    ],
                  ))),
          // TextFormField and Submit button
          Padding(
            padding: isDesktop
                ? const EdgeInsets.only(left: 16, right: 16, bottom: 16)
                : const EdgeInsets.only(left: 12, right: 12, bottom: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextFormFieldWidget(
                    hintText: "Send a message",
                    controller: TextEditingController(),
                    prefixIcon: Padding(
                      padding: isDesktop
                          ? const EdgeInsets.all(15)
                          : const EdgeInsets.only(left: 20, right: 10),
                      child: SvgPicture.asset(
                        AppAsset.pin,
                        height: isDesktop ? 24 : 16,
                        width: isDesktop ? 24 : 16,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    hintStyle: AppTextStyle.normalRegular14,
                    filledColor: isDesktop ? primaryBlack : bgBlackColor,
                    borderColor: isDesktop ? primaryBlack : dividerColor,
                    borderRadius: isDesktop ? 12 : 30,
                  ),
                ),
                customWidth(isDesktop ? 16 : 12),
                isDesktop
                    ? SizedBox(
                        width: 114,
                        child: PrimaryTextButton(
                          title: 'Submit',
                          onPressed: () {},
                          fontSize: 16,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [orangeColor, purpleColor],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Center(
                              child: SvgPicture.asset(
                                AppAsset.send,
                                height: 25,
                                width: 25,
                                fit: BoxFit.scaleDown,
                                color: primaryWhite,
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
