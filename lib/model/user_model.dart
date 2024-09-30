class UserModel {
  final String id;
  final String name;
  final String email;
  String permissions;
  final String date;
  String access;
  String actions;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.permissions,
    required this.date,
    required this.access,
    required this.actions,
  });
}
