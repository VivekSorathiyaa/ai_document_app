import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/home_controller.dart';
import '../../../model/chat_list_model.dart';
import '../../../model/document_list_model.dart';
import '../../../model/language_list_model.dart';
import '../../../utils/custom_dropdown_widget.dart';

class DesktopChatHeaderWidget extends StatelessWidget {
  HomeController homeController;
  DesktopChatHeaderWidget({super.key, required this.homeController});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 797.0),
      child: Row(
        children: [
          Expanded(
            child: Obx(
              () => CustomDropdown(
                items: homeController.chatList.value,
                selectedValues: homeController.selectedChatList.value.isNotEmpty
                    ? [homeController.selectedChatList.value.first]
                    : [],
                hintText: 'History',
                onChanged: (newValues) {
                  homeController.selectedChatList.value =
                      newValues.cast<ChatListModel>();
                },
                displayItem: (item) => item.name,
                selectionMode: SelectionMode.single,
              ),
            ),
          ),
          const SizedBox(width: 27),
          Expanded(
            child: Obx(
              () => CustomDropdown(
                items: homeController.documentList.value,
                selectedValues: homeController.selectedDocumentList.value,
                hintText: 'Select PDF to get answer',
                onChanged: (newValues) {
                  homeController.selectedDocumentList.value =
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
                items: homeController.languageList.value,
                selectedValues: homeController.selectedLanguageList.value,
                hintText: 'Select the Language to get Answer',
                onChanged: (newValues) {
                  homeController.selectedLanguageList.value =
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
