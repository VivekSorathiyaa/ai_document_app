import 'dart:math';

import 'package:get/get.dart';

import '../model/user_model.dart';

class UserController extends GetxController {
  final RxList<UserModel> userDataList = <UserModel>[].obs;
  final RxInt rowsPerPage = 10.obs;
  final RxInt currentPage = 0.obs;

  RxList<String> accessLevels = [
    'Can View Only',
    'Editor',
    'Owner',
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
        permissions: index % 2 == 0 ? 'Admin' : 'Manager',
        access: _getRandomAccessLevel(),
      );
    }));
  }

  void updateAccessLevel(int userId, String newAccessLevel) {
    var user = paginatedData.firstWhere((user) => user.id == userId);
    user.access = newAccessLevel; // Assuming UserModel has an access field
    update(); // Notify listeners if needed
  }

  void paginateData() {
    final start = currentPage.value * rowsPerPage.value;
    final end = (start + rowsPerPage.value).clamp(0, userDataList.length);
    paginatedData.assignAll(userDataList.sublist(start, end));
  }

  String _getRandomAccessLevel() {
    // Define possible access levels

    // Randomly select an access level
    return accessLevels[Random().nextInt(accessLevels.length)];
  }

  // Sort the table data by column
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
    update();
  }

  List<UserModel> get paginatedData => userDataList
      .skip(currentPage.value * rowsPerPage.value)
      .take(rowsPerPage.value)
      .toList();
}
