import 'package:ai_document_app/controllers/settings_controller.dart';
import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/color.dart';
import 'package:ai_document_app/utils/input_text_field_widget.dart';
import 'package:ai_document_app/utils/static_decoration.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../utils/drop_zone_widget.dart';

class SettingsPersonalInfoWidget extends StatelessWidget {
  SettingsPersonalInfoWidget({super.key});
  SettingsController settingsController = Get.put(SettingsController());
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 2),
      children: [
        _buildNameWidget(context),
        _buildEmailWidget(context),
        _buildPhotoWidget(context, true),
        _buildRoleWidget(context),
        _buildCountryWidget(context),
        _buildPhotoWidget(context, false),
        customHeight(200)
      ],
    );
  }
}

Widget _buildNameWidget(BuildContext context) {
  bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
  return Column(
    children: [
      customHeight(10),
      const Divider(
        color: tableButtonColor,
        height: 1,
      ),
      height20,
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDesktop)
            Expanded(
              child: Text(
                "Name",
                style: AppTextStyle.normalRegular16
                    .copyWith(color: tableTextColor),
              ),
            ),
          Expanded(
            child: TextFormFieldWidget(
              controller: null,
              hintText: "Enter Your Name",
              borderColor: tableButtonColor,
              labelText: isDesktop ? null : "Name",
              filledColor: bgContainColor,
            ),
          ),
        ],
      )
    ],
  );
}

Widget _buildEmailWidget(BuildContext context) {
  bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
  return Column(
    children: [
      customHeight(32),
      const Divider(
        color: tableButtonColor,
        height: 1,
      ),
      height20,
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDesktop)
            Expanded(
              child: Text(
                "Email address",
                style: AppTextStyle.normalRegular16
                    .copyWith(color: tableTextColor),
              ),
            ),
          Expanded(
            child: TextFormFieldWidget(
              controller: null,
              hintText: "Enter Your Email",
              borderColor: tableButtonColor,
              labelText: isDesktop ? null : "Email address",
              filledColor: bgContainColor,
            ),
          ),
        ],
      )
    ],
  );
}

Widget _buildRoleWidget(BuildContext context) {
  bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
  return Column(
    children: [
      customHeight(32),
      const Divider(
        color: tableButtonColor,
        height: 1,
      ),
      height20,
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDesktop)
            Expanded(
              child: Text(
                "Role",
                style: AppTextStyle.normalRegular16
                    .copyWith(color: tableTextColor),
              ),
            ),
          Expanded(
            child: TextFormFieldWidget(
              controller: null,
              hintText: "Enter Your Role",
              borderColor: tableButtonColor,
              labelText: isDesktop ? null : "Role",
              filledColor: bgContainColor,
            ),
          ),
        ],
      )
    ],
  );
}

_photoLableWidget(bool isFromProfile) {
  return Padding(
    padding: const EdgeInsets.only(right: 32),
    child: Column(
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                isFromProfile ? "Your photo" : "Uploaded PDFs",
                style:
                    AppTextStyle.normalBold16.copyWith(color: tableTextColor),
              ),
            ),
            customWidth(4),
            const Icon(
              CupertinoIcons.question_circle,
              color: tableTextColor,
              size: 18,
            )
          ],
        ),
        customHeight(5),
        Row(
          children: [
            Expanded(
              child: Text(
                isFromProfile
                    ? "This will be displayed on your profile."
                    : "Share a few snippets of your PDFs.",
                style: AppTextStyle.normalRegular16
                    .copyWith(color: tableTextColor),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Widget _buildPhotoWidget(BuildContext context, bool isFromProfile) {
  bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
  return Column(
    children: [
      customHeight(32),
      const Divider(
        color: tableButtonColor,
        height: 1,
      ),
      height20,
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDesktop) Expanded(child: _photoLableWidget(isFromProfile)),
          Expanded(
            child: Column(
              children: [
                if (isDesktop == false)
                  Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: _photoLableWidget(isFromProfile),
                  ),
                CommonFileDropzone(
                  onFileUploaded: (String downloadUrl) {},
                  allowedFormats: ['.jpeg', 'png', 'jpg'],
                  maxSizeInMB: 16,
                  maxFiles: 1,
                ),
                // if (isFromProfile == false)
                //   ...List.generate(3, (index) {
                //     return const UploadingDocumetsWidget();
                //   })
              ],
            ),
          )
        ],
      )
    ],
  );
}

Widget _buildCountryWidget(BuildContext context) {
  bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
  return Column(
    children: [
      customHeight(32),
      const Divider(
        color: tableButtonColor,
        height: 1,
      ),
      height20,
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDesktop)
            Expanded(
              child: Text(
                "Country",
                style: AppTextStyle.normalRegular16
                    .copyWith(color: tableTextColor),
              ),
            ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isDesktop)
                  Text(
                    "Country",
                    style: AppTextStyle.normalRegular16
                        .copyWith(color: tableTextColor),
                  ),
                height10,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      border: Border.all(color: tableButtonColor),
                      color: bgContainColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: CountryPickerDropdown(
                    initialValue: 'IN',
                    isExpanded: true,
                    dropdownColor: bgContainColor,
                    itemBuilder: (country) {
                      return _buildDropdownItemWithLongText(
                        country,
                      );
                    },
                    priorityList: [
                      CountryPickerUtils.getCountryByIsoCode('GB'),
                      CountryPickerUtils.getCountryByIsoCode('CN'),
                    ],
                    sortComparator: (Country a, Country b) =>
                        a.isoCode.compareTo(b.isoCode),
                    onValuePicked: (Country country) {
                      print("${country.name}");
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      )
    ],
  );
}

Widget _buildDropdownItemWithLongText(Country country) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset(
                CountryPickerUtils.getFlagImageAssetPath(country.isoCode),
                height: 25.0,
                width: 25.0,
                fit: BoxFit.cover,
                package: "country_pickers",
              )),
          const SizedBox(
            width: 8.0,
          ),
          Expanded(
              child: Text(
            country.name,
            style: AppTextStyle.normalRegular16.copyWith(color: hintGreyColor),
            overflow: TextOverflow.clip,
            maxLines: 1,
          )),
        ],
      ),
    );
