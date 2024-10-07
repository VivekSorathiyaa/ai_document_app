import 'package:ai_document_app/view/home/settings/settings_header_widget.dart';
import 'package:ai_document_app/view/home/settings/settings_widget.dart';
import 'package:ai_document_app/view/home/user/desktop_user_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

// Import controllers
import '../../controllers/documents_controller.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/settings_controller.dart';
import '../../controllers/user_controller.dart';
import '../../utils/color.dart';
import '../../utils/pdf_view_widget.dart';
import 'chat/chat_body_widget.dart';
import 'chat/chat_footer_widget.dart';
import 'chat/desktop_chat_header_widget.dart';
import 'common/desktop_app_bar_widget.dart';
import 'common/drawer_widget.dart';
import 'common/no_data_widget.dart';
import 'documents/desktop_documents_widget.dart';
import 'documents/documents_footer_widget.dart';
import 'documents/documents_header_widget.dart';
import 'user/user_footer_widget.dart';
import 'user/user_header_widget.dart';

class DeskTopHomeView extends StatelessWidget {
  final HomeController homeController;
  final DocumentsController documentsController;
  final UserController userController;
  final SettingsController settingsController;

  DeskTopHomeView({
    Key? key,
    required this.homeController,
    required this.documentsController,
    required this.userController,
    required this.settingsController,
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
                  _buildSliverAppBar(),
                  _buildMainContent(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      expandedHeight: 70,
      flexibleSpace: FlexibleSpaceBar(
        background: DesktopAppBarWidget(homeController: homeController),
      ),
    );
  }

  SliverFillRemaining _buildMainContent() {
    return SliverFillRemaining(
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
            _buildHeader(),
            _buildBody(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Padding _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Obx(
        () {
          final selectedMenuId = homeController.selectedMenuModel.value.id;
          if (selectedMenuId == 0) {
            return DesktopChatHeaderWidget(homeController: homeController);
          } else if (selectedMenuId == 1) {
            return DocumentsHeaderWidget(
                documentsController: documentsController);
          } else if (selectedMenuId == 2) {
            return UserHeaderWidget(userController: userController);
          } else if (selectedMenuId == 3) {
            return SettingsHeaderWidget(
              settingsController: settingsController,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Expanded _buildBody() {
    return Expanded(
      child: Obx(() {
        final selectedMenuId = homeController.selectedMenuModel.value.id;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: selectedMenuId == 3 ? Colors.transparent : bgContainColor,
            border: Border.all(
              color:
                  selectedMenuId == 3 ? Colors.transparent : darkDividerColor,
            ),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Center(
            child: _getSelectedWidget(selectedMenuId),
          ),
        );
      }),
    );
  }

  Widget _getSelectedWidget(int selectedMenuId) {
    switch (selectedMenuId) {
      case 0:
        return homeController.chatRoomList.value.isEmpty
            ? NoDataWiget()
            : Row(
                children: [
                  Expanded(
                    child: PinchPage(),
                  ),
                  Expanded(
                      child: ChatBodyWidget(homeController: homeController)),
                ],
              );
      case 1:
        return DesktopDocumentsWidget(documentsController: documentsController);
      case 2:
        return DesktopUserWidget(userController: userController);
      case 3:
        return SettingsWidget(settingsController: settingsController);
      default:
        return NoDataWiget();
    }
  }

  Obx _buildFooter() {
    return Obx(() {
      final selectedMenuId = homeController.selectedMenuModel.value.id;
      if (selectedMenuId == 0) {
        return ChatFooterWidget(homeController: homeController);
      } else if (selectedMenuId == 1) {
        return DocumentFooterWidget(documentsController: documentsController);
      } else if (selectedMenuId == 2) {
        return UserFooterWidget(userController: userController);
      } else {
        return const SizedBox();
      }
    });
  }
}
