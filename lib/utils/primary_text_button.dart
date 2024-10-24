import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'app_text_style.dart';
import 'color.dart';

class PrimaryTextButton extends StatelessWidget {
  final String? title;
  final VoidCallback onPressed;
  final List<Color>? gradientColors; // List of colors for the gradient
  final Color? textColor;
  final TextStyle? textStyle;
  final String? icon;
  final double? width;
  final double? height;
  final double? fontSize;
  final BorderSide? border;
  final bool autofocus;
  final BorderRadiusGeometry? borderRadius;

  PrimaryTextButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.gradientColors, // Initialize with required gradientColors
    this.textColor,
    this.textStyle,
    this.icon,
    this.border,
    this.width,
    this.fontSize,
    this.height,
    this.borderRadius,
    this.autofocus = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width ?? MediaQuery.of(context).size.width, // Set default width
        height: height ?? 42,
        child: Material(
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          color: primaryBlack,
          child: InkWell(
            onTap: onPressed,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradientColors ?? [orangeColor, purpleColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: borderRadius ?? BorderRadius.circular(12),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisSize:
                        MainAxisSize.min, // Row only takes required space
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (icon != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: SvgPicture.asset(
                            icon!,
                            height: fontSize ?? 20,
                            width: fontSize ?? 20,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      Flexible(
                        child: Text(
                          title ?? '',
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: textStyle ??
                              AppTextStyle.normalSemiBold14.copyWith(
                                  color: textColor ?? primaryWhite,
                                  fontSize: fontSize ?? 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis, // Avoid overflow
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
