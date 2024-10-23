import 'dart:io';

import 'package:ai_document_app/utils/app_asset.dart';
import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/color.dart';
import 'package:ai_document_app/utils/common_method.dart';
import 'package:ai_document_app/utils/primary_text_button.dart';
import 'package:ai_document_app/utils/static_decoration.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart'; // For web
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/file_dropzone_controller.dart';

class CommonFileDropzone extends StatelessWidget {
  final double? width;
  final double? height;
  final void Function(String downloadUrl) onFileUploaded;
  final List<String> allowedFormats;
  final int maxSizeInMB; // Size in MB
  final int maxFiles;

  CommonFileDropzone({
    Key? key,
    this.width,
    this.height,
    required this.onFileUploaded,
    required this.allowedFormats,
    required this.maxSizeInMB,
    required this.maxFiles,
  }) : super(key: key);

  final controller = Get.put(FileDropzoneController(
    allowedFormats: [],
    maxSize: 0,
    maxFiles: 0,
  ));

  @override
  Widget build(BuildContext context) {
    // Set dynamic attributes
    controller.allowedFormats.addAll(allowedFormats);
    controller.maxSize = maxSizeInMB * 1024 * 1024; // Convert MB to bytes
    controller.maxFiles = maxFiles;

    return InkWell(
      onTap: () async {
        if (!controller.isUploading.value) {
          controller.resetError(); // Reset error state on click
          await controller.browseFiles(onFileUploaded);
        }
      },
      child: Obx(
        () => Column(
          children: [
            kIsWeb ? buildDropzoneWeb() : buildDropzoneNonWeb(),

            // Only show the files list if there are selected files
            if (controller.selectedFiles.isNotEmpty)
              Column(
                children: List.generate(
                  controller.selectedFiles.length,
                  (index) {
                    final file = controller.selectedFiles[index];

                    // Check if the progress is available for the file
                    return Container(
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: tableButtonColor),
                        borderRadius: BorderRadius.circular(12),
                        color: bgContainColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 15),
                        child: Row(
                          children: [
                            Obx(() {
                              final progress =
                                  controller.uploadProgress[file.name]?.value ??
                                      0.0;
                              return SvgPicture.asset(
                                progress < 100
                                    ? AppAsset.checkGrey
                                    : AppAsset.check,
                                width: 24,
                                height: 24,
                                fit: BoxFit.scaleDown,
                              );
                            }),
                            customWidth(12),
                            Obx(() {
                              final progress =
                                  controller.uploadProgress[file.name]?.value ??
                                      0.0;
                              return SvgPicture.asset(
                                progress < 100
                                    ? AppAsset.pdf
                                    : AppAsset.pdfGreen,
                                width: 33,
                                height: 44,
                                fit: BoxFit.scaleDown,
                              );
                            }),
                            customWidth(8),
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          file.name,
                                          style: AppTextStyle.normalRegular16
                                              .copyWith(color: tableTextColor),
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "${CommonMethod.getFileSizeInMB(file)} MB",
                                          style: AppTextStyle.normalRegular12
                                              .copyWith(
                                                  color: tableButtonColor),
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            customWidth(8),
                            Obx(
                              () {
                                // Access the progress for the file reactively
                                final progress = controller
                                        .uploadProgress[file.name]?.value ??
                                    0.0;

                                // Show the GradientLinearProgressIndicator only if the upload is still in progress
                                return progress <
                                        100 // If progress is less than 100, show the progress indicator
                                    ? Expanded(
                                        child: GradientLinearProgressIndicator(
                                          value: progress /
                                              100, // Convert percentage to a value between 0 and 1
                                          gradientColors: const [
                                            orangeColor,
                                            purpleColor
                                          ], // Define your gradient colors here
                                        ),
                                      )
                                    : const SizedBox(); // Hide when complete
                              },
                            ),
                            customWidth(8),
                            IconButton(
                              icon: const Icon(CupertinoIcons.clear_circled,
                                  color: tableButtonColor, size: 20),
                              onPressed: () {
                                // Implement removal of the file from the list
                                controller.removeFile(file.name);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildDropzoneWeb() {
    return DottedBorder(
      borderType: BorderType.RRect,
      strokeWidth: 2,
      color: controller.isError.value ? orangeColor : primaryWhite,
      radius: const Radius.circular(24),
      dashPattern: const [8, 8],
      padding: EdgeInsets.zero,
      borderPadding: EdgeInsets.zero,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: darkDividerColor),
          color: controller.isHighlighted.value
              ? primaryColor.withOpacity(.3)
              : controller.isError.value
                  ? orangeColor.withOpacity(.1)
                  : bgContainColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: IntrinsicHeight(
          child: Stack(
            fit: StackFit.expand,
            children: [
              DropzoneView(
                onDrop: (file) async {
                  controller.resetError();

                  // Check if the dropped file is a PlatformFile
                  if (file is PlatformFile) {
                    // For web or mobile PlatformFile
                    await controller.uploadDocument(
                      file, // Pass the PlatformFile directly
                      CommonMethod.getFileName(file), // Get the file name
                    );
                  } else if (file is File) {
                    // If it's a native file (mobile/Desktop)
                    await controller.uploadDocument(
                      file, // Pass the io.File directly
                      CommonMethod.getFileName(file), // Get the file name
                    );
                  } else {}
                },
                onHover: () => controller.isHighlighted.value = true,
                onLeave: () => controller.isHighlighted.value = false,
                onCreated: (ctrl) => controller.dropzoneController = ctrl,
              ),
              buildDropzoneContent(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for Mobile/Desktop
  Widget buildDropzoneNonWeb() {
    return DottedBorder(
      borderType: BorderType.RRect,
      strokeWidth: 2,
      color: controller.isError.value ? orangeColor : primaryWhite,
      radius: const Radius.circular(24),
      dashPattern: const [8, 8],
      padding: EdgeInsets.zero,
      borderPadding: EdgeInsets.zero,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          border: Border.all(color: darkDividerColor),
          color: controller.isError.value
              ? orangeColor.withOpacity(.1)
              : bgContainColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: IntrinsicHeight(
          child: Stack(
            fit: StackFit.expand,
            children: [
              buildDropzoneContent(),
            ],
          ),
        ),
      ),
    );
  }

  // Common dropzone content (Web & Non-web)
  Widget buildDropzoneContent() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          controller.isUploading.value
              ? const CircularProgressIndicator(
                  color: purpleColor,
                )
              : SvgPicture.asset(
                  AppAsset.cloud,
                  fit: BoxFit.contain,
                ),
          const SizedBox(height: 8),
          Text(
            'Drop Your File Here',
            style: AppTextStyle.normalRegular16,
          ),
          const SizedBox(height: 8),
          Text(
            'OR',
            style: AppTextStyle.normalRegular14,
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 31.21,
            width: 86.97,
            child: PrimaryTextButton(
              title: "Browse",
              onPressed: () async {
                controller.resetError(); // Reset error state on button press
                await controller.browseFiles(onFileUploaded);
              },
              borderRadius: BorderRadius.circular(7),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            controller.isError.value
                ? controller.errorMessage.value
                : 'Maximum File Size: $maxSizeInMB MB',
            style: AppTextStyle.normalRegular12.copyWith(
              color: controller.isError.value ? orangeColor : fileGreyColor,
            ),
          ),
        ],
      ),
    );
  }
}

class GradientLinearProgressIndicator extends StatelessWidget {
  final double value; // Value between 0.0 and 1.0
  final List<Color> gradientColors;

  const GradientLinearProgressIndicator({
    Key? key,
    required this.value,
    required this.gradientColors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7, // Adjust height as needed
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(27), // Adjust border radius as needed
        color: progressGreyColor, // Background color for the progress indicator
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: value, // Width factor based on progress
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), // Same as outer container
            gradient: LinearGradient(
              colors: gradientColors,
              stops: const [0.0, 1.0],
            ),
          ),
        ),
      ),
    );
  }
}
