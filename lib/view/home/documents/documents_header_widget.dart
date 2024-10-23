import 'package:ai_document_app/controllers/documents_controller.dart';
import 'package:ai_document_app/utils/app_asset.dart';
import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/primary_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../utils/color.dart';

class DocumentsHeaderWidget extends StatelessWidget {
  final DocumentsController documentsController;

  DocumentsHeaderWidget({super.key, required this.documentsController});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;

    return Padding(
      padding: EdgeInsets.only(
          bottom: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
              ? 0
              : documentsController.isUploadWidgetOpen.value
                  ? 0
                  : 40,
          top: 4),
      child: ResponsiveRowColumn(
        layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
            ? ResponsiveRowColumnType.COLUMN
            : ResponsiveRowColumnType.ROW,
        rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
        rowCrossAxisAlignment: CrossAxisAlignment.center,
        columnCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Section
          ResponsiveRowColumnItem(
            rowFlex: 1,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                      ? 20
                      : 0),
              child: Row(
                children: [
                  Obx(
                    () => documentsController.isUploadWidgetOpen.value
                        ? InkWell(
                            onTap: () {
                              documentsController.isUploadWidgetOpen.value =
                                  false;
                              documentsController.isUploadWidgetOpen.refresh();
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(right: 15, top: 4),
                              child: Icon(
                                CupertinoIcons.back,
                                color: primaryWhite,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  Expanded(
                    child: Text(
                      "Uploaded PDFs",
                      style: AppTextStyle.normalSemiBold18.copyWith(
                          fontSize: ResponsiveBreakpoints.of(context)
                                  .smallerThan(DESKTOP)
                              ? 14
                              : 16),
                      overflow:
                          TextOverflow.ellipsis, // Handle overflow gracefully
                    ),
                  ),
                ],
              ),
            ),
          ),

          ResponsiveRowColumnItem(
            rowFlex: 2,
            child: Obx(
              () => documentsController.isUploadWidgetOpen.value
                  ? const SizedBox.shrink()
                  : ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 474),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Filters Button
                          Expanded(
                            flex: ResponsiveBreakpoints.of(context)
                                    .smallerThan(DESKTOP)
                                ? 3
                                : 2,
                            child: PrimaryTextButton(
                              title: "Filters",
                              onPressed: () {},
                              fontSize: 14,
                              height: 40,
                              icon: AppAsset.filter,
                            ),
                          ),
                          const SizedBox(width: 24),
                          // Upload New Documents Button
                          Expanded(
                            flex: ResponsiveBreakpoints.of(context)
                                    .smallerThan(DESKTOP)
                                ? 5
                                : 3,
                            child: PrimaryTextButton(
                              title: "Upload New Documents",
                              onPressed: () {
                                documentsController.isUploadWidgetOpen.value =
                                    true;
                                documentsController.isUploadWidgetOpen
                                    .refresh();
                              },
                              fontSize: 14,
                              height: 40,
                              icon: AppAsset.plus,
                            ),
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
}
