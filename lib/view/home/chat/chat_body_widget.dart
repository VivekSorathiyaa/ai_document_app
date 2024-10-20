import 'package:ai_document_app/controllers/chat_controller.dart';
import 'package:ai_document_app/model/chat_model.dart';
import 'package:ai_document_app/utils/app_asset.dart';
import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/color.dart';
import 'package:ai_document_app/utils/common_method.dart';
import 'package:ai_document_app/utils/network_image_widget.dart';
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
                            horizontal: isDesktop ? 16 : 0),
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
                                      bottom: isLastIndex ? 50 : 0, left: 30),
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        NetworkImageWidget(
          height: 34,
          width: 34,
          borderRadius: BorderRadius.circular(34),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: purpleBorderColor.withOpacity(.8),
                width: isDesktop ? 1 : 0.5,
              ),
              // color: Colors.transparent,
              // color: purpleBorderColor.withOpacity(.06),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: isDesktop ? 10 : 8,
                horizontal: isDesktop ? 16 : 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      messageData.text ?? "",
                      style: isDesktop
                          ? AppTextStyle.normalRegular16
                              .copyWith(color: primaryWhite.withOpacity(.9))
                          : AppTextStyle.normalRegular14
                              .copyWith(color: primaryWhite.withOpacity(.9)),
                    ),
                  ),
                  const SizedBox(width: 20),
                  SvgPicture.asset(
                    AppAsset.edit,
                    height: 18,
                    width: 18,
                    fit: BoxFit.scaleDown,
                  ),
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
      padding: const EdgeInsets.only(top: 16, bottom: 50),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SvgPicture.asset(
                AppAsset.aiAvatar,
                height: 34,
                width: 34,
                fit: BoxFit.scaleDown,
              ),
              customWidth(10),
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
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: SvgPicture.asset(
                  AppAsset.copy,
                  height: 20,
                  width: 20,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: SvgPicture.asset(
                  AppAsset.refresh,
                  height: 20,
                  width: 20,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: SvgPicture.asset(
                  AppAsset.like,
                  height: 20,
                  width: 20,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: SvgPicture.asset(
                  AppAsset.dislike,
                  height: 20,
                  width: 20,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
