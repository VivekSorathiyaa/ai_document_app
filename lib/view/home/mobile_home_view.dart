import 'package:ai_document_app/controllers/settings_controller.dart';
import 'package:ai_document_app/view/home/common/mobile_app_bar_widget.dart';
import 'package:ai_document_app/view/home/settings/settings_header_widget.dart';
import 'package:ai_document_app/view/home/settings/settings_widget.dart';
import 'package:ai_document_app/view/home/user/mobile_user_widget.dart';
import 'package:ai_document_app/view/home/user/user_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/documents_controller.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/user_controller.dart';
import '../../utils/color.dart';
import 'chat/chat_body_widget.dart';
import 'chat/chat_footer_widget.dart';
import 'chat/mobile_chat_header_widget.dart';
import 'common/drawer_widget.dart';
import 'common/no_data_widget.dart';
import 'documents/documents_header_widget.dart';
import 'documents/mobile_documents_widget.dart';

class MobileHomeView extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final HomeController homeController;
  final DocumentsController documentsController;
  final UserController userController;
  final SettingsController settingsController;

  MobileHomeView({
    super.key,
    required this.homeController,
    required this.documentsController,
    required this.userController,
    required this.settingsController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: primaryBlack,
      appBar: MobileAppBarWidget(
        homeController: homeController,
        onMenuTap: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      drawer: _buildDrawer(),
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 0) {
            _scaffoldKey.currentState?.openDrawer();
          }
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
              child: _buildHeader(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: _buildBody(),
              ),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      elevation: 8,
      backgroundColor: bgBlackColor,
      child: SafeArea(
        child: DrawerWidget(
          homeController: homeController,
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Obx(() {
      switch (homeController.selectedMenuModel.value.id) {
        case 0:
          return MobileChatHeaderWidget(homeController: homeController);
        case 1:
          return DocumentsHeaderWidget(
              documentsController: documentsController);
        case 2:
          return UserHeaderWidget(userController: userController);
        case 3:
          return SettingsHeaderWidget(settingsController: settingsController);

        default:
          return const SizedBox();
      }
    });
  }

  Widget _buildBody() {
    return Container(
      // decoration: BoxDecoration(
      //   color: bgBlackColor,
      //   borderRadius: BorderRadius.circular(18),
      // ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Obx(() {
            switch (homeController.selectedMenuModel.value.id) {
              case 0:
                return homeController.chatRoomList.value.isNotEmpty
                    ? ChatBodyWidget(homeController: homeController)
                    : NoDataWiget();
              case 1:
                return MobileDocumentsWidget(
                    documentsController: documentsController);
              case 2:
                return MobileUserWidget(userController: userController);
              case 3:
                return SettingsWidget(settingsController: settingsController);
              default:
                return NoDataWiget();
            }
          }),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Obx(() {
      if (homeController.selectedMenuModel.value.id == 0) {
        return ChatFooterWidget(homeController: homeController);
      }
      return const SizedBox();
    });
  }
}
