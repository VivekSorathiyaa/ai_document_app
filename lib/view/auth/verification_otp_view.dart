import 'package:ai_document_app/view/auth/widget/verification_otp_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'widget/branding_widget.dart';

class VerificationOtpView extends StatelessWidget {
  static const String name = 'verification_otp';
  String? uid;

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is String) {
      uid = arguments;
    } else {
      uid = null;
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          if (ResponsiveBreakpoints.of(context).isDesktop)
            const Expanded(
              child: BrandingWidget(),
            ),
          Expanded(
              child: VerificationOtpWidget(
            uid: uid,
          ))
        ],
      ),
    );
  }
}
