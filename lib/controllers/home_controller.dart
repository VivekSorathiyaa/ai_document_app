import 'package:ai_document_app/utils/app_asset.dart';
import 'package:get/get.dart';

import '../model/menu_model.dart';

class HomeController extends GetxController {
  Rx<MenuModel> selectedMenuModel = Rx<MenuModel>(
    MenuModel(name: 'Chat', icon: AppAsset.chat, subTitle: "200 credits"),
  );

  RxList<MenuModel> menuList = <MenuModel>[
    MenuModel(name: 'Chat', icon: AppAsset.chat, subTitle: "200 credits"),
    MenuModel(name: 'Documents', icon: AppAsset.clipboard, subTitle: '5 PDFs'),
    MenuModel(
      name: 'User Management',
      icon: AppAsset.users,
    ),
    MenuModel(
      name: 'Settings',
      icon: AppAsset.setting,
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    selectedMenuModel.value = menuList.first;
    selectedMenuModel.refresh();
  }
}
