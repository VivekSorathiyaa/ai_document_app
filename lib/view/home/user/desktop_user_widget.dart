import 'package:ai_document_app/controllers/user_controller.dart';
import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../model/user_model.dart';
import '../../../utils/app_asset.dart';
import '../../../utils/static_decoration.dart';

class DesktopUserWidget extends StatelessWidget {
  final UserController userController;

  const DesktopUserWidget({super.key, required this.userController});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ClipRRect(
        borderRadius: BorderRadius.circular(9),
        child: SfDataGrid(
          source: TableDataSource(userController.paginatedData),
          allowSorting: false,
          rowsPerPage: 10,
          headerGridLinesVisibility: GridLinesVisibility.none,
          gridLinesVisibility: GridLinesVisibility.none,
          columnWidthMode: ColumnWidthMode.fill,
          columns: <GridColumn>[
            GridColumn(
              allowSorting: true,
              columnName: 'Name',
              label: buildHeader(title: 'Full Name', context: context),
            ),
            GridColumn(
              allowSorting: true,
              columnName: 'Email',
              label: buildHeader(title: 'Email', context: context),
            ),
            GridColumn(
              allowSorting: true,
              columnName: 'Permissions',
              label: buildHeader(title: 'Permissions', context: context),
            ),
            GridColumn(
              allowSorting: true,
              columnName: 'Date',
              label: buildHeader(title: 'Date', context: context),
            ),
            GridColumn(
              allowSorting: true,
              columnName: 'Access',
              label: buildHeader(title: 'Access', context: context),
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
            userController.paginatedData.first.permissions != 'Admin';
        userController.sortByColumn(title, ascending);
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: tableHeaderColor,
          borderRadius: title == "Name"
              ? BorderRadius.only(topLeft: Radius.circular(9))
              : title == "Actions"
                  ? BorderRadius.only(topRight: Radius.circular(9))
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

class TableDataSource extends DataGridSource {
  final List<UserModel> tableData;

  TableDataSource(this.tableData) {
    buildDataGridRows();
  }

  List<DataGridRow> _dataGridRows = [];

  void buildDataGridRows() {
    _dataGridRows = tableData
        .map((data) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'Name', value: data.name),
              DataGridCell<String>(columnName: 'Email', value: data.email),
              DataGridCell<String>(
                  columnName: 'Permissions', value: data.permissions),
              DataGridCell<String>(columnName: 'Date', value: data.date),
              DataGridCell<String>(columnName: 'Access', value: data.access),
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
          case 'Email':
            return _buildNameCell(dataGridCell);
          case 'Permissions':
            return _buildPermisionCell(dataGridCell);
          case 'Date':
            return _buildDateCell(dataGridCell);
          case 'Access':
            return _buildAcccessCell(dataGridCell, row);
          case 'Actions':
            return _buildActionsCell(dataGridCell, row);
          default:
            return _buildNameCell(dataGridCell);
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
        ),
      ),
    );
  }

  Widget _buildPermisionCell(DataGridCell cell) {
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

  Widget _buildAcccessCell(DataGridCell cell, DataGridRow row) {
    var controller = Get.put(UserController());
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: tableRowColor,
        border: Border.all(color: tableBorderColor, width: 0.5),
      ),
      child: Center(
        child: DropdownButton<String>(
          value: cell.value, // Current access level
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          style: AppTextStyle.normalRegular14.copyWith(color: tableTextColor),
          underline: Container(
            height: 2,
            color: Colors.grey,
          ),
          onChanged: (String? newValue) {
            // Update the access level in the user model
            int index = row
                .getCells()[0]
                .value; // Assuming the first cell contains the unique identifier
            if (newValue != null) {
              controller.updateAccessLevel(
                  index, newValue); // Implement this method in your controller
            }
          },
          items: controller.accessLevels.value
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
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
}