import 'package:ai_document_app/controllers/documents_controller.dart';
import 'package:ai_document_app/controllers/settings_controller.dart';
import 'package:ai_document_app/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../controllers/home_controller.dart';
import 'desktop_home_view.dart';
import 'mobile_home_view.dart';

class HomeView extends StatelessWidget {
  static const String name = 'home';
  final HomeController homeController = Get.put(HomeController());
  final DocumentsController documentsController =
      Get.put(DocumentsController());
  final UserController userController = Get.put(UserController());
  final SettingsController settingsController = Get.put(SettingsController());

  HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (settingsController.selectedSettingMenuModel.value != null) {
          settingsController.refreshSettingMenuModel(null);
        }
        return await false;
      },
      child: ResponsiveBreakpoints.of(context).isDesktop
          ? DeskTopHomeView(
              homeController: homeController,
              documentsController: documentsController,
              userController: userController,
              settingsController: settingsController,
            )
          : MobileHomeView(
              homeController: homeController,
              documentsController: documentsController,
              userController: userController,
              settingsController: settingsController),
    );
  }
}
