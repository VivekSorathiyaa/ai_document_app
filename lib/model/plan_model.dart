class PlanModel {
  int id;
  String price;
  bool isMonthly;
  bool isPopular;
  String name;
  String description;
  List<String> features;

  PlanModel({
    required this.id,
    required this.price,
    required this.isMonthly,
    required this.isPopular,
    required this.name,
    required this.description,
    required this.features,
  });
}
