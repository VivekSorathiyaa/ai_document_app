class DocumentModel {
  final String id;
  final String name;
  final String status;
  final String uploadedBy;
  final double size;
  final String date;
  final String actions;
  final String url;

  DocumentModel({
    required this.id,
    required this.name,
    required this.status,
    required this.uploadedBy,
    required this.size,
    required this.date,
    required this.actions,
    required this.url,
  });
}
