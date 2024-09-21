import 'package:flutter/material.dart';

import 'app_text_style.dart';
import 'color.dart';

class PrimaryTextButton extends StatelessWidget {
  final String? title;
  final VoidCallback onPressed;
  final List<Color>? gradientColors; // List of colors for the gradient
  final Color? textColor;
  // final Color? textColor;
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
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? 50,
        child: GestureDetector(
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
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  title ?? '',
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.normalSemiBold18.copyWith(
                      color: textColor ?? primaryWhite,
                      fontSize: fontSize ?? 18),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
