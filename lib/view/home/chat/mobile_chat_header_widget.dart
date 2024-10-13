import 'package:ai_document_app/utils/static_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/chat_controller.dart';
import '../../../model/document_list_model.dart';
import '../../../model/language_list_model.dart';
import '../../../utils/custom_dropdown_widget.dart';

class MobileChatHeaderWidget extends StatelessWidget {
  MobileChatHeaderWidget({super.key});
  final chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Obx(
            () => CustomDropdown(
              items: chatController.documentList.value,
              selectedValues: chatController.selectedDocumentList.value,
              hintText: 'Select PDF',
              onChanged: (newValues) {
                chatController.selectedDocumentList.value =
                    newValues.cast<DocumentListModel>();
              },
              displayItem: (item) => item.name,
              selectionMode: SelectionMode.multi,
            ),
          ),
        ),
        width16,
        Expanded(
          child: Obx(
            () => CustomDropdown(
              items: chatController.languageList.value,
              selectedValues: chatController.selectedLanguageList.value,
              hintText: 'Select Language',
              onChanged: (newValues) {
                chatController.selectedLanguageList.value =
                    newValues.cast<LanguageListModel>();
              },
              displayItem: (item) => item.name,
              selectionMode: SelectionMode.single,
            ),
          ),
        ),
      ],
    );
  }
}
