import 'package:ai_document_app/model/settings_model.dart';
import 'package:ai_document_app/view/home/settings/settings_login_security_widget.dart';
import 'package:ai_document_app/view/home/settings/settings_personal_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../controllers/settings_controller.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/color.dart';
import '../common/no_data_widget.dart';

class SettingsWidget extends StatelessWidget {
  final SettingsController settingsController;

  const SettingsWidget({super.key, required this.settingsController});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int getCrossAxisCount(double width) {
      if (width >= 1200) {
        return 3;
      } else {
        return 1;
      }
    }

    return Obx(() => settingsController.selectedSettingMenuModel.value != null
        ? _getSelectedMenuWidget(
            settingsController.selectedSettingMenuModel.value!)
        : Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: StaggeredGrid.count(
                crossAxisCount: getCrossAxisCount(screenWidth),
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: settingMenuList.value.map((model) {
                  return Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                          settingsController.refreshSettingMenuModel(model);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 22, horizontal: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(color: tableButtonColor),
                            color: bgContainColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 38,
                                height: 38,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [endPurpleColor, startPurpleColor],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: Icon(
                                  model.icon,
                                  color: primaryWhite,
                                ),
                              ),
                              const SizedBox(
                                  height:
                                      17), // Replaced with SizedBox for spacing
                              Text(
                                model.title,
                                style: AppTextStyle.normalBold18
                                    .copyWith(color: primaryWhite),
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              ),
                              const SizedBox(height: 17),
                              Text(
                                model.subTitle,
                                style: AppTextStyle.normalRegular14
                                    .copyWith(color: tableTextColor),
                                maxLines: 2,
                                overflow: TextOverflow.clip,
                              ),
                            ],
                          ),
                        ),
                      ));
                }).toList(),
              ),
            ),
          ));
  }

  Widget _getSelectedMenuWidget(SettingsMenuModel model) {
    switch (model.id) {
      case 0:
        return SettingsPersonalInfoWidget();
      case 1:
        return SettingsLoginSecurityWidget();
      case 2:
        return NoDataWiget();
      case 3:
        return NoDataWiget();
      case 4:
        return NoDataWiget();
      case 5:
        return NoDataWiget();
      default:
        return NoDataWiget();
    }
  }
}
