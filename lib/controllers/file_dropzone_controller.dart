import 'dart:io' as io; // Import for native File

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../utils/common_method.dart';

class FileDropzoneController extends GetxController {
  late DropzoneViewController dropzoneController;

  // Reactive variables
  var isHighlighted = false.obs;
  var isUploading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;
  var selectedFiles = <PlatformFile>[].obs;
  var uploadProgress = <String, RxDouble>{}.obs;

  final List<String> allowedFormats;
  int maxSize; // in bytes
  int maxFiles;

  FileDropzoneController({
    required this.allowedFormats,
    required this.maxSize,
    required this.maxFiles,
  });

  void removeFile(String fileName) {
    selectedFiles.removeWhere((file) => file.name == fileName);
    uploadProgress.remove(fileName);
    isUploading.value = false;
  }

  void resetError() {
    isError.value = false;
    errorMessage.value = '';
  }

  Future<void> uploadDocument(
    dynamic file, // Accept dynamic type to handle both File and PlatformFile
    String fileName,
  ) async {
    // Check if the user is logged in
    if (CommonMethod.auth.currentUser == null) {
      CommonMethod.getXSnackBar(
        'Error',
        'User not logged in',
      );
      return;
    }

    try {
      isUploading.value = true;

      String fileId = Uuid().v4();
      await FirebaseFirestore.instance.collection('documents').doc(fileId).set({
        'name': fileName,
        'uploaded_by': CommonMethod.auth.currentUser?.email ?? 'Unknown',
        'size': CommonMethod.getFileSize(file).toDouble(),
        'upload_status': 'Processing',
        'timestamp': FieldValue.serverTimestamp(),
      });

      final storageRef = FirebaseStorage.instance.ref('documents/$fileId.pdf');

      // Initialize the upload task based on the file type
      UploadTask uploadTask;

      if (file is io.File) {
        // For mobile applications (native files)
        uploadTask = storageRef.putFile(file);
      } else if (file is PlatformFile) {
        // For web applications
        uploadTask = storageRef.putData(file.bytes!);
      } else {
        throw Exception(
            'Unsupported file type'); // Handle unsupported file types
      }

      // Track upload progress
      uploadProgress[fileName] = 0.0.obs;
      uploadTask.snapshotEvents.listen((event) {
        if (event.totalBytes > 0) {
          final progress = (event.bytesTransferred / event.totalBytes) * 100;
          uploadProgress[fileName]?.value = progress; // Update progress
        }
      });

      // Wait for the upload to complete
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Update Firestore document with the download URL and upload status
      await FirebaseFirestore.instance
          .collection('documents')
          .doc(fileId)
          .update({
        'url': downloadUrl,
        'upload_status': 'Completed',
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Optionally, extract text from the PDF after the upload is complete
      await CommonMethod.extractTextFromPDF(
        downloadUrl: downloadUrl,
        fileName: fileName,
        fileSize: CommonMethod.getFileSize(file).toDouble(),
        fileId: fileId,
      );
    } catch (e) {
      print('Error uploading file: $e');
      CommonMethod.getXSnackBar('Error', 'File upload failed');
    } finally {
      isUploading.value = false; // Reset upload status
    }
  }

  // Future<void> uploadFile(
  //     File file, String fileName, Function(String) onFileUploaded) async {
  //   // Check if the user is logged in
  //   if (CommonMethod.auth.currentUser == null) {
  //     CommonMethod.getXSnackBar(
  //       'Error',
  //       'User not logged in',
  //     );
  //     return;
  //   }
  //
  //   isUploading.value = true;
  //   String fileId = Uuid().v4(); // Generate a unique file ID
  //
  //   // Prepare the document data to be uploaded to Firestore
  //   final documentData = {
  //     'name': fileName,
  //     'uploaded_by': CommonMethod.auth.currentUser?.email ?? 'Unknown',
  //     'size': CommonMethod.getFileSize(file).toDouble(),
  //     'upload_status': 'Processing',
  //     'timestamp': FieldValue.serverTimestamp(),
  //   };
  //
  //   // Upload document information to Firestore
  //   await FirebaseFirestore.instance
  //       .collection('documents')
  //       .doc(fileId)
  //       .set(documentData);
  //
  //   final storageRef = FirebaseStorage.instance.ref('documents/$fileId.pdf');
  //
  //   try {
  //     // Initialize the upload task
  //     UploadTask uploadTask = kIsWeb
  //         ? storageRef.putBlob(file) // For web
  //         : storageRef.putFile(io.File(file.path!)); // For mobile
  //
  //     // Initialize the upload progress observable
  //     uploadProgress[fileName] = 0.0.obs;
  //
  //     // Listen to upload progress
  //     uploadTask.snapshotEvents.listen((event) {
  //       if (event.totalBytes > 0) {
  //         final progress = (event.bytesTransferred / event.totalBytes) * 100;
  //         uploadProgress[fileName]?.value = progress; // Update progress
  //       }
  //     });
  //
  //     // Wait for the upload to complete
  //     TaskSnapshot snapshot = await uploadTask;
  //     String downloadUrl = await snapshot.ref.getDownloadURL();
  //
  //     // Update Firestore document with the download URL and upload status
  //     await CommonMethod.collectionDocuments.doc(fileId).update({
  //       'url': downloadUrl,
  //       'upload_status': 'Completed',
  //       'timestamp': FieldValue.serverTimestamp(),
  //     });
  //
  //     // Extract text from the PDF after the upload is complete
  //     await CommonMethod.extractTextFromPDF(
  //       downloadUrl: downloadUrl,
  //       fileName: fileName,
  //       fileSize: CommonMethod.getFileSize(file).toDouble(),
  //       fileId: fileId,
  //     );
  //
  //     // Call the callback with the download URL
  //     onFileUploaded(downloadUrl);
  //   } catch (e) {
  //     // Handle specific error types if necessary
  //     isError.value = true;
  //     errorMessage.value = 'Error uploading file: ${e.toString()}';
  //   } finally {
  //     // Ensure uploading state is reset
  //     isUploading.value = false;
  //   }
  // }

  Future<void> browseFiles(Function(String) onFileUploaded) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedFormats,
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        // Immediately update the selected files

        isUploading.value = true;

        selectedFiles.assignAll(result.files);

        // Upload files concurrently using Futures
        List<Future<void>> uploadFutures = result.files.map((file) async {
          if (_validateFile(file)) {
            await uploadDocument(file, file.name);
          }
        }).toList();

        // Await all uploads to complete
        await Future.wait(uploadFutures);
      }
    } catch (e) {
      isError.value = true;
      errorMessage.value = e.toString();
    }
  }

  bool _validateFile(PlatformFile file) {
    // Check file size
    if (file.size > maxSize) {
      isError.value = true;
      errorMessage.value =
          'File ${file.name} exceeds the limit of ${maxSize ~/ (1024 * 1024)} MB';
      return false;
    }

    // Check file format
    final fileName = file.name;
    if (!allowedFormats.any((format) => fileName.endsWith(format))) {
      isError.value = true;
      errorMessage.value = 'File ${file.name} has an invalid format.';
      return false;
    }

    return true; // File is valid
  }
}
