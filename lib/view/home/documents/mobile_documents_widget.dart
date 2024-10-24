import 'package:ai_document_app/controllers/documents_controller.dart';
import 'package:ai_document_app/model/document_model.dart';
import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/color.dart';
import 'package:ai_document_app/utils/static_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../utils/app_asset.dart';

class MobileDocumentsWidget extends StatelessWidget {
  final DocumentsController documentsController;

  MobileDocumentsWidget({super.key, required this.documentsController});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;

    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        Obx(
          () {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              itemCount: documentsController.paginatedData.length,
              itemBuilder: (context, index) {
                final document = documentsController.paginatedData[index];
                return _buildDocumentTile(document);
              },
            );
          },
        ),
        if (isDesktop == false)
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: AbsorbPointer(
              absorbing: true,
              child: Container(
                width: Get.width,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      primaryBlack,
                      primaryBlack.withOpacity(.5),
                      Colors.transparent
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
        if (isDesktop == false)
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: AbsorbPointer(
              absorbing: true,
              child: Container(
                width: Get.width,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      primaryBlack.withOpacity(.5),
                      primaryBlack
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  /// Builds a fancy, compact tile for each document
  Widget _buildDocumentTile(DocumentModel document) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: bgBlackColor,
        border: Border.all(color: darkDividerColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      height: 80, // Keep the height compact (between 50-100 px)
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: _buildDocumentDetails(document)),
            customWidth(5),
            _buildActionsRow(document),
          ],
        ),
      ),
    );
  }

  /// Builds the compact document details with icons and reduced text size
  Widget _buildDocumentDetails(DocumentModel document) {
    return Row(
      children: [
        SvgPicture.asset(
          document.status == "Uploaded"
              ? AppAsset.pdfGreen
              : AppAsset.pdf, // Use a document icon for visual appeal
          width: 40,
          height: 40,
          fit: BoxFit.scaleDown,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: SelectableText(
                      document.name,
                      style: AppTextStyle.normalSemiBold14.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: _buildIconWithText(AppAsset.clipboard,
                        '${document.size.toStringAsFixed(2)} MB'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _buildIconWithText(AppAsset.date, document.date)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds a compact icon with a small text
  Widget _buildIconWithText(String iconPath, String text) {
    return Row(
      children: [
        SvgPicture.asset(
          iconPath,
          width: 16,
          height: 16,
          color: Colors.white70,
          fit: BoxFit.scaleDown,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: SelectableText(
            text,
            style: AppTextStyle.normalRegular14.copyWith(
              color: Colors.white70,
              fontSize: 12,
            ),
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  /// Builds the action buttons (delete and reset) with icons only for a fancy look
  Widget _buildActionsRow(DocumentModel document) {
    return Row(
      children: [
        _buildFancyIconButton(AppAsset.delete, 'Delete', onPressed: () {
          // documentsController.deleteDocument(document);
        }),
        const SizedBox(width: 8),
        _buildFancyIconButton(AppAsset.reset, 'Reset', onPressed: () {
          // documentsController.resetDocument(document);
        }),
      ],
    );
  }

  /// Builds a circular button with shadow for icons
  Widget _buildFancyIconButton(String iconPath, String label,
      {required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white10,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: SvgPicture.asset(
          iconPath,
          width: 16,
          height: 16,
          fit: BoxFit.scaleDown,
          color: Colors.white,
        ),
      ),
    );
  }
}
