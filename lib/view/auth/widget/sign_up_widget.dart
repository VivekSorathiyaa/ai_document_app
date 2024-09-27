import 'package:ai_document_app/main.dart';
import 'package:ai_document_app/utils/gradient_border_widget.dart';
import 'package:ai_document_app/view/auth/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../utils/app_asset.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/color.dart';
import '../../../utils/input_text_field_widget.dart';
import '../../../utils/primary_text_button.dart';
import '../../../utils/static_decoration.dart';
import 'auth_footer_widget.dart';

class SignUpWidget extends StatelessWidget {
  SignUpWidget({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final RxBool isCheck = false.obs;
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
                        'Signup',
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
                        'Just some details to get you in!',
                        style: GoogleFonts.notoSans(
                          fontSize: 16,
                          color: hintGreyColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextFormFieldWidget(
                      hintText: 'Full Name',
                      controller: nameController,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 24),
                    TextFormFieldWidget(
                      hintText: 'Email',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 24),
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
                      title: 'Sign up',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: dividerColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Or',
                              style: AppTextStyle.normalRegular16,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            color: dividerColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: SvgPicture.asset(
                              AppAsset.google,
                              height: 40,
                              width: 40,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          width20,
                          Flexible(
                            child: SvgPicture.asset(
                              AppAsset.apple,
                              color: primaryWhite,
                              height: 42,
                              width: 42,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Text(
                            'Already Registered?',
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
                              navigateTo(context, LoginView.name);
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
