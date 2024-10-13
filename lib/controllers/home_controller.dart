import 'package:ai_document_app/utils/app_asset.dart';
import 'package:get/get.dart';

import '../model/menu_model.dart';

class HomeController extends GetxController {
  Rx<MenuModel> selectedMenuModel = Rx<MenuModel>(menuList.value[0]);

  RxBool isDrawerExpand = true.obs;
  RxBool isSearchOpen = false.obs;
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
