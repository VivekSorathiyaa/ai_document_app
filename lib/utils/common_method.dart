import 'dart:async';
import 'dart:io' as io;
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui';

import 'package:ai_document_app/main.dart';
import 'package:ai_document_app/utils/primary_text_button.dart';
import 'package:ai_document_app/view/auth/login_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../model/chat_model.dart';
import '../model/document_model.dart';
import '../utils/color.dart';
import 'app_text_style.dart';

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
          title: title != null
              ? Center(
                  child: Text(
                    title,
                    style: AppTextStyle.normalSemiBold20,
                  ),
                )
              : null,
          titlePadding: const EdgeInsets.all(12),
          insetPadding: const EdgeInsets.symmetric(horizontal: 15),
// contentPadding: EdgeInsets.zero,
          backgroundColor: bgContainColor,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),

          content: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                child,
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
              SelectableText(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Color for title text
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              SelectableText(
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
              child: const SelectableText(
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
            child: SelectableText(
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
                    title: "Cancel",
                    gradientColors: [bgBlackColor, bgBlackColor],
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: PrimaryTextButton(
                    title: "Logout",
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

  static Future<ChatModel> createChatRoom(String roomName) async {
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

      // If a chat room exists for today, return the corresponding ChatModel
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot existingDoc = querySnapshot.docs.first;
        return ChatModel.fromFirestore(existingDoc);
      }

      // If no room found for today, create a new one
      DocumentReference docRef = await firestore.collection('chat_rooms').add({
        'name': roomName,
        'participants': [auth.currentUser?.email],
        'createdAt': FieldValue.serverTimestamp(),
        'selected_documents': [],
      });

      // Fetch the newly created document to construct the ChatModel
      DocumentSnapshot newDoc = await docRef.get();
      return ChatModel.fromFirestore(newDoc);
    } catch (e) {
      throw Exception('Error creating chat room: ${e.toString()}');
    }
  }

  static Future<void> uploadDocument() async {
    if (auth.currentUser == null) {
      CommonMethod.getXSnackBar(
        'Error',
        'User not logged in',
      );
      return;
    }
    FilePickerResult? result;
    try {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.first;
        String fileName = file.name;
        String fileId = Uuid().v4();
        await FirebaseFirestore.instance
            .collection('documents')
            .doc(fileId)
            .set({
          'name': fileName,
          'uploaded_by': auth.currentUser?.email ?? 'Unknown',
          'size': file.size.toDouble(),
          'upload_status': 'Processing',
          'timestamp': FieldValue.serverTimestamp(),
        });
        final storageRef =
            FirebaseStorage.instance.ref('documents/$fileId.pdf');
        UploadTask uploadTask = storageRef.putData(file.bytes!);
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('documents')
            .doc(fileId)
            .update({
          'url': downloadUrl,
          'upload_status': 'Completed',
          'timestamp': FieldValue.serverTimestamp(),
        });

        await extractTextFromPDF(
          downloadUrl: downloadUrl,
          fileName: fileName,
          fileSize: file.size.toDouble(),
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

  static Future<String> extractTextFromPDF({
    required String downloadUrl,
    required String fileId,
    required String fileName,
    required double fileSize,
  }) async {
    try {
      print("Extracting text from downloadUrl: $downloadUrl");
      print("Extracting text from fileId: $fileId");
      print("Extracting text from fileName: $fileName");
      print("Extracting text from fileSize: $fileSize");

      final response = await Dio().get(
        downloadUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        Uint8List bytes = response.data;

        // Check if bytes are not empty
        if (bytes.isEmpty) {
          print('Downloaded bytes are empty.');
          return '';
        }

        // Create a PdfDocument from the downloaded bytes
        final PdfDocument document = PdfDocument(inputBytes: bytes);

        // Extract text from the PDF
        String content = PdfTextExtractor(document).extractText();

        // Dispose of the document to free resources
        document.dispose();

        // Check if the content is not empty before updating Firestore
        if (content.isNotEmpty) {
          // Update Firestore with the extracted content
          await collectionDocuments.doc(fileId).update({
            'id': fileId,
            'name': fileName,
            'url': downloadUrl,
            'uploaded_by': CommonMethod.auth.currentUser?.email ?? 'Unknown',
            'size': fileSize,
            'upload_status': 'Completed',
            'extracted_text': content,
            'timestamp': FieldValue.serverTimestamp(),
          });

          print("Extracted text: $content");
          return content;
        } else {
          print('No text extracted from the PDF.');
          return '';
        }
      } else {
        print('Failed to download PDF: ${response.statusCode}');
        return '';
      }
    } catch (e) {
      print('Error extracting text from PDF: $e');
      return '';
    }
  }

  static String formatBytes(double bytes, {int decimals = 2}) {
    const int kB = 1024;
    const int MB = kB * 1024;
    const int GB = MB * 1024;
    const int TB = GB * 1024;

    if (bytes < kB) {
      return '${bytes.toStringAsFixed(decimals)} B';
    } else if (bytes < MB) {
      return '${(bytes / kB).toStringAsFixed(decimals)} KB';
    } else if (bytes < GB) {
      return '${(bytes / MB).toStringAsFixed(decimals)} MB';
    } else if (bytes < TB) {
      return '${(bytes / GB).toStringAsFixed(decimals)} GB';
    } else {
      return '${(bytes / TB).toStringAsFixed(decimals)} TB';
    }
  }

  static String getFileSizeInMB(dynamic file) {
    if (file is PlatformFile) {
      // If it's a PlatformFile (web or mobile)
      if (file.bytes != null) {
        // Web file
        final sizeInBytes = file.size; // size is available in bytes for web
        return (sizeInBytes / (1024 * 1024))
            .toStringAsFixed(2); // Convert to MB
      } else if (file.path != null) {
        // Mobile/Desktop file
        final nativeFile = io.File(file.path!);
        return (nativeFile.lengthSync() / (1024 * 1024))
            .toStringAsFixed(2); // Convert to MB
      }
    } else if (file is io.File) {
      // If it's a native file (mobile/Desktop)
      return (file.lengthSync() / (1024 * 1024))
          .toStringAsFixed(2); // Convert to MB
    }

    return "0.00"; // Default value if file is invalid
  }

  static String getFileName(dynamic file) {
    if (file is PlatformFile) {
      // For PlatformFile (web or mobile)
      return file.name; // Directly return the file name
    } else if (file is io.File) {
      // For mobile applications
      return file.path.split('/').last; // Extract file name from path
      // } else if (file is html.File) {
      //   // For web applications
      //   return file.name; // Get file name
    } else {
      return "Unknown"; // Default value if file type is unsupported
    }
  }

  /// Get the file size from a dynamic file input.
  static int getFileSize(dynamic file) {
    if (file is PlatformFile) {
      // For PlatformFile (web or mobile)
      return file.size; // Get file size
    } else if (file is io.File) {
      // For mobile applications
      return file.lengthSync(); // Get file size
      // } else if (file is html.File) {
      //   // For web applications
      //   return file.size; // Get file size
    } else {
      return 0; // Default value if file type is unsupported
    }
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

  static Future<void> viewDocument(String url) async {
    print("Attempting to view document: $url");
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print("Error opening document: $e");
    }
  }

  static String formatDate(DateTime? date) {
    try {
      if (date == null) {
        return '';
      }
      return DateFormat('d MMM, yyyy').format(date); // Short month format
    } catch (e) {
      // Return a default message or handle the error accordingly
      return '';
    }
  }
}
