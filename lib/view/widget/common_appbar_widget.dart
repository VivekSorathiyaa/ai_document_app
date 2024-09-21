import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/color.dart';
import 'package:ai_document_app/utils/input_text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_framework/responsive_framework.dart';

ResponsiveRowColumnItem CommonAppBarWidget({required BuildContext context}) {
  return ResponsiveRowColumnItem(
      rowFlex: 9,
      child: Container(
        decoration: BoxDecoration(
            color: bgBlackColor, borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: SafeArea(
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Text(
                    'Chat AI',
                    style: AppTextStyle.normalSemiBold34,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: TextFormFieldWidget(
                      hintText: "Search",
                      maxLines: 1,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
                          CupertinoIcons.search,
                          color: primaryWhite,
                          size: 20,
                        ),
                      ),
                      hintStyle: AppTextStyle.normalRegular14,
                      filledColor: primaryBlack,
                      borderColor: primaryBlack,
                      borderRadius: 30,
                      controller: TextEditingController()),
                )
              ],
            ),
          ),
        ),
      ));
}
