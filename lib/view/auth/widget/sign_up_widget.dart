import 'package:ai_document_app/main.dart';
import 'package:ai_document_app/utils/gradient_border_widget.dart';
import 'package:ai_document_app/view/auth/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../controllers/sign_up_controller.dart';
import '../../../utils/app_asset.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/color.dart';
import '../../../utils/input_text_field_widget.dart';
import '../../../utils/primary_text_button.dart';
import '../../../utils/static_decoration.dart';
import 'auth_footer_widget.dart';

class SignUpWidget extends StatelessWidget {
  SignUpWidget({super.key});

  var controller = Get.put(SignUpController());

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
                        child: SelectableText(
                          'Signup',
                          style: AppTextStyle.normalSemiBold30,
                        ),
                      ),
                      const SizedBox(height: 8),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SelectableText(
                          'Just some details to get you in!',
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
                              hintText: 'Full Name',
                              controller: controller.nameController,
                              autofillHints: [AutofillHints.username],
                              keyboardType: TextInputType.text,
                            ),
                            const SizedBox(height: 24),
                            TextFormFieldWidget(
                              hintText: 'Email',
                              controller: controller.emailController,
                              autofillHints: [AutofillHints.email],
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 24),
                            PasswordWidget(
                              hintText: 'Password',
                              controller: controller.passwordController,
                              autofillHints: [AutofillHints.password],
                              keyboardType: TextInputType.visiblePassword,
                            ),
                            const SizedBox(height: 24),
                            PasswordWidget(
                              hintText: 'Confirm Password',
                              controller: controller.confirmPasswordController,
                              autofillHints: [AutofillHints.password],
                              keyboardType: TextInputType.visiblePassword,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      Obx(() {
                        if (controller.errorMessage.value.isNotEmpty) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: SelectableText(
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
                                title: 'Sign up',
                                onPressed: () {
                                  controller
                                      .registerWithEmailAndPassword(context);
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
                              child: SelectableText(
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
                            child: SelectableText(
                              'Already Registered?',
                              style: AppTextStyle.normalRegular14,
                              textAlign: TextAlign.end,
                            ),
                          ),
                          width10,
                          Flexible(
                            child: InkWell(
                              onTap: () {
                                navigateTo(context, LoginView.name);
                              },
                              child: SelectableText(
                                'Login',
                                style: AppTextStyle.normalSemiBold14.copyWith(
                                  color: purpleColor,
                                  decoration: TextDecoration.underline,
                                  decorationColor: purpleColor,
                                ),
                                maxLines: 1,
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
