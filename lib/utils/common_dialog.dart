import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonDialog {
  static void showCustomDialog({
    required String title,
    required Widget content,
    String? confirmText,
    VoidCallback? onConfirm,
    String? cancelText,
    VoidCallback? onCancel,
  }) {
    Get.dialog(
      AlertDialog(
        elevation: 8,
        backgroundColor: bgBlackColor,
        title: Text(
          title,
          style: AppTextStyle.normalBold16,
          textAlign: TextAlign.center,
        ),
        content: SizedBox(
          height: Get.height / 2,
          width: Get.width,
          child: Scrollbar(
            child: SingleChildScrollView(
              child: content, // Use the dynamic content passed as a parameter
            ),
          ),
        ),
      ),
    );
  }
}
