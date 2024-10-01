import 'package:ai_document_app/model/settings_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  RxList<SettingsModel> settingList = <SettingsModel>[
    SettingsModel(
        id: 1,
        icon: CupertinoIcons.person_alt_circle,
        title: 'Personal Info',
        subTitle: 'Provide personal details and how we can reach you'),
    SettingsModel(
        id: 2,
        icon: CupertinoIcons.checkmark_shield,
        title: 'Login & Security',
        subTitle: 'Update your password and secure your account'),
    SettingsModel(
        id: 3,
        icon: CupertinoIcons.creditcard,
        title: 'Payments & Payouts',
        subTitle: 'Review payments, payouts, coupons, and gift cards'),
    SettingsModel(
        id: 4,
        icon: CupertinoIcons.gift,
        title: 'Referral Credit & Coupon',
        subTitle: 'You have \$0 referral credits and coupon. Learn more.'),
    SettingsModel(
        id: 5,
        icon: CupertinoIcons.question_diamond,
        title: 'Custom Questions',
        subTitle: 'Create custom Questions and use accross the app'),
  ].obs;
}
