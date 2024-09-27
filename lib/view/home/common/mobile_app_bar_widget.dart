import 'package:ai_document_app/controllers/home_controller.dart';
import 'package:ai_document_app/model/chat_list_model.dart';
import 'package:ai_document_app/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_text_style.dart';
import '../../../utils/common_dialog.dart';
import 'searchbar_widget.dart';

class MobileAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final HomeController homeController;
  final VoidCallback onMenuTap;

  MobileAppBarWidget({
    required this.homeController,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Obx(
        () => homeController.isSearchOpen.value
            ? SearchbarWidget(
                homeController: homeController,
              )
            : Text(
                homeController.selectedMenuModel.value.name,
                style: AppTextStyle.normalBold18,
              ),
      ),
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          color: primaryWhite,
        ),
        onPressed: onMenuTap,
      ),
      actions: [
        Row(
          children: [
            Obx(
              () => homeController.isSearchOpen.value
                  ? const SizedBox.shrink()
                  : IconButton(
                      onPressed: () {
                        homeController.isSearchOpen.value = true;
                      },
                      icon: const Icon(
                        CupertinoIcons.search,
                        color: primaryWhite,
                      ),
                    ),
            ),
            Obx(() => homeController.selectedMenuModel.value.id == 0
                ? IconButton(
                    onPressed: () {
                      showHistoryDialog();
                    },
                    icon: const Icon(
                      Icons.history,
                      color: primaryWhite,
                    ),
                  )
                : const SizedBox.shrink()),
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void showHistoryDialog() {
    CommonDialog.showCustomDialog(
      title: 'History',
      content: Column(
        mainAxisSize: MainAxisSize.min, // Wrap the content
        children: [
          Obx(
            () {
              if (homeController.chatList.value.isEmpty) {
                return Center(
                    child: Text(
                  'No history available',
                  style: AppTextStyle.normalBold18,
                ));
              }
              return Obx(
                () => Column(
                  children: homeController.chatList.value.map((element) {
                    return HistoryMenuTileWidget(
                      model: element,
                      onTap: () {
                        homeController.selectedChatList.value = [element];
                        homeController.selectedChatList.refresh();
                        Get.back(); // Close dialog after selection
                      },
                      isSelect: homeController.selectedChatList.value
                          .contains(element),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ],
      ),
      confirmText: 'Done',
      onConfirm: () {
        // Handle confirm action
        Get.back(); // Close dialog on confirm
      },
      cancelText: 'Cancel',
      onCancel: () {
        // Handle cancel action
        Get.back(); // Close dialog on cancel
      },
    );
  }
}

Widget HistoryMenuTileWidget({
  required ChatListModel model,
  required VoidCallback onTap,
  required bool isSelect,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          gradient: isSelect
              ? const LinearGradient(
                  colors: [orangeColor, purpleColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  model.name,
                  style: AppTextStyle.normalBold16,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    ),
  );
}
