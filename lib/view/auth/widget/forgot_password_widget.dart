import 'package:ai_document_app/main.dart';
import 'package:ai_document_app/utils/gradient_border_widget.dart';
import 'package:ai_document_app/view/auth/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../controllers/login_controller.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/color.dart';
import '../../../utils/input_text_field_widget.dart';
import '../../../utils/primary_text_button.dart';
import '../../../utils/static_decoration.dart';
import 'auth_footer_widget.dart';

class ForgotPasswordWidget extends StatelessWidget {
  ForgotPasswordWidget({super.key});
  var controller = Get.put(LoginController());

  refreshPage() {
    // controller.infoMessage.value = "";
    // controller.errorMessage.value = "";
  }

  @override
  Widget build(BuildContext context) {
    refreshPage();
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
                        child: Text(
                          'Forgot Password',
                          style: AppTextStyle.normalSemiBold30,
                        ),
                      ),
                      const SizedBox(height: 8),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Please enter your email',
                          style: GoogleFonts.notoSans(
                            fontSize: 14,
                            color: hintGreyColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      TextFormFieldWidget(
                        hintText: 'Email',
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),
                      Obx(() {
                        if (controller.errorMessage.value.isNotEmpty ||
                            controller.infoMessage.value.isNotEmpty) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: Text(
                              controller.errorMessage.value.isNotEmpty
                                  ? controller.errorMessage.value
                                  : controller.infoMessage.value,
                              style: AppTextStyle.normalRegular14.copyWith(
                                  color:
                                      controller.errorMessage.value.isNotEmpty
                                          ? orangeColor
                                          : greenColor),
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
                                title: 'Reset Password',
                                onPressed: () {
                                  refreshPage();

                                  controller.sendPasswordResetEmail(context);
                                },
                              ),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Text(
                              'Back to',
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
                                navigateAndRemove(context, LoginView.name);
                              },
                              child: Text(
                                'Login',
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
      ),
    );
  }
}
