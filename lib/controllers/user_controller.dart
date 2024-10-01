import 'dart:math';

import 'package:ai_document_app/utils/custom_dropdown_widget.dart';
import 'package:ai_document_app/utils/static_decoration.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:get/get.dart';

import '../model/user_model.dart';
import '../utils/filter_dialog.dart';

class UserController extends GetxController {
  final RxList<UserModel> userDataList = <UserModel>[].obs;
  final RxInt rowsPerPage = 10.obs;
  final RxInt currentPage = 0.obs;
  final RxList<String> accessLevels = [
    'Can View Only',
    'Editor',
    'Owner',
  ].obs;

  final RxList<String> permissionList = [
    'Admin',
    'Manager',
  ].obs;

  UserController() {
    // Dummy data
    userDataList.addAll(List.generate(100, (index) {
      return UserModel(
        date: '31 July 2022',
        actions: 'Action $index',
        id: index.toString(),
        name: 'Yuvraj Rathod',
        email: 'yuvrajrathod@gmail.com',
        permissions: permissionList.value[index % 2],
        access: _getRandomAccessLevel(),
      );
    }));
  }

  void updateAccessLevel(String userId, String newAccessLevel) {
    // Find the user by ID
    var user = userDataList.firstWhereOrNull((user) => user.id == userId);
    if (user != null) {
      user.access = newAccessLevel; // Update the access field
      print(
          "Access level updated for user ${user.name} with ID $userId to $newAccessLevel");
      userDataList.refresh();
    } else {
      print("User not found with ID: $userId"); // Log error if user not found
    }
    paginateData(); // Refresh paginated data after update
  }

  void updatePermission(String userId) {
    // Find the user by ID
    var user = userDataList.firstWhereOrNull((user) => user.id == userId);
    if (user != null) {
      // Toggle permission
      user.permissions = user.permissions == 'Admin' ? 'Manager' : 'Admin';
      print(
          "Access permission for user ${user.name} with ID $userId changed to ${user.permissions}");
      userDataList.refresh();
    } else {
      print("User not found with ID: $userId"); // Log error if user not found
    }
    paginateData(); // Refresh paginated data after update
  }

  void paginateData() {
    final start = currentPage.value * rowsPerPage.value;
    final end = (start + rowsPerPage.value).clamp(0, userDataList.length);
    paginatedData.assignAll(userDataList.sublist(start, end));
  }

  String _getRandomAccessLevel() {
    return accessLevels[Random().nextInt(accessLevels.length)];
  }

  void sortByColumn(String columnName, bool ascending) {
    userDataList.sort((a, b) {
      switch (columnName) {
        case 'Name':
          return ascending
              ? a.name.compareTo(b.name)
              : b.name.compareTo(a.name);
        case 'Email':
          return ascending
              ? a.email.compareTo(b.email)
              : b.email.compareTo(a.email);
        case 'Permissions':
          return ascending
              ? a.permissions.compareTo(b.permissions)
              : b.permissions.compareTo(a.permissions);
        case 'Date':
          return ascending
              ? a.date.compareTo(b.date)
              : b.date.compareTo(a.date);
        default:
          return 0;
      }
    });
    currentPage.value = 0; // Reset to first page after sorting
    paginateData(); // Refresh paginated data
  }

  List<UserModel> get paginatedData => userDataList
      .skip(currentPage.value * rowsPerPage.value)
      .take(rowsPerPage.value)
      .toList();

  void showFilterDialog() {
    Get.dialog(
      FilterDialog(
        title: 'Select Filters',
        filterOptions: [
          height20,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomDropdown(
              hintText: "Joined ",
              onChanged: (value) {},
              items: const [
                'Joined Today',
                'Joined This Week',
                'Joined This Month',
                'Joined This Year',
                'Joined Last Month',
                'Joined Last Year',
                'Joined Over a Year Ago'
              ],
            ),
          ),
          height20,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomDropdown(
                hintText: "Permission ",
                onChanged: (value) {},
                items: accessLevels.value),
          ),
          height20,
        ],
        onApplyFilters: (selectedFilters) {
          print('Selected Filters: $selectedFilters');
        },
      ),
    );
  }
}
