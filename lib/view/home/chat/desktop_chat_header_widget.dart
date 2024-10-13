import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/chat_controller.dart';
import '../../../model/document_list_model.dart';
import '../../../model/language_list_model.dart';
import '../../../utils/custom_dropdown_widget.dart';

class DesktopChatHeaderWidget extends StatelessWidget {
  DesktopChatHeaderWidget({super.key});

  final chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 797.0),
      child: Row(
        children: [
          Expanded(
            child: Obx(
              () => CustomDropdown(
                items: chatController.chatRoomList.value,
                selectedValues: chatController.selectedChatList.value.isNotEmpty
                    ? [chatController.selectedChatList.value.first]
                    : [],
                hintText: 'History',
                onChanged: (newValues) {
                  chatController.selectedChatList.value =
                      newValues.cast<QueryDocumentSnapshot>();
                  chatController.setCurrentChatRoomId(
                      chatRoomId: newValues.first.id,
                      chatRoomName: newValues.first['name']);
                },
                displayItem: (item) => item['name'],
                selectionMode: SelectionMode.single,
              ),
            ),
          ),
          const SizedBox(width: 27),
          Expanded(
            child: Obx(
              () => CustomDropdown(
                items: chatController.documentList.value,
                selectedValues: chatController.selectedDocumentList.value,
                hintText: 'Select PDF to get answer',
                onChanged: (newValues) {
                  chatController.selectedDocumentList.value =
                      newValues.cast<DocumentListModel>();
                },
                displayItem: (item) => item.name,
                selectionMode: SelectionMode.multi,
              ),
            ),
          ),
          const SizedBox(width: 27),
          Expanded(
            child: Obx(
              () => CustomDropdown(
                items: chatController.languageList.value,
                selectedValues: chatController.selectedLanguageList.value,
                hintText: 'Select the Language to get Answer',
                onChanged: (newValues) {
                  chatController.selectedLanguageList.value =
                      newValues.cast<LanguageListModel>();
                },
                displayItem: (item) => item.name,
                selectionMode: SelectionMode.multi,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
