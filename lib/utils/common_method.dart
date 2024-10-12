import 'dart:math' as math;
import 'dart:ui';

import 'package:ai_document_app/main.dart';
import 'package:ai_document_app/utils/primary_text_button.dart';
import 'package:ai_document_app/view/auth/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import 'app_text_style.dart';
import 'color.dart';

class CommonMethod {
  static String generateOtp() {
    return (math.Random().nextInt(9000) + 1000).toString();
  }

  static Future<void> sendOtpToEmail(String email, String otp) async {
    String username = 'vivek1.semicolon@gmail.com';
    String password = '12345678';

    final smtpServer = gmail(username, password);
    // Create the email message
    final message = Message()
      ..from = Address(username)
      ..recipients.add(email)
      ..subject = 'Your OTP Code'
      ..text = 'Your OTP code is $otp. Please enter it to verify your email.';

    try {
      await send(message, smtpServer);
      print('-----------$message');
    } catch (e) {
      print('-----------Message not sent: $e');
    }
  }

  static Future<void> showSimpleDialog({
    String? title,
    bool? hideContent,
    Widget? titleWidget,
    Widget? iconWidget,
    required Widget child,
    required BuildContext context,
  }) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: primaryBlack.withOpacity(.3),
      builder: (BuildContext context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 15),
// contentPadding: EdgeInsets.zero,
          backgroundColor: bgContainColor,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          contentPadding: EdgeInsets.symmetric(
              horizontal: hideContent != null && hideContent ? 0 : 15),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),

          content: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: hideContent != null && hideContent ? 0 : 20),
                  child: child,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static showLogoutDialog(BuildContext context) async {
    await CommonMethod.showSimpleDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 62,
            width: 62,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: orangeColor.withOpacity(.2),
            ),
            child: const Center(
              child: Icon(
                Icons.logout,
                color: orangeColor,
                size: 30,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Are you sure you want to log out?',
              style: AppTextStyle.normalBold20.copyWith(
                color: greyColor, // Light text color for dark background
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: PrimaryTextButton(
                    height: 40,
                    title: "Cancel",
                    fontSize: 16,
                    gradientColors: [bgBlackColor, bgBlackColor],
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: PrimaryTextButton(
                    height: 40,
                    title: "Logout",
                    fontSize: 16,
                    onPressed: () {
                      performLogout(context);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      context: context,
    );
  }

  static Future<void> performLogout(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    navigateAndRemove(context, LoginView.name);
  }
}
