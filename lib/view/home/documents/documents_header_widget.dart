import 'package:ai_document_app/controllers/documents_controller.dart';
import 'package:ai_document_app/utils/app_asset.dart';
import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/primary_text_button.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class DocumentsHeaderWidget extends StatelessWidget {
  final DocumentsController documentsController;

  DocumentsHeaderWidget({super.key, required this.documentsController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom:
              ResponsiveBreakpoints.of(context).smallerThan(DESKTOP) ? 20 : 40,
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
              child: Text(
                "Uploaded PDFs",
                style: AppTextStyle.normalSemiBold18,
                overflow: TextOverflow.ellipsis, // Handle overflow gracefully
              ),
            ),
          ),

          // Button Section
          ResponsiveRowColumnItem(
            rowFlex: 2,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 474),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Filters Button
                  Expanded(
                    flex: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                        ? 3
                        : 2,
                    child: PrimaryTextButton(
                      title: "Filters",
                      onPressed: () {},
                      height: ResponsiveValue<double>(
                        context,
                        defaultValue: 45.0,
                        conditionalValues: [
                          Condition.smallerThan(name: DESKTOP, value: 40.0),
                        ],
                      ).value!,
                      icon: AppAsset.filter,
                    ),
                  ),
                  SizedBox(
                    width: ResponsiveValue<double>(
                      context,
                      defaultValue: 24.0,
                      conditionalValues: [
                        Condition.smallerThan(name: DESKTOP, value: 16.0),
                      ],
                    ).value!,
                  ),
                  // Upload New Documents Button
                  Expanded(
                    flex: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                        ? 5
                        : 3,
                    child: PrimaryTextButton(
                      title: "Upload New Documents",
                      onPressed: () {},
                      height: ResponsiveValue<double>(
                        context,
                        defaultValue: 45.0,
                        conditionalValues: [
                          Condition.smallerThan(name: DESKTOP, value: 40.0),
                        ],
                      ).value!,
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
