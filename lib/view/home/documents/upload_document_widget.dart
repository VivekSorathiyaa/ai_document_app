import 'package:ai_document_app/utils/static_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../utils/drop_zone_widget.dart';

class UploadDocumentWidget extends StatelessWidget {
  UploadDocumentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 2),
      children: [_buildPhotoWidget(context, false), customHeight(20)],
    );
  }
}

Widget _buildPhotoWidget(BuildContext context, bool isFromProfile) {
  bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
  return Align(
    alignment: Alignment.topCenter,
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 757.0),
      child: Column(
        children: [
          customHeight(20),
          CommonFileDropzone(
            onFileUploaded: (String downloadUrl) {},
            height: 420,
            allowedFormats: const ['pdf'],
            maxFiles: 3,
            maxSizeInMB: 16,
          ),
        ],
      ),
    ),
  );
}
