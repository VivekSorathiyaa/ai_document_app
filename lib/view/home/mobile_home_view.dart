import 'package:ai_document_app/view/home/common/mobile_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/documents_controller.dart';
import '../../controllers/home_controller.dart';
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
  HomeController homeController;
  DocumentsController documentsController;
  MobileHomeView({
    super.key,
    required this.homeController,
    required this.documentsController,
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
      drawer: Drawer(
        elevation: 8,
        backgroundColor: bgBlackColor,
        child: SafeArea(
          child: DrawerWidget(
            homeController: homeController,
          ),
        ),
      ),
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 0) {
            _scaffoldKey.currentState?.openDrawer();
          }
        },
        child: Column(
          children: [
            Obx(() => homeController.selectedMenuModel.value.id == 0
                ? MobileChatHeaderWidget(
                    homeController: homeController,
                  )
                : homeController.selectedMenuModel.value.id == 1
                    ? DocumentsHeaderWidget(
                        documentsController: documentsController,
                      )
                    : const SizedBox()),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: bgBlackColor,
                    borderRadius: BorderRadius.circular(18)),
                child: Stack(alignment: Alignment.center, children: [
                  Obx(() => homeController.selectedMenuModel.value.id == 0 &&
                          homeController.chatRoomList.value.isNotEmpty
                      ? ChatBodyWidget(homeController: homeController)
                      : homeController.selectedMenuModel.value.id == 1
                          ? MobileDocumentsWidget(
                              documentsController: documentsController)
                          : NoDataWiget())
                ]),
              ),
            ),
            Obx(() => homeController.selectedMenuModel.value.id == 0
                ? ChatFooterWidget(homeController: homeController)
                : SizedBox()),
          ],
        ),
      ),
    );
  }
}
