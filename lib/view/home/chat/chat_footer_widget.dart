import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../controllers/chat_controller.dart';
import '../../../utils/app_asset.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/color.dart';
import '../../../utils/common_method.dart';
import '../../../utils/input_text_field_widget.dart';
import '../../../utils/primary_text_button.dart';
import '../../../utils/static_decoration.dart';

class ChatFooterWidget extends StatelessWidget {
  ChatFooterWidget({super.key});
  final chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
    return Column(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900.0),
          child: Stack(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      width16,
                      Row(
                          children: chatController.suggestionList.value
                              .map((element) {
                        return Padding(
                          padding: EdgeInsets.only(
                            right: 20,
                            bottom: isDesktop ? 20 : 12,
                            top: isDesktop ? 20 : 0,
                          ),
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
                  ),
                ),
              ),
              if (isDesktop)
                Positioned(
                  top: 0,
                  right: 0,
                  bottom: 0,
                  child: IgnorePointer(
                    ignoring: true,
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            bgBlackColor,
                            bgBlackColor.withOpacity(.6),
                            bgBlackColor.withOpacity(.3),
                            bgBlackColor.withOpacity(.1),
                          ],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                        ),
                      ),
                    ),
                  ),
                ),
              if (isDesktop)
                Positioned(
                  top: 0,
                  left: 0,
                  bottom: 0,
                  child: IgnorePointer(
                    ignoring: true,
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            bgBlackColor,
                            bgBlackColor.withOpacity(.6),
                            bgBlackColor.withOpacity(.3),
                            bgBlackColor.withOpacity(.1),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        // TextFormField and Submit button
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 908.0),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextFormFieldWidget(
                    hintText: "Send a message",
                    controller: chatController.messageTextController,
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
                        child: Obx(
                          () => chatController.loading.value
                              ? const CircularProgressIndicator(
                                  color: primaryColor,
                                )
                              : PrimaryTextButton(
                                  title: 'Send',
                                  onPressed: () {
                                    if (chatController.currentChatRoom.value !=
                                        null) {
                                      chatController.sendMessage(
                                        message: chatController
                                            .messageTextController.text
                                            .trim(),
                                        chatRoomId: chatController
                                                .currentChatRoom.value?.id ??
                                            "",
                                        userId: CommonMethod
                                                .auth.currentUser?.email ??
                                            "Unknown",
                                      );
                                      chatController.messageTextController
                                          .clear();
                                      if (chatController
                                          .scrollController.hasClients) {
                                        chatController.scrollController
                                            .animateTo(
                                          0.0,
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeOut,
                                        );
                                      }
                                    } else {
                                      CommonMethod.getXSnackBar("Error",
                                          "Select a conversation first.");
                                    }
                                  },
                                  fontSize: 16,
                                  borderRadius: BorderRadius.circular(8),
                                ),
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
        ),
      ],
    );
  }
}
