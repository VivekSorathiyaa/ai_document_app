import 'package:get/get.dart';

import '../model/document_model.dart';

class DocumentsController extends GetxController {
  final RxList<DocumentModel> documentDataList = <DocumentModel>[].obs;
  final RxInt rowsPerPage = 15.obs;
  final RxInt currentPage = 0.obs;

  DocumentsController() {
    // Dummy data
    documentDataList.addAll(List.generate(100, (index) {
      return DocumentModel(
        status: index % 2 == 0 ? 'Completed' : 'Pending',
        uploadedBy: 'User $index',
        size: (index + 10) * 1.5,
        date: '2024-09-${index % 30 + 1}',
        actions: 'Action $index',
        id: index.toString(),
        name: 'Document $index',
      );
    }));
  }

  // Sort the table data by column
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

  // Paginated data
  List<DocumentModel> get paginatedData => documentDataList
      .skip(currentPage.value * rowsPerPage.value)
      .take(rowsPerPage.value)
      .toList();
}
