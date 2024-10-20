import 'package:ai_document_app/controllers/chat_controller.dart';
import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../controllers/home_controller.dart';
import '../../../model/chat_model.dart';
import '../../../model/document_model.dart';
import '../../../utils/custom_dropdown_widget.dart';
import 'searchbar_widget.dart';

class DesktopAppBarWidget extends StatelessWidget {
  DesktopAppBarWidget({super.key});
  var homeController = Get.put(HomeController());
  var chatController = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
          color: bgBlackColor, borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Obx(
          () => homeController.selectedMenuModel.value.id == 0
              ? Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => CustomDropdown(
                          items: chatController.chatRoomList.value,
                          selectedValues: chatController
                                  .selectedChatList.value.isNotEmpty
                              ? [chatController.selectedChatList.value.first]
                              : [],
                          hintText: 'History',
                          onChanged: (newValues) {
                            chatController.selectedChatList.value =
                                newValues.cast<ChatModel>();
                            chatController.setCurrentChatRoomId(
                                chatController.selectedChatList.value.first);
                          },
                          displayItem: (item) => item.name,
                          selectionMode: SelectionMode.single,
                        ),
                      ),
                    ),
                    const SizedBox(width: 27),
                    Expanded(
                      child: Obx(
                        () {
                          return CustomDropdown(
                            items: chatController.documentsList.value,
                            selectedValues:
                                chatController.selectedDocumentList.value,
                            hintText: 'Select PDF to get answer',
                            onChanged: (newValues) {
                              chatController.selectedDocumentList.assignAll(
                                  newValues
                                      .cast<DocumentModel>()); // Use assignAll
                              chatController
                                  .updateSelectedDocumentsInFirestore();
                            },
                            displayItem: (item) => item.name,
                            selectionMode: SelectionMode.multi,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 27),
                    Expanded(child: SearchbarWidget())
                  ],
                )
              : Row(
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
                    Expanded(flex: 3, child: SearchbarWidget())
                  ],
                ),
        ),
      ),
    );
  }
}
