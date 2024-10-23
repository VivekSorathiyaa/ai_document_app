import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../utils/app_text_style.dart';
import '../../../utils/color.dart';

Widget AuthFooterWidget(context) {
  return ResponsiveBreakpoints.of(context).isDesktop
      ? Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    'Terms & Conditions',
                    style: AppTextStyle.normalRegular14.copyWith(
                      color: hintGreyColor,
                      decoration: TextDecoration.underline,
                      decorationColor: hintGreyColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    'Support',
                    style: AppTextStyle.normalRegular14.copyWith(
                      color: hintGreyColor,
                      decoration: TextDecoration.underline,
                      decorationColor: hintGreyColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    'Customer Care',
                    style: AppTextStyle.normalRegular14.copyWith(
                      color: hintGreyColor,
                      decoration: TextDecoration.underline,
                      decorationColor: hintGreyColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        )
      : const SizedBox.shrink();
}
