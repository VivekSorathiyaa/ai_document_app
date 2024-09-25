class MenuModel {
  int id;
  String name;
  String icon;
  String? subTitle;
  MenuModel({
    required this.id,
    required this.name,
    required this.icon,
    this.subTitle,
  });
}
