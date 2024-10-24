import 'package:ai_document_app/controllers/chat_controller.dart';
import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/color.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/home_controller.dart';
// import '../../../utils/custom_dropdown_widget.dart';
import '../../../model/chat_model.dart';
import 'searchbar_widget.dart';

class DesktopAppBarWidget extends StatelessWidget {
  DesktopAppBarWidget({super.key});
  var homeController = Get.put(HomeController());
  var chatController = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
          color: bgBlackColor, borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Obx(
          () => homeController.selectedMenuModel.value.id == 0
              ? Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () {
                          final initialItem = chatController.chatRoomList.value
                                  .contains(
                                      chatController.currentChatRoom.value)
                              ? chatController.currentChatRoom.value
                              : null;
                          return CustomDropdown<ChatModel>.search(
                            hintText: 'History',
                            initialItem: initialItem,
                            listItemPadding: const EdgeInsets.all(12),
                            items: chatController.chatRoomList.value,
                            closedHeaderPadding: const EdgeInsets.all(10),
                            closeDropDownOnClearFilterSearch: true,
                            excludeSelected: false,
                            hideSelectedFieldWhenExpanded: false,
                            expandedHeaderPadding: const EdgeInsets.all(10),
                            decoration: CustomDropdownDecoration(
                                closedFillColor: primaryBlack,
                                expandedFillColor: primaryBlack,
                                listItemStyle: AppTextStyle.normalRegular14,
                                listItemDecoration: ListItemDecoration(
                                    splashColor: primaryWhite.withOpacity(.1),
                                    highlightColor:
                                        primaryWhite.withOpacity(.1),
                                    selectedColor:
                                        primaryWhite.withOpacity(.1)),
                                prefixIcon: InkWell(
                                  onTap: () {
                                    chatController
                                        .showCreateChatRoomDialog(context);
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        colors: [orangeColor, purpleColor],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Icon(
                                        Icons.add,
                                        color: primaryWhite,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                closedSuffixIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: hintGreyColor,
                                  size: 20,
                                ),
                                expandedSuffixIcon: const Icon(
                                  Icons.keyboard_arrow_up_rounded,
                                  color: hintGreyColor,
                                  size: 20,
                                ),
                                searchFieldDecoration: SearchFieldDecoration(
                                    fillColor: bgBlackColor,
                                    contentPadding: EdgeInsets.zero,
                                    suffixIcon: (v) {
                                      return const SizedBox();
                                    },
                                    prefixIcon: const Icon(
                                      CupertinoIcons.search,
                                      color: hintGreyColor,
                                      size: 20,
                                    ),
                                    textStyle: AppTextStyle.normalRegular14
                                        .copyWith(color: primaryWhite),
                                    hintStyle: AppTextStyle.normalRegular14
                                        .copyWith(color: hintGreyColor)),
                                expandedBorder:
                                    Border.all(color: darkDividerColor)),
                            headerBuilder: (context, ChatModel? selectedItem,
                                bool isExpanded) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      selectedItem?.name ??
                                          'Select a chat', // Display the selected chat name or default text
                                      style:
                                          AppTextStyle.normalRegular14.copyWith(
                                        color: primaryWhite,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              );
                            },
                            canCloseOutsideBounds: true,
                            listItemBuilder: (context, ChatModel chatModel,
                                bool isSelected, onTap) {
                              return GestureDetector(
                                onTap: () {
                                  onTap();
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        chatModel.name ?? 'Unnamed Chat',
                                        style: AppTextStyle.normalRegular14,
                                      ),
                                    ),
                                    if (chatController.currentChatRoom.value ==
                                        chatModel)
                                      Container(
                                        width: 25,
                                        height: 25,
                                        child: Center(
                                          child: PopupMenuButton<String>(
                                            padding: EdgeInsets.zero,
                                            menuPadding: EdgeInsets.zero,
                                            color: bgContainColor,
                                            icon: const Icon(
                                              Icons.more_horiz,
                                              color: hintGreyColor,
                                            ),
                                            onSelected: (value) {
                                              if (value == 'edit') {
                                                // Handle edit action
                                                chatController
                                                    .showEditChatDialog(
                                                        context, chatModel);
                                              } else if (value == 'delete') {
                                                // Handle delete action
                                                chatController
                                                    .showDeleteChatDialog(
                                                        context, chatModel);
                                              }
                                            },
                                            itemBuilder:
                                                (BuildContext context) {
                                              return [
                                                PopupMenuItem<String>(
                                                  value: 'edit',
                                                  child: Text(
                                                    'Edit',
                                                    style: AppTextStyle
                                                        .normalSemiBold14,
                                                  ),
                                                ),
                                                PopupMenuItem<String>(
                                                  value: 'delete',
                                                  child: Text('Delete',
                                                      style: AppTextStyle
                                                          .normalSemiBold14),
                                                ),
                                              ];
                                            },
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            },
                            onChanged: (value) {
                              print("-----------setCurrentChatRoomI-----12");
                              if (value != null) {
                                chatController.setCurrentChatRoomId(value);
                              }
                            },
                          );
                        },
                      ),
                    ),

                    // Expanded(
                    //   child: Obx(
                    //     () => CustomDropdown(
                    //       items: chatController.chatRoomList.value,
                    //       selectedValues: chatController
                    //               .selectedChatList.value.isNotEmpty
                    //           ? [chatController.selectedChatList.value.first]
                    //           : [],
                    //       hintText: 'History',
                    //       onChanged: (newValues) {
                    //         chatController.selectedChatList.value =
                    //             newValues.cast<ChatModel>();
                    //         chatController.setCurrentChatRoomId(
                    //             chatController.selectedChatList.value.first);
                    //       },
                    //       displayItem: (item) => item.name,
                    //       selectionMode: SelectionMode.single,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(width: 27),
                    // Expanded(
                    //   child: Obx(
                    //     () {
                    //       return CustomDropdown(
                    //         items: chatController.documentsList.value,
                    //         selectedValues:
                    //             chatController.selectedDocumentList.value,
                    //         hintText: 'Select PDF to get answer',
                    //         onChanged: (newValues) {
                    //           chatController.selectedDocumentList.assignAll(
                    //               newValues
                    //                   .cast<DocumentModel>()); // Use assignAll
                    //           chatController
                    //               .updateSelectedDocumentsInFirestore();
                    //         },
                    //         displayItem: (item) => item.name,
                    //         selectionMode: SelectionMode.multi,
                    //       );
                    //     },
                    //   ),
                    // ),
                    const SizedBox(width: 27),
                    Expanded(child: SearchbarWidget())
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Obx(
                        () => SelectableText(
                          homeController.selectedMenuModel.value.name,
                          style: AppTextStyle.normalSemiBold26,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    Expanded(flex: 3, child: SearchbarWidget())
                  ],
                ),
        ),
      ),
    );
  }
}
