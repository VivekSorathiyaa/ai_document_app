import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String? id;
  final String? name;
  final List<String>? participants;
  final List<String>? selectedDocuments;
  final List<MessageModel>? messages;
  final Timestamp? createdAt;

  ChatModel({
    this.id,
    this.name,
    this.participants,
    this.selectedDocuments,
    this.messages,
    this.createdAt,
  });

  factory ChatModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return ChatModel(
      id: doc.id,
      name: _capitalize(data['name'] as String?), // Capitalize the name
      participants: (data['participants'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      selectedDocuments: (data['selected_documents'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      messages: (data['messages'] as List<dynamic>?)
          ?.map((message) =>
              MessageModel.fromMap(message as Map<String, dynamic>))
          .toList(),
      createdAt: data['createdAt'] as Timestamp?,
    );
  }

  // Helper function to capitalize the first letter of the name
  static String? _capitalize(String? text) {
    if (text == null || text.isEmpty) return text; // Return if null or empty
    return text[0].toUpperCase() +
        text.substring(1); // Capitalize the first character
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other is ChatModel && other.id == id);
  }

  @override
  int get hashCode => id.hashCode;
}

class MessageModel {
  final String? senderId;
  final String? text;
  final Timestamp? timestamp;
  final List<String>? selectedDocuments;

  MessageModel({
    this.senderId,
    this.text,
    this.timestamp,
    this.selectedDocuments,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'] as String?,
      text: map['text'] as String?,
      timestamp: map['timestamp'] as Timestamp?,
      selectedDocuments: (map['selected_documents'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }
}
