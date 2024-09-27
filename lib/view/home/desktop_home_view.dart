import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../controllers/documents_controller.dart';
import '../../controllers/home_controller.dart';
import '../../utils/color.dart';
import 'chat/chat_body_widget.dart';
import 'chat/desktop_chat_header_widget.dart';
import 'common/drawer_widget.dart';
import 'common/no_data_widget.dart';
import 'documents/desktop_documents_widget.dart';
import 'documents/documents_header_widget.dart';

class DeskTopHomeView extends StatelessWidget {
  HomeController homeController;
  DocumentsController documentsController;
  DeskTopHomeView({
    Key? key,
    required this.homeController,
    required this.documentsController,
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
                  // SliverAppBar(
                  //   elevation: 0,
                  //   // pinned: true,
                  //   // floating: false,
                  //   // snap: false,
                  //   // stretch: true,
                  //   automaticallyImplyLeading: false,
                  //   backgroundColor: Colors.transparent,
                  //   expandedHeight: 70,
                  //   flexibleSpace: FlexibleSpaceBar(
                  //       background: DesktopAppBarWidget(
                  //     homeController: homeController,
                  //   )),
                  // ),
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
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            child: Obx(
                              () => homeController.selectedMenuModel.value.id ==
                                      0
                                  ? DesktopChatHeaderWidget(
                                      homeController: homeController)
                                  : homeController.selectedMenuModel.value.id ==
                                          1
                                      ? DocumentsHeaderWidget(
                                          documentsController:
                                              documentsController,
                                        )
                                      : const SizedBox.shrink(),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  color: bgContainColor,
                                  border: Border.all(color: darkDividerColor),
                                  borderRadius: BorderRadius.circular(9)),
                              child: Center(
                                child: Obx(
                                  () => homeController
                                              .selectedMenuModel.value.id ==
                                          0
                                      ? homeController
                                              .chatRoomList.value.isEmpty
                                          ? NoDataWiget()
                                          : ChatBodyWidget(
                                              homeController: homeController,
                                            )
                                      : homeController
                                                  .selectedMenuModel.value.id ==
                                              1
                                          ? DesktopDocumentsWidget(
                                              documentsController:
                                                  documentsController)
                                          : NoDataWiget(),
                                ),
                              ),
                            ),
                          ),
                          // Obx(() => homeController.selectedMenuModel.value.id ==
                          //         0
                          //     ? ChatFooterWidget(
                          //         homeController: homeController,
                          //       )
                          //     : homeController.selectedMenuModel.value.id == 1
                          //         ? DocumentFooterWidget(
                          //             documentsController: documentsController,
                          //           )
                          //         : const SizedBox()),
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
