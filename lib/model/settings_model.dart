import 'package:flutter/cupertino.dart';

class SettingsMenuModel {
  int id;
  IconData icon;
  String title;
  String subTitle;
  SettingsMenuModel(
      {required this.id,
      required this.icon,
      required this.title,
      required this.subTitle});
}
