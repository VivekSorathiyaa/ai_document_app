import 'package:ai_document_app/utils/static_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../../model/document_list_model.dart';
import '../../model/language_list_model.dart';
import '../../utils/custom_dropdown_widget.dart';

class MobileMenuWidget extends StatelessWidget {
  HomeController homeController;
  MobileMenuWidget({super.key, required this.homeController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 16,
      ),
      child: Row(
        children: [
          Expanded(
            child: Obx(
              () => CustomDropdown(
                items: homeController.documentList.value,
                selectedValues: homeController.selectedDocumentList.value,
                hintText: 'Select PDF',
                onChanged: (newValues) {
                  homeController.selectedDocumentList.value =
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
                items: homeController.languageList.value,
                selectedValues: homeController.selectedLanguageList.value,
                hintText: 'Select Language',
                onChanged: (newValues) {
                  homeController.selectedLanguageList.value =
                      newValues.cast<LanguageListModel>();
                },
                displayItem: (item) => item.name,
                selectionMode: SelectionMode.single,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
