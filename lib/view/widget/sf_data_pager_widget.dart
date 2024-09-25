import 'package:ai_document_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../controllers/documents_controller.dart';
import '../documents_view.dart';

class SfDataPagerWidget extends StatelessWidget {
  DocumentsController documentsController;
  SfDataPagerWidget({super.key, required this.documentsController});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryWhite,
      child: SfDataPager(
        pageCount: (documentsController.documentDataList.length /
                documentsController.rowsPerPage.value)
            .ceil()
            .toDouble(),
        delegate: TableDataSource(documentsController.paginatedData),
        onPageNavigationStart: (int pageIndex) {
          documentsController.currentPage.value = pageIndex;
        },
        availableRowsPerPage: <int>[15, 20, 25],
        onRowsPerPageChanged: (int? rowsPerPage) {
          documentsController.rowsPerPage.value = rowsPerPage!;
        },
      ),
    );
  }
}
