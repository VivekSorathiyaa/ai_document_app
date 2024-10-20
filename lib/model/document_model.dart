import 'package:cloud_firestore/cloud_firestore.dart';

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

  // Factory method to create a DocumentModel from Firestore data
  factory DocumentModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return DocumentModel(
      id: doc.id, // Document ID from Firestore
      name: data['name'] ?? '', // Default to empty string if not present
      status: data['status'] ?? '', // Default to empty string if not present
      uploadedBy:
          data['uploaded_by'] ?? '', // Adjust based on Firestore field name
      size: (data['size'] ?? 0.0) as double, // Assuming size is a double
      date: data['date'] ??
          '', // Adjust based on your Firestore date field format
      actions: data['actions'] ?? '', // Default to empty string if not present
      url: data['url'] ?? '', // Default to empty string if not present
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other is DocumentModel && other.id == id);
  }

  @override
  int get hashCode => id.hashCode;
}
