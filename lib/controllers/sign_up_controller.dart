import 'package:ai_document_app/utils/color.dart';
import 'package:ai_document_app/utils/common_method.dart';
import 'package:ai_document_app/utils/primary_text_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';
import '../utils/app_text_style.dart';
import '../utils/validators.dart';
import '../view/auth/login_view.dart';

class SignUpController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  var errorMessage = ''.obs;
  var isLoading = false.obs;

  Future<bool> checkValidInputs() async {
    final errors = [
      Validators.validateEmail(emailController.text),
      Validators.validatePassword(passwordController.text),
      Validators.validateConfirmPassword(
          confirmPasswordController.text, passwordController.text),
      Validators.validateName(nameController.text),
    ].where((error) => error != null).toList();

    if (errors.isNotEmpty) {
      errorMessage(errors.join('\n'));
      return false;
    }
    return true;
  }

  Future<void> registerWithEmailAndPassword(BuildContext context) async {
    isLoading(true);

    bool inputsValid = await checkValidInputs();
    if (!inputsValid) {
      isLoading(false);
      return;
    }

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await userCredential.user?.sendEmailVerification().then((_) async {
        navigateTo(context, LoginView.name);
        showVerificationSentDialog(context);

        await firestore.collection('users').doc(userCredential.user?.uid).set({
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
          'createdAt': FieldValue.serverTimestamp(),
        });
      });
    } on FirebaseAuthException catch (e) {
      errorMessage(_getErrorMessage(e));
    } catch (e) {
      errorMessage('An unexpected error occurred. Please try again.');
    } finally {
      isLoading(false);
    }
  }

  showVerificationSentDialog(BuildContext context) async {
    await CommonMethod.showSimpleDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 62,
            width: 62,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primaryColor.withOpacity(.2),
            ),
            child: Center(
              child: Icon(
                Icons.mark_email_read_outlined,
                color: primaryColor,
                size: 30,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SelectableText(
            'Verification email sent to:',
            style: AppTextStyle.normalBold16.copyWith(
              color: orangeColor,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          SelectableText(
            emailController.text,
            style: AppTextStyle.normalBold16,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 200,
            child: PrimaryTextButton(
              height: 40,
              title: "OK",
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
      context: context,
    );
  }

  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'The email address is already in use. Please use a different email.';
      case 'weak-password':
        return 'The password provided is too weak. Please choose a stronger password.';
      case 'invalid-email':
        return 'The email address is not valid. Please enter a valid email.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled. Please contact support.';
      default:
        return 'Failed to register: ${e.message}';
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
