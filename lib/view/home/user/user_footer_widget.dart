import 'package:ai_document_app/controllers/user_controller.dart';
import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/color.dart';
import 'package:ai_document_app/utils/static_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserFooterWidget extends StatelessWidget {
  final UserController userController;

  const UserFooterWidget({
    super.key,
    required this.userController,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final currentPage = userController.currentPage.value;
      final rowsPerPage = userController.rowsPerPage.value;
      final totalPages =
          (userController.userDataList.value.length / rowsPerPage).ceil();
      final startItem = (currentPage * rowsPerPage) + 1;
      final endItem = ((currentPage + 1) * rowsPerPage)
          .clamp(1, userController.userDataList.value.length);

      return Container(
        padding: const EdgeInsets.symmetric(vertical: 46, horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "Showing $startItem to $endItem of ${userController.userDataList.value.length} results",
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
                          userController.currentPage.value -= 1;
                          userController.paginateData();
                        }
                      : null,
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, right: 16, left: 20),
                    decoration: BoxDecoration(
                        border: Border.all(color: primaryWhite),
                        borderRadius: BorderRadius.circular(8)),
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
                        )
                      ],
                    ),
                  ),
                ),
                // Text(
                //   'Page ${currentPage + 1} of $totalPages',
                //   style: AppTextStyle.normalSemiBold14,
                // ),
                width16,
                InkWell(
                  onTap: currentPage < totalPages - 1
                      ? () {
                          userController.currentPage.value += 1;
                          userController.paginateData();
                        }
                      : null,
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, right: 20, left: 16),
                    decoration: BoxDecoration(
                        border: Border.all(color: primaryWhite),
                        borderRadius: BorderRadius.circular(8)),
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
