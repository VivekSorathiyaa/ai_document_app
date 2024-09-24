import 'package:ai_document_app/view/widget/desktop_app_bar_widget.dart';
import 'package:ai_document_app/view/widget/desktop_menu_widget.dart';
import 'package:ai_document_app/view/widget/drawer_widget.dart';
import 'package:ai_document_app/view/widget/empty_chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../controllers/home_controller.dart';
import '../utils/color.dart';
import 'widget/chat_input_field_widget.dart';
import 'widget/chat_room_widget.dart';
import 'widget/mobile_app_bar_widget.dart';
import 'widget/mobile_menu_widget.dart';

class HomeView extends StatelessWidget {
  static const String name = 'home';
  final HomeController homeController = Get.put(HomeController());

  HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ResponsiveBreakpoints.of(context).isDesktop
            ? DeskTopHomeView(
                homeController: homeController, constraints: constraints)
            : SizedBox(
                height: 100,
                child: MobileHomeView(
                    homeController: homeController, constraints: constraints),
              );
      },
    );
  }
}

class MobileHomeView extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  HomeController homeController;
  BoxConstraints constraints;
  MobileHomeView({
    super.key,
    required this.homeController,
    required this.constraints,
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
                MobileMenuWidget(
                  homeController: homeController,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: bgBlackColor,
                        borderRadius: BorderRadius.circular(18)),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Obx(
                          () => homeController.chatRoomList.value.isEmpty
                              ? EmptyChatWidget()
                              : ChatRoomWidget(
                                  homeController: homeController,
                                ),
                        )
                      ],
                    ),
                  ),
                ),
                ChatInputFieldWidget(homeController: homeController),
              ],
            ),
          )),
    );
  }
}

class DeskTopHomeView extends StatelessWidget {
  HomeController homeController;
  BoxConstraints constraints;
  DeskTopHomeView({
    super.key,
    required this.homeController,
    required this.constraints,
  });
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
                shrinkWrap: true,
                slivers: [
                  SliverToBoxAdapter(
                    child: DesktopAppBarWidget(
                      homeController: homeController,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        // You can replace this with your actual data source
                        return Container(
                          margin: const EdgeInsets.only(top: 16),
                          decoration: BoxDecoration(
                            color: bgBlackColor,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: DeskTopMenuWidget(
                                    homeController: homeController),
                              ),
                              // List items
                              ListTile(
                                title: Text("Item ${index + 1}"),
                                onTap: () {},
                              ),
                            ],
                          ),
                        );
                      },
                      // childCount: 10, // Adjust this count as needed
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Container(
                      margin: const EdgeInsets.only(top: 16),
                      decoration: BoxDecoration(
                        color: bgBlackColor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        children: [
                          // const Spacer(),
                          // Obx(
                          //   () => homeController.chatRoomList.value.isEmpty
                          //       ? EmptyChatWidget()
                          //       : ChatRoomWidget(
                          //           homeController: homeController,
                          //         ),
                          // ),
                          // const Spacer(),
                          // ChatInputFieldWidget(homeController: homeController),
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
