import 'package:ai_document_app/controllers/documents_controller.dart';
import 'package:ai_document_app/model/document_model.dart';
import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/color.dart';
import 'package:ai_document_app/utils/static_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../utils/app_asset.dart';

class DesktopDocumentsWidget extends StatelessWidget {
  DocumentsController documentsController;

  DesktopDocumentsWidget({super.key, required this.documentsController});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ClipRRect(
        borderRadius: BorderRadius.circular(9),
        child: SfDataGrid(
          source: TableDataSource(documentsController.paginatedData),
          allowSorting: false,
          rowsPerPage: 10,
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
              columnName: 'Status',
              label: buildHeader(title: 'Status', context: context),
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

  Widget buildHeader({required String title, required BuildContext context}) {
    return InkWell(
      onTap: () {
        final ascending =
            documentsController.paginatedData.first.status != 'Completed';
        documentsController.sortByColumn(title, ascending);
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: tableHeaderColor,
          borderRadius: title == "Name"
              ? const BorderRadius.only(topLeft: Radius.circular(9))
              : title == "Actions"
                  ? const BorderRadius.only(topRight: Radius.circular(9))
                  : null,
          border: Border.all(color: tableBorderColor, width: 0.5),
        ),
        alignment: Alignment.centerLeft,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    title,
                    style: AppTextStyle.normalBold14,
                    overflow:
                        TextOverflow.ellipsis, // Use ellipsis for overflow
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
              ),
              if (title != "Actions")
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: SvgPicture.asset(
                    AppAsset.sort,
                    width: 22,
                    height: 22,
                    color: primaryWhite,
                  ),
                ),
            ],
          ),
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
              DataGridCell<String>(
                  columnName: 'Uploaded By', value: data.uploadedBy),
              DataGridCell<double>(columnName: 'Size', value: data.size),
              DataGridCell<String>(columnName: 'Status', value: data.status),
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
        switch (dataGridCell.columnName) {
          case 'Name':
            return _buildNameCell(dataGridCell);
          case 'Status':
            return _buildStatusCell(dataGridCell);
          case 'Uploaded By':
            return _buildUploadedByCell(dataGridCell);
          case 'Size':
            return _buildSizeCell(dataGridCell);
          case 'Date':
            return _buildDateCell(dataGridCell);
          case 'Actions':
            return _buildActionsCell(dataGridCell, row);
          default:
            return _buildDefaultCell(dataGridCell);
        }
      }).toList(),
    );
  }

  Widget _buildNameCell(DataGridCell cell) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: tableRowColor,
        border: Border.all(color: tableBorderColor, width: 0.5),
      ),
      child: Center(
        child: Text(
          cell.value,
          style: AppTextStyle.normalRegular14.copyWith(color: tableTextColor),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildStatusCell(DataGridCell cell) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: tableRowColor,
        border: Border.all(color: tableBorderColor, width: 0.5),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 107,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: tableButtonColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16),
            child: Center(
              child: Text(
                cell.value,
                style: AppTextStyle.normalRegular14
                    .copyWith(color: tableTextColor),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadedByCell(DataGridCell cell) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: tableRowColor,
        border: Border.all(color: tableBorderColor, width: 0.5),
      ),
      child: Center(
        child: Text(
          cell.value,
          style: AppTextStyle.normalRegular14.copyWith(color: tableTextColor),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildSizeCell(DataGridCell cell) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: tableRowColor,
        border: Border.all(color: tableBorderColor, width: 0.5),
      ),
      child: Center(
        child: Text(
          '${cell.value.toStringAsFixed(2)} MB',
          style: AppTextStyle.normalRegular12.copyWith(color: tableTextColor),
        ),
      ),
    );
  }

  Widget _buildDateCell(DataGridCell cell) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: tableRowColor,
        border: Border.all(color: tableBorderColor, width: 0.5),
      ),
      child: Center(
        child: Text(
          cell.value,
          style: AppTextStyle.normalRegular14.copyWith(color: tableTextColor),
          maxLines: 1,
          overflow: TextOverflow.clip,
        ),
      ),
    );
  }

  Widget _buildActionsCell(DataGridCell cell, DataGridRow row) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: tableRowColor,
        border: Border.all(color: tableBorderColor, width: 0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: tableButtonColor),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    AppAsset.delete,
                    height: 24,
                    width: 24,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
          ),
          customWidth(12),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: tableButtonColor),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    AppAsset.reset,
                    height: 24,
                    width: 24,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultCell(DataGridCell cell) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: tableRowColor,
        border: Border.all(color: tableBorderColor, width: 0.5),
      ),
      child: Center(
        child: Text(
          cell.value.toString(),
          style: AppTextStyle.normalRegular14.copyWith(color: tableTextColor),
          overflow: TextOverflow.fade,
        ),
      ),
    );
  }
}
