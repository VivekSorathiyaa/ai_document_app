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
import 'chat/chat_body_widget.dart';
import 'chat/chat_footer_widget.dart';
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
                  _buildMainContent(context),
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
        background: DesktopAppBarWidget(),
      ),
    );
  }

  SliverFillRemaining _buildMainContent(context) {
    return SliverFillRemaining(
      hasScrollBody: true,
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
          color: bgBlackColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildHeader(),
            _buildBody(context),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  _buildHeader() {
    return Obx(() {
      final selectedMenuId = homeController.selectedMenuModel.value.id;

      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: selectedMenuId == 0 ? 8 : 16,
        ),
        child: Builder(
          builder: (context) {
            switch (selectedMenuId) {
              case 0:
                return SizedBox.shrink();
              // Optionally, use DesktopChatHeaderWidget here if required
              // return DesktopChatHeaderWidget();
              case 1:
                return DocumentsHeaderWidget(
                    documentsController: documentsController);
              case 2:
                return UserHeaderWidget(userController: userController);
              case 3:
                return SettingsHeaderWidget(
                    settingsController: settingsController);
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      );
    });
  }

  Expanded _buildBody(context) {
    bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;

    return Expanded(
      child: Obx(() {
        final selectedMenuId = homeController.selectedMenuModel.value.id;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: selectedMenuId == 3 ||
                    (selectedMenuId == 1 &&
                        documentsController.isUploadWidgetOpen.value)
                ? Colors.transparent
                : bgContainColor,
            border: Border.all(
              color: selectedMenuId == 3 ||
                      (selectedMenuId == 1 &&
                          documentsController.isUploadWidgetOpen.value)
                  ? Colors.transparent
                  : darkDividerColor,
            ),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              _getSelectedWidget(selectedMenuId),
              if (isDesktop && homeController.selectedMenuModel.value.id == 0)
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: IgnorePointer(
                    ignoring: true,
                    child: Container(
                      width: Get.width,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        gradient: LinearGradient(
                          colors: [
                            bgContainColor,
                            bgContainColor.withOpacity(.9),
                            bgContainColor.withOpacity(.8),
                            bgContainColor.withOpacity(.7),
                            bgContainColor.withOpacity(.6),
                            bgContainColor.withOpacity(.5),
                            bgContainColor.withOpacity(.4),
                            bgContainColor.withOpacity(.3),
                            bgContainColor.withOpacity(.2),
                            bgContainColor.withOpacity(.1),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                ),
              if (isDesktop && homeController.selectedMenuModel.value.id == 0)
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: IgnorePointer(
                    ignoring: true,
                    child: Container(
                      width: Get.width,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        gradient: LinearGradient(
                          colors: [
                            bgContainColor.withOpacity(.1),
                            bgContainColor.withOpacity(.2),
                            bgContainColor.withOpacity(.3),
                            bgContainColor.withOpacity(.4),
                            bgContainColor.withOpacity(.5),
                            bgContainColor.withOpacity(.6),
                            bgContainColor.withOpacity(.7),
                            bgContainColor.withOpacity(.8),
                            bgContainColor.withOpacity(.9),
                            bgContainColor
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _getSelectedWidget(int selectedMenuId) {
    switch (selectedMenuId) {
      case 0:
        return ChatBodyWidget();
      case 1:
        return DesktopDocumentsWidget(documentsController: documentsController);
      case 2:
        return DesktopUserWidget(userController: userController);
      case 3:
        return SettingsWidget(settingsController: settingsController);
      default:
        return NoDataWidget();
    }
  }

  Obx _buildFooter() {
    return Obx(() {
      final selectedMenuId = homeController.selectedMenuModel.value.id;
      if (selectedMenuId == 0) {
        return ChatFooterWidget();
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
