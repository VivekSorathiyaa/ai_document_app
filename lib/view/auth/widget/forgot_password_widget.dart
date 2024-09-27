import 'package:ai_document_app/main.dart';
import 'package:ai_document_app/utils/gradient_border_widget.dart';
import 'package:ai_document_app/view/auth/login_view.dart';
import 'package:ai_document_app/view/auth/verification_otp_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../utils/app_text_style.dart';
import '../../../utils/color.dart';
import '../../../utils/input_text_field_widget.dart';
import '../../../utils/primary_text_button.dart';
import '../../../utils/static_decoration.dart';
import 'auth_footer_widget.dart';

class ForgotPasswordWidget extends StatelessWidget {
  ForgotPasswordWidget({super.key});
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        // Center the entire column
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
                ResponsiveBreakpoints.of(context).isDesktop ? 40.0 : 0.0,
            vertical: 40.0,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 480.0,
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
                        'Forgot Password',
                        style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 36,
                          color: primaryWhite,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Please enter your email',
                        style: GoogleFonts.notoSans(
                          fontSize: 16,
                          color: hintGreyColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextFormFieldWidget(
                      hintText: 'Email',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 44),
                    PrimaryTextButton(
                      title: 'Get OTP',
                      onPressed: () {
                        navigateTo(context, VerificationOtpView.name);
                      },
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Text(
                            'Back to',
                            style: AppTextStyle.normalRegular16,
                            // maxLines: 1,
                            // overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                          ),
                        ),
                        width10,
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              navigateAndRemove(context, LoginView.name);
                            },
                            child: Text(
                              'Login',
                              style: AppTextStyle.normalSemiBold16.copyWith(
                                color: purpleColor,
                                decoration: TextDecoration.underline,
                                decorationColor: purpleColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ],
                    ),
                    AuthFooterWidget(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
