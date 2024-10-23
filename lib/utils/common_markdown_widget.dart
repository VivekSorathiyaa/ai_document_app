import 'package:ai_document_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_highlighter/themes/atom-one-light.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_text_style.dart';
import 'network_image_widget.dart';

class CommonMarkdownWidget extends StatelessWidget {
  final String data;

  CommonMarkdownWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
    double textHeight = 2.0;
    Color textColor = primaryWhite;
    Color backgroundColor = isDesktop ? bgContainColor : Colors.transparent;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: double.infinity,
        color: backgroundColor,
        child: Markdown(
            physics: const NeverScrollableScrollPhysics(),
            data: data,
            selectable: true,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            styleSheetTheme: MarkdownStyleSheetBaseTheme.platform,
            styleSheet: MarkdownStyleSheet(
              a: AppTextStyle.linkStyle
                  .copyWith(color: textColor, height: textHeight),
              p: AppTextStyle.normalRegular14
                  .copyWith(color: textColor, height: textHeight),
              pPadding: EdgeInsets.zero,
              code: AppTextStyle.normalSemiBold12
                  .copyWith(color: primaryBlack, height: textHeight),
              h1: AppTextStyle.normalBold20
                  .copyWith(color: textColor, height: textHeight),
              h1Padding: const EdgeInsets.only(bottom: 12),
              h2: AppTextStyle.normalBold18
                  .copyWith(color: textColor, height: textHeight),
              h2Padding: const EdgeInsets.only(bottom: 10),
              h3: AppTextStyle.normalBold16
                  .copyWith(color: textColor, height: textHeight),
              h3Padding: const EdgeInsets.only(bottom: 8),
              h4: AppTextStyle.normalBold14
                  .copyWith(color: textColor, height: textHeight),
              h4Padding: const EdgeInsets.only(bottom: 6),
              h5: AppTextStyle.normalBold12
                  .copyWith(color: textColor, height: textHeight),
              h5Padding: const EdgeInsets.only(bottom: 4),
              h6: AppTextStyle.normalBold10
                  .copyWith(color: textColor, height: textHeight),
              h6Padding: const EdgeInsets.only(bottom: 2),
              em: AppTextStyle.italicRegular15
                  .copyWith(color: textColor, height: textHeight),
              strong: AppTextStyle.normalBold14
                  .copyWith(color: textColor, height: textHeight),
              del: AppTextStyle.normalRegular14.copyWith(
                  decoration: TextDecoration.lineThrough, height: textHeight),
              blockquote: AppTextStyle.normalRegular14.copyWith(
                  fontStyle: FontStyle.italic,
                  color: primaryBlack,
                  height: textHeight),
              img: AppTextStyle.normalRegular14
                  .copyWith(color: textColor, height: textHeight),
              checkbox: AppTextStyle.normalRegular14
                  .copyWith(color: textColor, height: textHeight),
              blockSpacing: 8.0,
              listIndent: 20.0,
              listBullet: AppTextStyle.normalRegular12
                  .copyWith(color: textColor, height: textHeight),
              tableHead: AppTextStyle.normalBold14.copyWith(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  height: textHeight),
              tableBody: AppTextStyle.normalRegular14
                  .copyWith(color: textColor, height: textHeight),
              tableHeadAlign: TextAlign.center,
              tablePadding: const EdgeInsets.all(4.0),
              tableBorder: TableBorder.all(color: textColor),
              tableColumnWidth: FixedColumnWidth(Get.width / 2.5),
              tableCellsPadding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              tableCellsDecoration: BoxDecoration(
                border: Border.all(color: bgContainColor),
              ),
              tableVerticalAlignment:
                  TableCellVerticalAlignment.intrinsicHeight,
              blockquotePadding: const EdgeInsets.all(14),
              blockquoteDecoration: BoxDecoration(
                color: purpleColor,
                borderRadius: BorderRadius.circular(14),
              ),
              codeblockPadding: const EdgeInsets.all(14),
              codeblockDecoration: BoxDecoration(
                color: darkDividerColor,
                border: Border.all(color: darkDividerColor),
                borderRadius: BorderRadius.circular(14),
              ),
              horizontalRuleDecoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: primaryBlack, width: 1.0),
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
                borderRadius: BorderRadius.circular(14),
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
              return Icon(
                Icons.circle,
                size: 10,
                color: textColor,
              );
            },
            listItemCrossAxisAlignment:
                MarkdownListItemCrossAxisAlignment.baseline,
            controller: ScrollController(),
            // Custom scroll controller
            softLineBreak: true,
            builders: {
              'code': CodeElementBuilder(),
            }),
      ),
    );
  }

  // Function to handle link clicks
  void _onTapLink(String? text, String? href, String? title) {
    if (href != null && Uri.tryParse(href)?.hasAbsolutePath == true) {
      _launchURL(href);
    }
  }

  // Function to launch URL in the browser
  Future<void> _launchURL(String url) async {
    await launch(url);
  }
}

class CodeElementBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    var language = '';

    if (element.attributes['class'] != null) {
      String lg = element.attributes['class'] as String;
      language = lg.substring(9);
    }

    return SizedBox(
      width:
          MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.width,
      child: Container(
        color: primaryBlack, // Set your desired background color here
        child: HighlightView(
          // The original code to be highlighted
          element.textContent,

          // Specify language
          language: language,

          // Specify highlight theme
          theme: MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
                      .platformBrightness ==
                  Brightness.light
              ? atomOneLightTheme
              : customeAtomOneDarkTheme,

          // Specify padding
          padding: const EdgeInsets.all(14),

          // Specify text style
          textStyle: GoogleFonts.notoSans(height: 1.7, fontSize: 14),
        ),
      ),
    );
  }
}

var customeAtomOneDarkTheme = {
  'root': TextStyle(
    color: Color(0xffabb2bf),
    backgroundColor: purpleColor.withOpacity(.1),
  ),
  'comment': TextStyle(color: Color(0xff5c6370), fontStyle: FontStyle.italic),
  'quote': TextStyle(color: Color(0xff5c6370), fontStyle: FontStyle.italic),
  'doctag': TextStyle(color: Color(0xffc678dd)),
  'keyword': TextStyle(color: Color(0xffc678dd)),
  'formula': TextStyle(color: Color(0xffc678dd)),
  'section': TextStyle(color: Color(0xffe06c75)),
  'name': TextStyle(color: Color(0xffe06c75)),
  'selector-tag': TextStyle(color: Color(0xffe06c75)),
  'deletion': TextStyle(color: Color(0xffe06c75)),
  'subst': TextStyle(color: Color(0xffe06c75)),
  'literal': TextStyle(color: Color(0xff56b6c2)),
  'string': TextStyle(color: Color(0xff98c379)),
  'regexp': TextStyle(color: Color(0xff98c379)),
  'addition': TextStyle(color: Color(0xff98c379)),
  'attribute': TextStyle(color: Color(0xff98c379)),
  'meta-string': TextStyle(color: Color(0xff98c379)),
  'built_in': TextStyle(color: Color(0xffe6c07b)),
  'attr': TextStyle(color: Color(0xffd19a66)),
  'variable': TextStyle(color: Color(0xffd19a66)),
  'template-variable': TextStyle(color: Color(0xffd19a66)),
  'type': TextStyle(color: Color(0xffd19a66)),
  'selector-class': TextStyle(color: Color(0xffd19a66)),
  'selector-attr': TextStyle(color: Color(0xffd19a66)),
  'selector-pseudo': TextStyle(color: Color(0xffd19a66)),
  'number': TextStyle(color: Color(0xffd19a66)),
  'symbol': TextStyle(color: Color(0xff61aeee)),
  'bullet': TextStyle(color: Color(0xff61aeee)),
  'link': TextStyle(color: Color(0xff61aeee)),
  'meta': TextStyle(color: Color(0xff61aeee)),
  'selector-id': TextStyle(color: Color(0xff61aeee)),
  'title': TextStyle(color: Color(0xff61aeee)),
  'emphasis': TextStyle(fontStyle: FontStyle.italic),
  'strong': TextStyle(fontWeight: FontWeight.bold),
};
