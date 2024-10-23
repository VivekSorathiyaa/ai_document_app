import 'package:ai_document_app/main.dart';
import 'package:ai_document_app/utils/gradient_border_widget.dart';
import 'package:ai_document_app/view/auth/login_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../utils/app_text_style.dart';
import '../../../utils/color.dart';
import '../../../utils/input_text_field_widget.dart';
import '../../../utils/primary_text_button.dart';
import 'auth_footer_widget.dart';

class AddNewPasswordWidget extends StatelessWidget {
  AddNewPasswordWidget({super.key});
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
                ResponsiveBreakpoints.of(context).isDesktop ? 40.0 : 0.0,
            vertical: 40.0,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 460.0,
              ),
              child: GradientBorderWidget(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        ResponsiveBreakpoints.of(context).isDesktop ? 40 : 20,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Add New Password',
                          style: AppTextStyle.normalSemiBold30,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              'Please enter your new password and continue your wonderful journey',
                              style: GoogleFonts.notoSans(
                                fontSize: 14,
                                color: hintGreyColor,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      PasswordWidget(
                        hintText: 'Password',
                        controller: passwordController,
                      ),
                      const SizedBox(height: 24),
                      PasswordWidget(
                        hintText: 'Confirm Password',
                        controller: confirmPasswordController,
                      ),
                      const SizedBox(height: 32),
                      PrimaryTextButton(
                        title: 'Continue',
                        onPressed: () {
                          navigateAndRemove(context, LoginView.name);
                        },
                      ),
                      AuthFooterWidget(context),
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
