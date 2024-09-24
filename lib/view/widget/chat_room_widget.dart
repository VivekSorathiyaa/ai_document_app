import 'package:ai_document_app/controllers/home_controller.dart';
import 'package:ai_document_app/utils/app_asset.dart';
import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/color.dart';
import 'package:ai_document_app/utils/network_image_widget.dart';
import 'package:ai_document_app/utils/static_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../model/chatroom_model.dart';
import '../../utils/common_markdown_widget.dart';

class ChatRoomWidget extends StatelessWidget {
  HomeController homeController;

  ChatRoomWidget({Key? key, required this.homeController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;

    ChatRoomModel chatRoom = homeController.chatRoomList.value.first;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 930.0),
      child: ListView.builder(
        padding: isDesktop ? EdgeInsets.zero : const EdgeInsets.all(16),
        itemCount: chatRoom.messages.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final message = chatRoom.messages[index];
          return message.isUser
              ? UserWidget(message: message, isDesktop: isDesktop)
              : AiBotWidget(message: message, isDesktop: isDesktop);
        },
      ),
    );
  }

  Widget UserWidget(
      {required ChatMessageModel message, required bool isDesktop}) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          NetworkImageWidget(
            height: 34,
            width: 34,
            borderRadius: BorderRadius.circular(34),
          ),
          width10,
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
                  vertical: isDesktop ? 18 : 14,
                  horizontal: isDesktop ? 16 : 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, // Minimum width for this Row
                  children: [
                    Flexible(
                      child: Text(
                        message.content +
                            "v sd vdv dv dv dv dv dfv dfvdf dv sdv dfv sdv sd vdv dvd vdfvdf vdfv dfv dfv dfv dfv df vsdf vd vsdv sdv dfv dfv dfv ",
                        style: isDesktop
                            ? AppTextStyle.normalSemiBold16
                            : AppTextStyle.normalSemiBold14,
                      ),
                    ),
                    width20,
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
      ),
    );
  }

  Widget AiBotWidget(
      {required ChatMessageModel message, required bool isDesktop}) {
    return Row(
      children: [
        SvgPicture.asset(
          AppAsset.aiAvatar,
          height: 34,
          width: 34,
          fit: BoxFit.scaleDown,
        ),
        Container(
          child: Expanded(
            child: CommonMarkdownWidget(
              data: message.content,
            ),
          ),
        ),
      ],
    );
  }

  // Widget _buildMessageTile(ChatMessageModel message) {
  //   return ListTile(
  //     title: Container(
  //       padding: EdgeInsets.all(10),
  //       decoration: BoxDecoration(
  //         color: message.isUser ? Colors.blue : Colors.grey[300],
  //         borderRadius: BorderRadius.circular(8),
  //       ),
  //       child: Text(
  //         message.content,
  //         style: TextStyle(color: message.isUser ? Colors.white : Colors.black),
  //       ),
  //     ),
  //     subtitle: Text(
  //       "${message.timestamp.hour}:${message.timestamp.minute}",
  //       style: TextStyle(fontSize: 12),
  //       textAlign: message.isUser ? TextAlign.right : TextAlign.left,
  //     ),
  //   );
  // }
}
