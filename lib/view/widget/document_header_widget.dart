import 'package:ai_document_app/controllers/documents_controller.dart';
import 'package:ai_document_app/utils/app_asset.dart';
import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/primary_text_button.dart';
import 'package:flutter/material.dart';

class DocumentHeaderWidget extends StatelessWidget {
  final DocumentsController documentsController;

  DocumentHeaderWidget({super.key, required this.documentsController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40, top: 4),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between
        children: [
          Expanded(
            child: Text(
              "Uploaded PDFs",
              style: AppTextStyle.normalSemiBold18,
              overflow: TextOverflow.ellipsis, // Handle overflow gracefully
            ),
          ),
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: 474),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: PrimaryTextButton(
                      title: "Filters",
                      onPressed: () {},
                      height: 45,
                      icon: AppAsset.filter,
                    ),
                  ),
                  const SizedBox(width: 24), // Add some space between buttons
                  Expanded(
                    flex: 3,
                    child: PrimaryTextButton(
                      height: 45,
                      title:
                          "Upload New Documents", // Update the title as needed
                      onPressed: () {},
                      icon: AppAsset.plus,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
