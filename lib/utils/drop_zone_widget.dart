import 'package:ai_document_app/utils/app_asset.dart';
import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/color.dart';
import 'package:ai_document_app/utils/primary_text_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FileDropzoneController extends GetxController {
  late DropzoneViewController dropzoneController;
  var isHighlighted = false.obs;
  var isUploading = false.obs;
  var isError = false.obs;

  // Handle file upload
  Future<void> uploadFile(dynamic file, Function(String) onFileUploaded) async {
    try {
      isUploading.value = true;
      // final fileName = file.name;
      // final fileBytes = await dropzoneController.getFileData(file);
      //
      // // Firebase storage upload
      // await storageRef.putData(fileBytes);
      // final downloadUrl = await storageRef.getDownloadURL();
      //
      // // Notify file uploaded
      // onFileUploaded(downloadUrl);
      isUploading.value = false;
    } catch (e) {
      isError.value = true;
      isUploading.value = false;
    } finally {
      isError.value = true;
      isUploading.value = false;
    }
  }

  // For browsing files from the PC
  Future<void> browseFiles(Function(String) onFileUploaded) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'png', 'jpg'],
        allowMultiple: true,
      );

      if (result != null) {
        for (var file in result.files) {
          // final fileName = file.name;
          // final fileBytes = file.bytes!;
          //
          // final storageRef = FirebaseStorage.instance.ref().child(fileName);
          // await storageRef.putData(fileBytes);
          // final downloadUrl = await storageRef.getDownloadURL();
          // onFileUploaded(downloadUrl);
        }
      }
    } catch (e) {
      isError.value = true;
    }
  }
}

class CommonFileDropzone extends StatelessWidget {
  final double? width;
  final void Function(String downloadUrl) onFileUploaded;

  CommonFileDropzone({
    Key? key,
    this.width,
    required this.onFileUploaded,
  }) : super(key: key);

  final controller = Get.put(FileDropzoneController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (!controller.isUploading.value) {
          await controller.browseFiles(onFileUploaded);
        }
      },
      child: Obx(() => DottedBorder(
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
                color: controller.isHighlighted.value
                    ? primaryColor.withOpacity(.3)
                    : controller.isError.value
                        ? orangeColor
                        : bgContainColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: IntrinsicHeight(
                // Ensure the height adjusts to content
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    DropzoneView(
                      onDrop: (file) async {
                        await controller.uploadFile(file, onFileUploaded);
                      },
                      onHover: () => controller.isHighlighted.value = true,
                      onLeave: () => controller.isHighlighted.value = false,
                      onCreated: (ctrl) => controller.dropzoneController = ctrl,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          controller.isUploading.value
                              ? const CircularProgressIndicator()
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
                              title: "Browser",
                              onPressed: () {},
                              borderRadius: BorderRadius.circular(7),
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            controller.isError.value
                                ? 'Only images and PDFs of up to 18mb are allowed'
                                : 'Maximum File Size 18 MB',
                            style: AppTextStyle.normalRegular12.copyWith(
                              color: controller.isError.value
                                  ? orangeColor
                                  : tableButtonColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
