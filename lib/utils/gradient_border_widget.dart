import 'package:ai_document_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class GradientBorderWidget extends StatelessWidget {
  Widget child;

  GradientBorderWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.of(context).isDesktop
        ? Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey, Colors.grey.withOpacity(.3)],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: primaryBlack,
                borderRadius: BorderRadius.circular(20),
              ),
              child: child,
            ),
          )
        : child;
  }
}
