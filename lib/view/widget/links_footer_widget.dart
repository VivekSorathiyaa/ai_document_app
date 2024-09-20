import 'package:flutter/cupertino.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../utils/app_text_style.dart';
import '../../utils/color.dart';

Widget LinkFooterWidget(context) {
  return ResponsiveBreakpoints.of(context).isDesktop
      ? Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Terms & Conditions',
                  style: AppTextStyle.normalRegular16.copyWith(
                    color: hintGreyColor,
                    decoration: TextDecoration.underline,
                    decorationColor: hintGreyColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'Support',
                  style: AppTextStyle.normalRegular16.copyWith(
                    color: hintGreyColor,
                    decoration: TextDecoration.underline,
                    decorationColor: hintGreyColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'Customer Care',
                  style: AppTextStyle.normalRegular16.copyWith(
                    color: hintGreyColor,
                    decoration: TextDecoration.underline,
                    decorationColor: hintGreyColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        )
      : const SizedBox.shrink();
}
