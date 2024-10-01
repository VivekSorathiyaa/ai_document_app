import 'package:ai_document_app/model/chat_list_model.dart';
import 'package:ai_document_app/utils/app_asset.dart';
import 'package:get/get.dart';

import '../model/chatroom_model.dart';
import '../model/document_list_model.dart';
import '../model/language_list_model.dart';
import '../model/menu_model.dart';
import '../model/suggestion_model.dart';

class HomeController extends GetxController {
  Rx<MenuModel> selectedMenuModel = Rx<MenuModel>(menuList.value[3]);
  RxBool isSearchOpen = false.obs;

  RxList<ChatRoomModel> chatRoomList = <ChatRoomModel>[].obs;
  RxList<ChatListModel> chatList = RxList<ChatListModel>([
    ChatListModel(id: '1', name: "chat 1"),
    ChatListModel(id: '2', name: "chat 2"),
    ChatListModel(id: '3', name: "chat 3"),
    ChatListModel(id: '4', name: "chat 4"),
    ChatListModel(id: '5', name: "chat 5"),
    ChatListModel(id: '6', name: "chat 6"),
    ChatListModel(id: '7', name: "chat 7"),
    ChatListModel(id: '8', name: "chat 8"),
  ]);
  RxList<DocumentListModel> documentList = RxList<DocumentListModel>([
    DocumentListModel(id: '1', name: "document 1"),
    DocumentListModel(id: '2', name: "document 2"),
    DocumentListModel(id: '3', name: "document 3"),
    DocumentListModel(id: '4', name: "document 4"),
    DocumentListModel(id: '5', name: "document 5"),
    DocumentListModel(id: '6', name: "document 6"),
    DocumentListModel(id: '7', name: "document 7"),
    DocumentListModel(id: '8', name: "document 8"),
  ]);
  RxList<LanguageListModel> languageList = RxList<LanguageListModel>([
    LanguageListModel(id: '1', name: "Hindi"),
    LanguageListModel(id: '2', name: "Gujrati"),
    LanguageListModel(id: '3', name: "Tamil"),
    LanguageListModel(id: '4', name: "Kannad"),
    LanguageListModel(id: '5', name: "Rassian"),
    LanguageListModel(id: '6', name: "Urdu"),
    LanguageListModel(id: '7', name: "Spanish"),
    LanguageListModel(id: '8', name: "Chines"),
  ]);
  RxList<SuggestionModel> suggestionList = RxList<SuggestionModel>([
    SuggestionModel(id: '1', name: "Write summary of book?"),
    SuggestionModel(id: '2', name: "Write summary of book?"),
    SuggestionModel(id: '3', name: "Write summary of book?"),
    SuggestionModel(id: '4', name: "Write summary of book?"),
    SuggestionModel(id: '5', name: "Write summary of book?"),
    SuggestionModel(id: '6', name: "Write summary of book?"),
    SuggestionModel(id: '7', name: "Write summary of book?"),
    SuggestionModel(id: '8', name: "Write summary of book?"),
  ]);

  RxList<ChatListModel> selectedChatList = <ChatListModel>[].obs;
  RxList<DocumentListModel> selectedDocumentList = <DocumentListModel>[].obs;
  RxList<LanguageListModel> selectedLanguageList = <LanguageListModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 5));
    chatRoomList.value = dummyChatRooms;
    chatRoomList.refresh();
  }
}

RxList<MenuModel> menuList = <MenuModel>[
  MenuModel(name: 'Chat', icon: AppAsset.chat, subTitle: "200 credits", id: 0),
  MenuModel(
      name: 'Documents', icon: AppAsset.clipboard, subTitle: '5 PDFs', id: 1),
  MenuModel(
    name: 'User Management',
    icon: AppAsset.users,
    id: 2,
  ),
  MenuModel(
    name: 'Settings',
    icon: AppAsset.setting,
    id: 3,
  ),
].obs;
