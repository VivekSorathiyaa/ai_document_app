import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/static_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'app_asset.dart';
import 'color.dart';

class UploadingDocumetsWidget extends StatelessWidget {
  const UploadingDocumetsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          border: Border.all(color: tableButtonColor),
          borderRadius: BorderRadius.circular(12),
          color: bgContainColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        child: Row(
          children: [
            const Icon(
              CupertinoIcons.check_mark_circled_solid,
              color: greenColor,
            ),
            customWidth(12),
            SvgPicture.asset(
              AppAsset.pdfGreen,
              width: 33,
              height: 44,
              fit: BoxFit.scaleDown,
            ),
            customWidth(8),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          "Crop_Images..",
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
                          "5 MB",
                          style: AppTextStyle.normalRegular12
                              .copyWith(color: tableButtonColor),
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
            const Icon(
              CupertinoIcons.clear_circled,
              color: tableButtonColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
