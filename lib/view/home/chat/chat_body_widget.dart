import 'package:ai_document_app/controllers/chat_controller.dart';
import 'package:ai_document_app/model/chat_model.dart';
import 'package:ai_document_app/utils/app_asset.dart';
import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/color.dart';
import 'package:ai_document_app/utils/common_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../utils/common_markdown_widget.dart';
import '../../../utils/static_decoration.dart';
import '../common/no_data_widget.dart';

class ChatBodyWidget extends StatelessWidget {
  ChatBodyWidget({Key? key}) : super(key: key);
  final chatController = Get.put(ChatController());

  refreshPage() {
    chatController.refreshPage();
  }

  @override
  Widget build(BuildContext context) {
    refreshPage();
    bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;

    return Obx(
      () => chatController.messagesList.value.isEmpty
          ? NoDataWidget()
          : ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 860.0),
              child: Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  Obx(
                    () {
                      final messages = chatController.messagesList.value;

                      if (messages.isEmpty) {
                        return const SizedBox();
                      }
                      return ListView.builder(
                        controller: chatController.scrollController,
                        reverse: true,
                        itemCount: messages.length,
                        padding: EdgeInsets.symmetric(
                            horizontal: isDesktop ? 14 : 0),
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final messageData = messages[index];
                          final isSender = messageData.senderId ==
                              CommonMethod.auth.currentUser?.email;
                          final isLastIndex = (index == 0);
                          return isSender
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      top: index == 0 ? 20 : 10),
                                  child: UserWidget(
                                      messageData: messageData,
                                      isDesktop: isDesktop),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(
                                    bottom: isLastIndex ? 40 : 0,
                                  ),
                                  child: chatController.loading.value &&
                                          isLastIndex
                                      ? Lottie.asset(AppAsset.aiJson)
                                      : AiBotWidget(
                                          isLastIndex: isLastIndex,
                                          messageData: messageData,
                                          isDesktop: isDesktop),
                                );
                        },
                      );
                    },
                  ),
                  if (isDesktop == false)
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      child: AbsorbPointer(
                        absorbing: true,
                        child: Container(
                          width: Get.width,
                          height: 30,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                primaryBlack,
                                primaryBlack.withOpacity(.6),
                                Colors.transparent
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (isDesktop == false)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: AbsorbPointer(
                        absorbing: true,
                        child: Container(
                          width: Get.width,
                          height: 20,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                primaryBlack.withOpacity(.6),
                                primaryBlack
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  Widget UserWidget(
      {required MessageModel messageData, required bool isDesktop}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(
              AppAsset.edit,
              height: 14,
              width: 14,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: primaryWhite.withOpacity(.1),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 18,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      messageData.text ?? "",
                      style: AppTextStyle.normalRegular14
                          .copyWith(color: primaryWhite.withOpacity(.9)),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget AiBotWidget(
      {required MessageModel messageData,
      required bool isDesktop,
      required bool isLastIndex}) {
    return Padding(
      padding: const EdgeInsets.only(top: 14, bottom: 46),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SvgPicture.asset(
                AppAsset.aiAvatar,
                height: 30,
                width: 30,
                fit: BoxFit.scaleDown,
              ),
              customWidth(10),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: CommonMarkdownWidget(
                            data: messageData.text ?? "",
                          ),
                        ),
                      ],
                    ),
                    height20,
                    Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: SvgPicture.asset(
                              AppAsset.copy,
                              height: 16,
                              width: 16,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: SvgPicture.asset(
                              AppAsset.refresh,
                              height: 16,
                              width: 16,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: SvgPicture.asset(
                              AppAsset.like,
                              height: 16,
                              width: 16,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: SvgPicture.asset(
                              AppAsset.dislike,
                              height: 16,
                              width: 16,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
