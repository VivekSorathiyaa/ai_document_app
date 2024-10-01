import 'package:ai_document_app/controllers/user_controller.dart';
import 'package:ai_document_app/model/user_model.dart';
import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../utils/app_asset.dart';
import '../../../utils/custom_dropdown_widget.dart';

class MobileUserWidget extends StatelessWidget {
  final UserController userController;

  MobileUserWidget({super.key, required this.userController});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        itemCount: userController.paginatedData.length,
        itemBuilder: (context, index) {
          final user = userController.paginatedData[index];
          return _buildDocumentTile(user);
        },
      );
    });
  }

  /// Builds a fancy, compact tile for each document
  Widget _buildDocumentTile(UserModel user) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: bgContainColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      // height: 80, // Keep the height compact (between 50-100 px)
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDocumentDetails(user),
            _buildActionsRow(user),
          ],
        ),
      ),
    );
  }

  /// Builds the compact document details with icons and reduced text size
  Widget _buildDocumentDetails(UserModel user) {
    return Row(
      children: [
        Icon(
          CupertinoIcons.profile_circled,
          color: Colors.white70,
          size: 40,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: AppTextStyle.normalSemiBold14.copyWith(
                color: Colors.white,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildIconWithText(CupertinoIcons.mail, '${user.email}'),
                const SizedBox(width: 12),
                _buildIconWithText(CupertinoIcons.calendar, user.date),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  width: Get.width / 4,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: tableButtonColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: tableBorderColor, width: 0.5),
                  ),
                  child: Center(
                    child: Text(
                      user.permissions,
                      style: AppTextStyle.normalRegular14
                          .copyWith(color: tableTextColor),
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: Get.width / 3,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: tableRowColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: tableBorderColor, width: 0.5),
                  ),
                  child: AccessDropdown(
                    currentValue: user.access,
                    userId: user.id,
                    accessLevels: userController.accessLevels.value,
                    onAccessLevelChanged: (String newAccessLevel) {
                      // Update the access level in the controller
                      userController.updateAccessLevel(user.id, newAccessLevel);
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// Builds a compact icon with a small text
  Widget _buildIconWithText(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white70,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: AppTextStyle.normalRegular14.copyWith(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  /// Builds the action buttons (delete and reset) with icons only for a fancy look
  Widget _buildActionsRow(UserModel user) {
    return Row(
      children: [
        _buildFancyIconButton(AppAsset.delete, 'Delete', onPressed: () {
          // documentsController.deleteDocument(document);
        }),
        const SizedBox(width: 8),
        // _buildFancyIconButton(AppAsset.reset, 'Reset', onPressed: () {
        //   // documentsController.resetDocument(document);
        // }),
      ],
    );
  }

  /// Builds a circular button with shadow for icons
  Widget _buildFancyIconButton(String iconPath, String label,
      {required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
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
          width: 20,
          height: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
