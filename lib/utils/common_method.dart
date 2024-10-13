import 'dart:async';
import 'dart:html' as html;
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui';

import 'package:ai_document_app/main.dart';
import 'package:ai_document_app/utils/primary_text_button.dart';
import 'package:ai_document_app/view/auth/login_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js/js.dart';
import 'package:js/js_util.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_text/pdf_text.dart';
import 'package:uuid/uuid.dart';

import '../model/document_model.dart';
import '../utils/color.dart';
import 'app_text_style.dart';

@JS('extractTextFromPDF')
external dynamic extractTextFromPDF(String pdfUrl);

class CommonMethod {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference collectionDocuments =
      FirebaseFirestore.instance.collection('documents');
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

  static Future<void> getXSnackBar(
    String title,
    String message,
  ) {
    return Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          backgroundColor: bgContainColor,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          contentPadding: const EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.info_outline,
                size: 50,
                color: Colors.white,
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Color for title text
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70, // Message text color
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.white), // OK button color
              ),
            ),
          ],
        ),
      ),
      barrierDismissible:
          false, // Ensures the dialog can't be dismissed by tapping outside
      barrierColor: Colors.black.withOpacity(0.3),
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

  // Delete a chat room by its ID
  static Future<void> deleteChatRoom(String roomId) async {
    try {
      await firestore.collection('chat_rooms').doc(roomId).delete();
    } catch (e) {
      print('Error deleting conversation: $e');
      rethrow;
    }
  }

  // Update a chat room's name
  static Future<void> updateChatRoomName(String roomId, String newName) async {
    try {
      await firestore.collection('chat_rooms').doc(roomId).update({
        'name': newName,
      });
    } catch (e) {
      print('Error updating conversation name: $e');
      rethrow;
    }
  }

  static Future<String> createChatRoom(String roomName) async {
    try {
      // Get the current date (without time) in a consistent format
      DateTime now = DateTime.now();
      DateTime startOfDay = DateTime(now.year, now.month, now.day);

      // Query the chat_rooms collection to find a room created on the current day
      QuerySnapshot querySnapshot = await firestore
          .collection('chat_rooms')
          .where('name', isEqualTo: roomName)
          .where('createdAt',
              isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
          .get();

      // If a chat room exists for today, return its ID
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      }

      // If no room found for today, create a new one
      DocumentReference docRef = await firestore.collection('chat_rooms').add({
        'name': roomName,
        'participants': [auth.currentUser?.email],
        'createdAt': FieldValue.serverTimestamp(),
        'selected_documents': [],
      });

      return docRef.id;
    } catch (e) {
      throw Exception('Error creating conversation: ${e.toString()}');
    }
  }

  static Future<void> uploadDocument(BuildContext context) async {
    if (auth.currentUser == null) {
      CommonMethod.getXSnackBar(
        'Error',
        'User not logged in',
      );
      return;
    }

    FilePickerResult? result;
    try {
      if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
        result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'], // Allow only PDF files
        );
      } else {
        // For web platform
        html.FileUploadInputElement uploadInput = html.FileUploadInputElement()
          ..accept = '.pdf'; // Accept only PDF files
        uploadInput.click();
        await uploadInput.onChange.first;

        if (uploadInput.files!.isEmpty) return;

        final html.File file = uploadInput.files!.first;
        final reader = html.FileReader();
        reader.readAsArrayBuffer(file);
        await reader.onLoad.first;

        result = FilePickerResult([
          PlatformFile(
            name: file.name,
            size: file.size!.toInt(),
            bytes: reader.result as Uint8List?,
          ),
        ]);
      }

      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.first;
        String fileName = file.name;
        String fileId = Uuid().v4();

        // Add document entry to Firestore with "Processing" status
        await FirebaseFirestore.instance
            .collection('documents')
            .doc(fileId)
            .set({
          'name': fileName,
          'uploaded_by': auth.currentUser?.email ?? 'Unknown',
          'size': file.size.toDouble(), // Store size as double
          'upload_status': 'Processing',
          'timestamp': FieldValue.serverTimestamp(),
        });
        final storageRef =
            FirebaseStorage.instance.ref('documents/$fileId.pdf');
        UploadTask uploadTask = storageRef.putData(file.bytes!);

        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();

        // Update the document entry with the completed status
        await FirebaseFirestore.instance
            .collection('documents')
            .doc(fileId)
            .update({
          'url': downloadUrl,
          'upload_status': 'Completed',
          'timestamp':
              FieldValue.serverTimestamp(), // Update timestamp if needed
        });

        await _extractTextFromPDF(
          context: context,
          downloadUrl: downloadUrl,
          fileName: fileName,
          fileSize: file.size.toDouble(), // Use double for file size
          fileId: fileId,
        );
      } else {
        CommonMethod.getXSnackBar('Error', 'No file selected');
      }
    } catch (e) {
      print('Error uploading file: $e');
      CommonMethod.getXSnackBar('Error', 'File upload failed');
    }
  }

  static String? extractedText;

  static Future<void> _extractTextFromPDF({
    required BuildContext context,
    required String downloadUrl,
    required String fileId,
    required String fileName,
    required double fileSize,
  }) async {
    print("Extracting text from PDF: $downloadUrl");

    // try {
    if (kIsWeb) {
      extractedText =
          await promiseToFuture<String>(extractTextFromPDF(downloadUrl));
    } else {
      FirebaseStorage storage = FirebaseStorage.instance;
      Uri uri = Uri.parse(downloadUrl);
      String path = uri.path.substring(1);
      Reference ref = storage.ref().child(path);
      final tempDir = await getTemporaryDirectory();
      final tempFilePath = '${tempDir.path}/temp.pdf';
      File tempFile = File(tempFilePath);
      await ref.writeToFile(tempFile);

      final doc = await PDFDoc.fromFile(tempFile);
      extractedText = await doc.text;

      print("----extractedText--->$extractedText");
    }

    await collectionDocuments.doc(fileId).update({
      'id': fileId,
      'name': fileName,
      'url': downloadUrl,
      'uploaded_by': CommonMethod.auth.currentUser?.email ?? 'Unknown',
      'size': fileSize,
      'upload_status': 'Completed',
      'extracted_text': extractedText,
      'timestamp': FieldValue.serverTimestamp(),
    });
    // } catch (e) {
    //   print('Error extracting text from PDF: $e');
    //   CommonMethod.getXSnackBar('Error', 'Error extracting text from PDF');
    // }
  }

  static Future<void> deleteDocumentAndFile(DocumentModel data) async {
    try {
      await collectionDocuments.doc(data.id).delete();
      if (data.url != null && data.url.isNotEmpty) {
        await FirebaseStorage.instance.ref(data.url).delete();
      }
      print('Document and associated file deleted successfully.');
    } catch (e) {
      print('Error deleting document or file: $e');
    }
  }
}
