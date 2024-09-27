import 'package:ai_document_app/view/auth/widget/forgot_password_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'widget/branding_widget.dart';

class ForgotPasswordView extends StatelessWidget {
  static const String name = 'forgot_password';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          if (ResponsiveBreakpoints.of(context).isDesktop)
            const Expanded(
              child: BrandingWidget(),
            ),
          Expanded(child: ForgotPasswordWidget())
        ],
      ),
    );
  }
}
