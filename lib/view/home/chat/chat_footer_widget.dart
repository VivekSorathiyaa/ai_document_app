import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../controllers/chat_controller.dart';
import '../../../utils/app_asset.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/color.dart';
import '../../../utils/common_method.dart';
import '../../../utils/input_text_field_widget.dart';
import '../../../utils/static_decoration.dart';

class ChatFooterWidget extends StatelessWidget {
  ChatFooterWidget({super.key});
  final chatController = Get.put(ChatController());

  late final _focusNode = FocusNode(
    onKey: (FocusNode node, RawKeyEvent evt) {
      if (!evt.isShiftPressed && evt.logicalKey.keyLabel == 'Enter') {
        if (evt is RawKeyDownEvent) {
          _sendMessage();
        }
        return KeyEventResult.handled;
      } else {
        return KeyEventResult.ignored;
      }
    },
  );
  _sendMessage() {
    if (chatController.currentChatRoom.value != null) {
      chatController.sendMessage(
        message: chatController.messageTextController.text.trim(),
        chatRoomId: chatController.currentChatRoom.value?.id ?? "",
        userId: CommonMethod.auth.currentUser?.email ?? "Unknown",
      );
      chatController.messageTextController.clear();
      if (chatController.scrollController.hasClients) {
        chatController.scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    } else {
      CommonMethod.getXSnackBar("Error", "Select a conversation first.");
    }
  }

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
                      customWidth(14),
                      Row(
                          children: chatController.suggestionList.value
                              .map((element) {
                        return InkWell(
                          onTap: () {
                            chatController.messageTextController.text =
                                element.name;
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: 20,
                              bottom: 12,
                              top: isDesktop ? 14 : 0,
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(8),
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
                                    height: 14,
                                    width: 14,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  width10,
                                  SelectableText(element.name,
                                      style: AppTextStyle.normalRegular12),
                                ],
                              ),
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
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 908.0),
          child: Padding(
            padding: const EdgeInsets.only(left: 14, right: 14, bottom: 12),
            child: Row(
              children: [
                Expanded(
                  child: RawKeyboardListener(
                    focusNode: _focusNode, // Use a different focus node
                    onKey: (RawKeyEvent event) {
                      if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
                        if (event.isShiftPressed) {
                          // Insert newline
                          // final currentText =
                          //     chatController.messageTextController.text;
                          // final selection =
                          //     chatController.messageTextController.selection;
                          // final newText = currentText.replaceRange(
                          //   selection.start,
                          //   selection.end,
                          //   '\n',
                          // );
                          // chatController.messageTextController.text = newText;
                          // chatController.messageTextController.selection =
                          //     TextSelection.collapsed(
                          //   offset: selection.start + 1,
                          // );
                        } else {
                          // Submit on Enter
                          print(
                              "Submitted text: ${chatController.messageTextController.text}");
                          _sendMessage(); // Handle sending message
                          chatController.messageTextController.clear();
                        }
                      }
                    },
                    child: TextFormFieldWidget(
                      hintText: "Send a message",
                      controller: chatController.messageTextController,
                      contentPadding: EdgeInsets.symmetric(vertical: 20),
                      prefixIcon: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 10),
                          child: SvgPicture.asset(
                            AppAsset.pin,
                            height: 14,
                            width: 14,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      maxLines: 9,
                      keyboardType: TextInputType.multiline,
                      // textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        // Optionally handle onFieldSubmitted if needed
                        _sendMessage();
                      },
                      hintStyle: AppTextStyle.normalRegular14,
                      filledColor: isDesktop ? primaryBlack : bgBlackColor,
                      borderColor: isDesktop ? primaryBlack : dividerColor,
                      borderRadius: 30,
                    ),
                  ),
                ),
                SizedBox(width: 12), // Using SizedBox for spacing
                InkWell(
                  onTap: () {
                    _sendMessage();
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [orangeColor, purpleColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                    ),
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
