import 'package:ai_document_app/main.dart';
import 'package:ai_document_app/utils/gradient_border_widget.dart';
import 'package:ai_document_app/view/auth/add_new_password_view.dart';
import 'package:ai_document_app/view/auth/login_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../utils/app_text_style.dart';
import '../../../utils/color.dart';
import '../../../utils/primary_text_button.dart';
import '../../../utils/static_decoration.dart';
import 'auth_footer_widget.dart';

class VerificationOtpWidget extends StatelessWidget {
  String? uid;
  VerificationOtpWidget({super.key, this.uid});
  final TextEditingController pinController = TextEditingController();

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
                          'Verification OTP',
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
                          'Please enter your OTP code and reset you new password',
                          style: GoogleFonts.notoSans(
                            fontSize: 16,
                            color: hintGreyColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Center(
                          child: Pinput(
                        length: 4,
                        controller: pinController,
                        scrollPadding: EdgeInsets.zero,
                        focusNode: FocusNode(),
                        autofocus: true,
                        pinContentAlignment: Alignment
                            .center, // Center the content within each box
                        defaultPinTheme: PinTheme(
                          width: 63,
                          height: 50,
                          padding: EdgeInsets.zero,
                          textStyle: AppTextStyle.normalRegular24.copyWith(
                            height: 1.0, // Ensure text is centered vertically
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: hintGreyColor),
                          ),
                        ),
                        separatorBuilder: (vds) {
                          return SizedBox(width: 16);
                        }, // Adds spacing between the pin boxes
                        preFilledWidget: Center(
                          child: Text(
                            "0",
                            style: AppTextStyle.normalRegular24.copyWith(
                              color: primaryWhite.withOpacity(.2),
                              height:
                                  1.0, // Ensure pre-filled text is centered vertically
                            ),
                          ),
                        ),
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        onCompleted: (pin) {
                          debugPrint('onCompleted: $pin');
                          navigateAndRemove(context, AddNewPasswordView.name);
                        },
                        onChanged: (value) {
                          debugPrint('onChanged: $value');
                        },
                      )),
                      const SizedBox(height: 44),
                      PrimaryTextButton(
                        title: 'Reset Password',
                        onPressed: () {},
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Text(
                              'Resend new code',
                              style: AppTextStyle.normalRegular16,
                              // maxLines: 1,
                              // overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                            ),
                          ),
                          width10,
                          Flexible(
                            child: InkWell(
                              onTap: () {
                                navigateAndRemove(context, LoginView.name);
                              },
                              child: Text(
                                '00:55',
                                style: AppTextStyle.normalSemiBold16.copyWith(
                                  color: purpleColor,
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
      ),
    );
  }
}
