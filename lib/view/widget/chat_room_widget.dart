import 'package:ai_document_app/controllers/home_controller.dart';
import 'package:ai_document_app/utils/app_asset.dart';
import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/color.dart';
import 'package:ai_document_app/utils/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../model/chatroom_model.dart';
import '../../utils/common_markdown_widget.dart';
import '../../utils/static_decoration.dart';

class ChatRoomWidget extends StatelessWidget {
  final HomeController homeController;

  ChatRoomWidget({Key? key, required this.homeController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
    ChatRoomModel chatRoom = homeController.chatRoomList.value.last;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 860.0),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isDesktop ? 0 : 16),
        child: ListView.builder(
          itemCount: chatRoom.messages.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final message = chatRoom.messages[index];
            return message.isUser
                ? UserWidget(message: message, isDesktop: isDesktop)
                : AiBotWidget(message: message, isDesktop: isDesktop);
          },
        ),
      ),
    );
  }

  Widget UserWidget(
      {required ChatMessageModel message, required bool isDesktop}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        NetworkImageWidget(
          height: 34,
          width: 34,
          borderRadius: BorderRadius.circular(34),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: purpleBorderColor,
                width: isDesktop ? 1 : 0.5,
              ),
              color: Colors.transparent,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: isDesktop ? 16 : 12,
                horizontal: isDesktop ? 14 : 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      message.content,
                      style: isDesktop
                          ? AppTextStyle.normalSemiBold16
                              .copyWith(color: primaryWhite.withOpacity(.9))
                          : AppTextStyle.normalSemiBold14
                              .copyWith(color: primaryWhite.withOpacity(.9)),
                    ),
                  ),
                  const SizedBox(width: 20),
                  SvgPicture.asset(
                    AppAsset.edit,
                    height: 20,
                    width: 20,
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
      {required ChatMessageModel message, required bool isDesktop}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
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
              data: message.content,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SvgPicture.asset(
                  AppAsset.copy,
                  height: 20,
                  width: 20,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SvgPicture.asset(
                  AppAsset.refresh,
                  height: 20,
                  width: 20,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SvgPicture.asset(
                  AppAsset.like,
                  height: 20,
                  width: 20,
                  fit: BoxFit.scaleDown,
                ),
              ),
              customWidth(40),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
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