import 'package:ai_document_app/controllers/documents_controller.dart';
import 'package:ai_document_app/view/documents_view.dart';
import 'package:ai_document_app/view/widget/desktop_app_bar_widget.dart';
import 'package:ai_document_app/view/widget/drawer_widget.dart';
import 'package:ai_document_app/view/widget/empty_chat_widget.dart';
import 'package:ai_document_app/view/widget/sf_data_pager_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../controllers/home_controller.dart';
import '../utils/color.dart';
import 'widget/chat_input_field_widget.dart';
import 'widget/chat_room_widget.dart';
import 'widget/desktop_menu_widget.dart';
import 'widget/mobile_app_bar_widget.dart';

class HomeView extends StatelessWidget {
  static const String name = 'home';
  final HomeController homeController = Get.put(HomeController());
  final DocumentsController documentsController =
      Get.put(DocumentsController());

  HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.of(context).isDesktop
        ? DeskTopHomeView(
            homeController: homeController,
          )
        : MobileHomeView(
            homeController: homeController,
            documentsController: documentsController,
          );
  }
}

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
          child: Container(
              color: primaryBlack,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DocumentsView(
                          documentsController: documentsController),
                    ),
                  ),
                  SfDataPagerWidget(documentsController: documentsController)
                ],
              )

              //
              // Column(
              //   children: [
              //     MobileMenuWidget(
              //       homeController: homeController,
              //     ),
              //     Expanded(
              //       child: Container(
              //         decoration: BoxDecoration(
              //             color: bgBlackColor,
              //             borderRadius: BorderRadius.circular(18)),
              //         child: Stack(
              //           alignment: Alignment.center,
              //           children: [
              //             Obx(() => homeController.chatRoomList.value.isEmpty
              //                 ? EmptyChatWidget()
              //                 : ChatRoomWidget(
              //                     homeController: homeController,
              //                   ))
              //           ],
              //         ),
              //       ),
              //     ),
              //     ChatInputFieldWidget(homeController: homeController),
              //   ],
              // ),
              )),
    );
  }
}

class DeskTopHomeView extends StatelessWidget {
  HomeController homeController;
  DeskTopHomeView({
    Key? key,
    required this.homeController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlack,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            if (ResponsiveBreakpoints.of(context).isDesktop)
              DrawerWidget(homeController: homeController),
            Expanded(
              child: CustomScrollView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                slivers: [
                  SliverAppBar(
                    elevation: 0,
                    pinned: true,
                    floating: false,
                    snap: false,
                    stretch: true,
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.transparent,
                    expandedHeight: 70,
                    flexibleSpace: FlexibleSpaceBar(
                        background: DesktopAppBarWidget(
                      homeController: homeController,
                    )),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: true,
                    child: Container(
                      margin: const EdgeInsets.only(top: 16),
                      decoration: BoxDecoration(
                        color: bgBlackColor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: DeskTopMenuWidget(
                                  homeController: homeController),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                  color: bgContainColor,
                                  border: Border.all(color: darkDividerColor),
                                  borderRadius: BorderRadius.circular(9)),
                              child: Center(
                                child: Obx(
                                  () =>
                                      homeController.chatRoomList.value.isEmpty
                                          ? EmptyChatWidget()
                                          : ChatRoomWidget(
                                              homeController: homeController,
                                            ),
                                ),
                              ),
                            ),
                          ),
                          ChatInputFieldWidget(
                            homeController: homeController,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
