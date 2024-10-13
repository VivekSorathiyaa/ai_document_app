import 'package:ai_document_app/main.dart';
import 'package:ai_document_app/view/home/home_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/validators.dart';

class LoginController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isCheck = false.obs;
  var errorMessage = ''.obs;
  var infoMessage = ''.obs;
  var isLoading = false.obs;

  Future<bool> checkValidInputs() async {
    final errors = [
      Validators.validateEmail(emailController.text),
      Validators.validatePassword(passwordController.text),
    ].where((error) => error != null).toList();

    if (errors.isNotEmpty) {
      errorMessage(errors.join('\n'));
      return false;
    }
    return true;
  }

  Future<bool> checkValidInputsForgotPassword() async {
    final errors = [
      Validators.validateEmail(emailController.text),
    ].where((error) => error != null).toList();

    if (errors.isNotEmpty) {
      errorMessage(errors.join('\n'));
      return false;
    }
    return true;
  }

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    isLoading(true);

    bool inputsValid = await checkValidInputs();
    if (!inputsValid) {
      isLoading(false);
      return;
    }
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text.trim().toString(),
          password: passwordController.text);

      if (userCredential.user!.emailVerified) {
        await firestore.collection('users').doc(userCredential.user?.uid).set({
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
          'createdAt': FieldValue.serverTimestamp(),
        });
        navigateAndRemove(context, HomeView.name);
      } else {
        errorMessage(
          'Email not verified. Check your inbox for the verification email.',
        );
      }
    } on FirebaseAuthException catch (e) {
      errorMessage('Failed to sign in: ${e.message}');
    } finally {
      isLoading(false);
    }
  }

  Future<void> sendPasswordResetEmail(BuildContext context) async {
    isLoading(true);

    bool inputsValid = await checkValidInputsForgotPassword();
    if (!inputsValid) {
      isLoading(false);
      return;
    }
    Get.back();
    try {
      await auth.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      infoMessage(
        'Password reset email sent to ${emailController.text.trim()}',
      );
    } catch (e) {
      errorMessage(
        'Failed to send password reset email: $e',
      );
    } finally {
      isLoading(false);
    }
  }
}
