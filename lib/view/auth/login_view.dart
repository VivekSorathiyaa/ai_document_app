import 'package:ai_document_app/view/auth/widget/login_widget.dart';
import 'package:flutter/material.dart';

import 'widget/branding_widget.dart';

class LoginView extends StatelessWidget {
  static const String name = 'login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          const Expanded(
            child: BrandingWidget(),
          ),
          Expanded(child: LoginWidget())
        ],
      ),
    );
  }
}
