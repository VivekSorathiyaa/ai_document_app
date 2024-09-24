import 'package:ai_document_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_text_style.dart';
import 'network_image_widget.dart';

class CommonMarkdownWidget extends StatelessWidget {
  final String data;
  final Color backgroundColor;
  final Color textColor;

  CommonMarkdownWidget({
    Key? key,
    required this.data,
    this.backgroundColor = bgBlackColor,
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: double.infinity,
        color: backgroundColor,
        child: Markdown(
          physics: const NeverScrollableScrollPhysics(),
          data: data,
          selectable: false,
          // padding: EdgeInsets.symmetric(horizontal: 15),
          shrinkWrap: true,
          styleSheet: MarkdownStyleSheet(
            a: AppTextStyle.linkStyle.copyWith(color: textColor),
            p: AppTextStyle.normalRegular14,
            pPadding: EdgeInsets.zero,
            code: AppTextStyle.normalRegular12.copyWith(color: primaryBlack),
            h1: AppTextStyle.normalBold36.copyWith(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
            h1Padding: const EdgeInsets.symmetric(vertical: 12),
            h2: AppTextStyle.normalBold28.copyWith(color: textColor),
            h2Padding: const EdgeInsets.symmetric(vertical: 10),
            h3: AppTextStyle.normalBold24.copyWith(color: textColor),
            h3Padding: const EdgeInsets.symmetric(vertical: 8),
            h4: AppTextStyle.normalBold20.copyWith(color: textColor),
            h4Padding: const EdgeInsets.symmetric(vertical: 6),
            h5: AppTextStyle.normalBold18.copyWith(color: textColor),
            h5Padding: const EdgeInsets.symmetric(vertical: 4),
            h6: AppTextStyle.normalBold16.copyWith(color: textColor),
            h6Padding: const EdgeInsets.symmetric(vertical: 2),
            em: AppTextStyle.italicRegular15,
            strong: AppTextStyle.normalBold14,
            del: AppTextStyle.normalRegular14.copyWith(
              decoration: TextDecoration.lineThrough,
            ),
            blockquote: AppTextStyle.normalRegular14.copyWith(
              fontStyle: FontStyle.italic,
              color: hintGreyColor,
            ),
            img: AppTextStyle.normalRegular14,
            checkbox: AppTextStyle.normalRegular14,
            blockSpacing: 8.0,
            listIndent: 20.0,
            listBullet: AppTextStyle.normalRegular12,
            // listBulletPadding: EdgeInsets.symmetric(horizontal: 8),
            tableHead: AppTextStyle.normalBold14.copyWith(
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
            tableBody: AppTextStyle.normalRegular14,
            tableHeadAlign: TextAlign.center,
            tablePadding: const EdgeInsets.all(4.0),
            tableBorder: TableBorder.all(color: Colors.black),
            tableColumnWidth: FixedColumnWidth(Get.width / 2.5),
            tableCellsPadding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            tableCellsDecoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            tableVerticalAlignment: TableCellVerticalAlignment.intrinsicHeight,
            blockquotePadding: const EdgeInsets.all(8.0),
            blockquoteDecoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4.0),
            ),
            codeblockPadding: const EdgeInsets.all(8.0),

            codeblockDecoration: BoxDecoration(
              color: hintGreyColor,
              borderRadius: BorderRadius.circular(4.0),
            ),
            horizontalRuleDecoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!, width: 1.0),
              ),
            ),
            textAlign: WrapAlignment.start,
            h1Align: WrapAlignment.start,
            h2Align: WrapAlignment.start,
            h3Align: WrapAlignment.start,
            h4Align: WrapAlignment.start,
            h5Align: WrapAlignment.start,
            h6Align: WrapAlignment.start,
            unorderedListAlign: WrapAlignment.start,
            orderedListAlign: WrapAlignment.start,
            blockquoteAlign: WrapAlignment.start,
            codeblockAlign: WrapAlignment.start,
            superscriptFontFeatureTag: 'superscript',
            textScaleFactor: 1.0,
          ),
          onTapLink: _onTapLink,
          imageBuilder: (Uri uri, String? alt, String? title) {
            // You can return a custom widget for image rendering here
            return NetworkImageWidget(
              width: Get.width,
              imageUrl: uri.toString(),
              borderRadius: BorderRadius.circular(20),
            );
          },
          checkboxBuilder: (bool? checked) {
            // Customize the appearance of checkboxes here
            return Checkbox(
              value: checked,
              onChanged: (bool? value) {
                // Handle checkbox state change
              },
            );
          },
          bulletBuilder: (MarkdownBulletParameters parameters) {
            // Customize the appearance of list bullets here
            return const Icon(
              Icons.circle,
              size: 12,
              color: Colors.black,
            );
          },

          listItemCrossAxisAlignment:
              MarkdownListItemCrossAxisAlignment.baseline,
          controller: ScrollController(),
          // Custom scroll controller
          softLineBreak: true, // Whether to use soft line breaks
        ),
      ),
    );
  } // Function to handle link clicks

  void _onTapLink(String? text, String? href, String? title) {
    if (href != null && Uri.tryParse(href)?.hasAbsolutePath == true) {
      _launchURL(href);
    }
  } // Function to launch URL in the browser

  Future<void> _launchURL(String url) async {
    await launch(url);
  }
}
