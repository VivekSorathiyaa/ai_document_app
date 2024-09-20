import 'package:ai_document_app/view/widget/forgot_password_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'widget/branding_widget.dart';

class ForgotPasswordView extends StatelessWidget {
  static const String name = 'forgot_password';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ResponsiveRowColumn(
              columnCrossAxisAlignment: CrossAxisAlignment.center,
              columnMainAxisAlignment: MainAxisAlignment.center,
              rowMainAxisAlignment: MainAxisAlignment.center,
              rowCrossAxisAlignment:
                  CrossAxisAlignment.center, // Center alignment
              layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                  ? ResponsiveRowColumnType.COLUMN
                  : ResponsiveRowColumnType.ROW,
              children: [
                if (ResponsiveBreakpoints.of(context).isDesktop)
                  BrandingWidget(constraints: constraints, context: context),
                ForgotPasswordWidget(context),
              ],
            ),
          );
        },
      ),
    );
  }
}
