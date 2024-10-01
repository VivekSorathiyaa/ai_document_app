import 'package:flutter/cupertino.dart';

class SettingsModel {
  int id;
  IconData icon;
  String title;
  String subTitle;
  SettingsModel(
      {required this.id,
      required this.icon,
      required this.title,
      required this.subTitle});
}
