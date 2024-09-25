import 'package:ai_document_app/controllers/documents_controller.dart';
import 'package:ai_document_app/model/document_model.dart';
import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../utils/app_asset.dart';

class DocumentsView extends StatelessWidget {
  DocumentsController documentsController;
  DocumentsView({super.key, required this.documentsController});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
    return Obx(() {
      return Container(
        clipBehavior: Clip.antiAlias,
        height: 400,
        width: 700,
        decoration: BoxDecoration(
          border: Border.all(color: darkDividerColor, width: 2),
          borderRadius: BorderRadius.circular(8),
          color: tableHeaderColor,
        ),
        child: SfDataGrid(
          source: TableDataSource(documentsController.paginatedData),
          allowSorting: false,
          rowsPerPage: 15,
          headerGridLinesVisibility: GridLinesVisibility.none,
          gridLinesVisibility: GridLinesVisibility.none,
          columnWidthMode: ColumnWidthMode.fill,
          columns: <GridColumn>[
            GridColumn(
              allowSorting: true,
              columnName: 'Name',
              label: buildHeader(title: 'Name', context: context),
            ),
            GridColumn(
              allowSorting: true,
              columnName: 'Status',
              label: buildHeader(title: 'Status', context: context),
            ),
            GridColumn(
              allowSorting: true,
              columnName: 'Uploaded By',
              label: buildHeader(title: 'Uploaded By', context: context),
            ),
            GridColumn(
              allowSorting: true,
              columnName: 'Size',
              label: buildHeader(title: 'Size', context: context),
            ),
            GridColumn(
              allowSorting: true,
              columnName: 'Date',
              label: buildHeader(title: 'Date', context: context),
            ),
            GridColumn(
              allowSorting: false,
              columnName: 'Actions',
              label: buildHeader(title: 'Actions', context: context),
            ),
          ],
        ),
      );
    });
  }

  // Helper to build the column headers with sorting functionality
  Widget buildHeader({required String title, required BuildContext context}) {
    bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;

    return InkWell(
      onTap: () {
        final ascending =
            documentsController.paginatedData.first.status != 'Completed';
        documentsController.sortByColumn(title, ascending);
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: tableHeaderColor,
            border: Border.all(color: tableBorderColor, width: .5)),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Text(
                title,
                style: isDesktop
                    ? AppTextStyle.normalBold18
                    : AppTextStyle.normalBold12,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            )),
            if (title != "Actions")
              FittedBox(
                fit: BoxFit.scaleDown,
                child: SvgPicture.asset(
                  AppAsset.sort,
                  fit: BoxFit.scaleDown,
                  width: isDesktop ? 22 : 18,
                  height: isDesktop ? 22 : 18,
                  color: primaryWhite,
                ),
              )
          ],
        ),
      ),
    );
  }
}

/// Table data source for SfDataGrid
class TableDataSource extends DataGridSource {
  final List<DocumentModel> tableData;

  TableDataSource(this.tableData) {
    buildDataGridRows();
  }

  // List to hold the rows
  List<DataGridRow> _dataGridRows = [];

  // Method to build the rows
  void buildDataGridRows() {
    _dataGridRows = tableData
        .map((data) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'Name', value: data.name),
              DataGridCell<String>(columnName: 'Status', value: data.status),
              DataGridCell<String>(
                  columnName: 'Uploaded By', value: data.uploadedBy),
              DataGridCell<double>(columnName: 'Size', value: data.size),
              DataGridCell<String>(columnName: 'Date', value: data.date),
              DataGridCell<String>(columnName: 'Actions', value: data.actions),
            ]))
        .toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        return Container(

          decoration:
              BoxDecoration(    color: tableRowColor,border: Border.all(color: tableBorderColor, width: .5)),
          child: Center(
            child: Text(
              dataGridCell.value.toString(),
              overflow: TextOverflow.fade,
              style:
                  AppTextStyle.normalRegular12.copyWith(color: tableTextColor),
            ),
          ),
        );
      }).toList(),
    );
  }
}
