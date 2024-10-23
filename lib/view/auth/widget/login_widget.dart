import 'package:ai_document_app/controllers/login_controller.dart';
import 'package:ai_document_app/main.dart';
import 'package:ai_document_app/utils/gradient_border_widget.dart';
import 'package:ai_document_app/view/auth/forgot_password_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../utils/app_asset.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/color.dart';
import '../../../utils/input_text_field_widget.dart';
import '../../../utils/primary_text_button.dart';
import '../../../utils/static_decoration.dart';
import '../signup_view.dart';
import 'auth_footer_widget.dart';

class LoginWidget extends StatelessWidget {
  LoginWidget({super.key});
  var controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveBreakpoints.of(context).isDesktop ? 40.0 : 0.0,
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
                        'Login',
                        style: AppTextStyle.normalSemiBold30,
                      ),
                    ),
                    const SizedBox(height: 8),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Glad you\'re back!',
                        style: GoogleFonts.notoSans(
                          fontSize: 14,
                          color: hintGreyColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    AutofillGroup(
                      child: Column(
                        children: [
                          TextFormFieldWidget(
                            hintText: 'Email',
                            controller: controller.emailController,
                            autofillHints: [AutofillHints.email],
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          PasswordWidget(
                            hintText: 'Password',
                            controller: controller.passwordController,
                            autofillHints: [AutofillHints.password],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(
                          () => InkWell(
                            onTap: () {
                              controller.isCheck.value =
                                  !controller.isCheck.value;
                            },
                            child: Stack(
                              children: [
                                Icon(
                                  CupertinoIcons.square_fill,
                                  color: controller.isCheck.value
                                      ? primaryWhite
                                      : Colors.transparent,
                                ),
                                Icon(
                                  controller.isCheck.value
                                      ? CupertinoIcons.checkmark_square_fill
                                      : CupertinoIcons.square,
                                  color: controller.isCheck.value
                                      ? purpleColor
                                      : hintGreyColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Remember me',
                            style: GoogleFonts.notoSans(
                              color: primaryWhite,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              navigateTo(context, ForgotPasswordView.name);
                            },
                            child: ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: <Color>[orangeColor, purpleColor],
                              ).createShader(bounds),
                              child: Text(
                                'Forgot password?',
                                style: GoogleFonts.notoSans(
                                  color: primaryWhite,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.end,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Obx(() {
                      if (controller.errorMessage.value.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: Text(
                            controller.errorMessage.value,
                            style: AppTextStyle.normalRegular14
                                .copyWith(color: orangeColor),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                    Obx(
                      () => controller.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: primaryWhite,
                              ),
                            )
                          : PrimaryTextButton(
                              title: 'Log in',
                              onPressed: () {
                                controller.signInWithEmailAndPassword(context);
                              },
                            ),
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
                              style: AppTextStyle.normalRegular14,
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
                            'Don’t have an account?',
                            style: AppTextStyle.normalRegular14,
                            // maxLines: 1,
                            // overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                          ),
                        ),
                        width10,
                        Flexible(
                          child: InkWell(
                            onTap: () {
                              navigateTo(context, SignupView.name);
                            },
                            child: Text(
                              'Signup',
                              style: AppTextStyle.normalSemiBold14.copyWith(
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
