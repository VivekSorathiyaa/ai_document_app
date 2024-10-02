import 'package:ai_document_app/controllers/user_controller.dart';
import 'package:ai_document_app/model/user_model.dart';
import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../utils/app_asset.dart';
import '../../../utils/custom_dropdown_widget.dart';

class MobileUserWidget extends StatelessWidget {
  final UserController userController;

  MobileUserWidget({super.key, required this.userController});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;

    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        Obx(() {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            itemCount: userController.paginatedData.length,
            itemBuilder: (context, index) {
              final user = userController.paginatedData[index];
              return _buildDocumentTile(user);
            },
          );
        }),
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
  Widget _buildDocumentTile(UserModel user) {
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
      // height: 80, // Keep the height compact (between 50-100 px)
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: _buildDocumentDetails(user),
      ),
    );
  }

  /// Builds the compact document details with icons and reduced text size
  Widget _buildDocumentDetails(UserModel user) {
    return Column(
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
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: tableRowColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: darkDividerColor, width: 0.5),
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
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: tableRowColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: darkDividerColor, width: 0.5),
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
              ),
            ),
            const SizedBox(width: 12),
            _buildFancyIconButton(AppAsset.delete, 'Delete', onPressed: () {
              // documentsController.deleteDocument(document);
            }),
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
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: SvgPicture.asset(
            iconPath,
            width: 20,
            height: 20,
            fit: BoxFit.scaleDown,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}
