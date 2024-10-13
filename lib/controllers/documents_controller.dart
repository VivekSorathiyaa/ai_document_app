import 'package:ai_document_app/utils/common_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/document_model.dart';

class DocumentsController extends GetxController {
  final RxList<DocumentModel> documentDataList = <DocumentModel>[].obs;
  final RxInt rowsPerPage = 10.obs;
  final RxInt currentPage = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDocuments();
  }

  void fetchDocuments() {
    FirebaseFirestore.instance
        .collection('documents')
        .where('uploaded_by', isEqualTo: CommonMethod.auth.currentUser?.email)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      documentDataList.assignAll(snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return DocumentModel(
          id: doc.id,
          name: data['name'] ?? '',
          url: data['url'] ?? '',
          status: data['upload_status'] ?? 'Unknown',
          uploadedBy: data['uploaded_by'] ?? '',
          size: data['size']?.toDouble() ?? 0.0,
          date: data['timestamp']?.toDate().toString() ??
              '', // Adjust date format as needed
          actions: 'Action ${doc.id}', // Or set this based on your needs
        );
      }).toList());
    });
  }

  void paginateData() {
    final start = currentPage.value * rowsPerPage.value;
    final end = (start + rowsPerPage.value).clamp(0, documentDataList.length);
    paginatedData.assignAll(documentDataList.sublist(start, end));
  }

  void sortByColumn(String columnName, bool ascending) {
    documentDataList.sort((a, b) {
      switch (columnName) {
        case 'Name':
          return ascending
              ? a.name.compareTo(b.name)
              : b.name.compareTo(a.name);
        case 'Status':
          return ascending
              ? a.status.compareTo(b.status)
              : b.status.compareTo(a.status);
        case 'Uploaded By':
          return ascending
              ? a.uploadedBy.compareTo(b.uploadedBy)
              : b.uploadedBy.compareTo(a.uploadedBy);
        case 'Size':
          return ascending
              ? a.size.compareTo(b.size)
              : b.size.compareTo(a.size);
        case 'Date':
          return ascending
              ? a.date.compareTo(b.date)
              : b.date.compareTo(a.date);
        default:
          return 0;
      }
    });
    update();
  }

  List<DocumentModel> get paginatedData => documentDataList
      .skip(currentPage.value * rowsPerPage.value)
      .take(rowsPerPage.value)
      .toList();
}
