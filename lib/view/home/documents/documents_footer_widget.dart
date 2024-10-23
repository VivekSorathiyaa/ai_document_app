import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/color.dart';
import 'package:ai_document_app/utils/static_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/documents_controller.dart';

class DocumentFooterWidget extends StatelessWidget {
  final DocumentsController documentsController;

  const DocumentFooterWidget({
    super.key,
    required this.documentsController,
  });
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final currentPage = documentsController.currentPage.value;
      final rowsPerPage = documentsController.rowsPerPage.value;
      final documentDataList = documentsController.documentDataList.value;

      if (documentsController.isUploadWidgetOpen.value) {
        return const SizedBox.shrink();
      }

      // Check if the list is empty
      if (documentDataList.isEmpty) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 46, horizontal: 24),
          child: Text(
            "No results found",
            style: AppTextStyle.normalRegular18,
          ),
        );
      }

      final totalResults = documentDataList.length;
      final totalPages = (totalResults / rowsPerPage).ceil();

      // Ensure rowsPerPage is greater than 0
      final effectiveRowsPerPage = rowsPerPage > 0 ? rowsPerPage : 1;

      // Calculate start and end item indices safely
      final startItem = (currentPage * effectiveRowsPerPage) + 1;
      final endItem =
          ((currentPage + 1) * effectiveRowsPerPage).clamp(1, totalResults);

      return Container(
        padding: const EdgeInsets.symmetric(vertical: 46, horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "Showing $startItem to $endItem of $totalResults results",
                style: AppTextStyle.normalRegular18,
                maxLines: 1,
                overflow: TextOverflow.fade,
              ),
            ),
            Row(
              children: [
                InkWell(
                  onTap: currentPage > 0
                      ? () {
                          documentsController.currentPage.value -= 1;
                          documentsController.paginateData();
                        }
                      : null,
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, right: 16, left: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryWhite),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.arrow_back_ios,
                          color: primaryWhite,
                          size: 16,
                        ),
                        customWidth(6),
                        Center(
                          child: Text(
                            'Previous',
                            style: AppTextStyle.normalBold16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                width16,
                InkWell(
                  onTap: currentPage < totalPages - 1
                      ? () {
                          documentsController.currentPage.value += 1;
                          documentsController.paginateData();
                        }
                      : null,
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, right: 20, left: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryWhite),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Next',
                          style: AppTextStyle.normalBold16,
                        ),
                        customWidth(6),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: primaryWhite,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
