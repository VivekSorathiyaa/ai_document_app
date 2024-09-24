class ChatMessageModel {
  final String id;
  final String senderId;
  final String content;
  final DateTime timestamp;
  final bool isUser; // True if the sender is a user

  ChatMessageModel({
    required this.id,
    required this.senderId,
    required this.content,
    required this.timestamp,
    this.isUser = true, // Default to user
  });

  // Factory method to create a ChatMessage from JSON
  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'],
      senderId: json['senderId'],
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
      isUser: json['isUser'] ?? true,
    );
  }

  // Method to convert ChatMessage to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'isUser': isUser,
    };
  }
}

class ChatRoomModel {
  final String id;
  final String title;
  final List<ChatMessageModel> messages;
  final DateTime createdAt;
  final DateTime updatedAt;

  ChatRoomModel({
    required this.id,
    required this.title,
    required this.messages,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create a ChatRoom from JSON
  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {
    return ChatRoomModel(
      id: json['id'],
      title: json['title'],
      messages: (json['messages'] as List)
          .map((messageJson) => ChatMessageModel.fromJson(messageJson))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // Method to convert ChatRoom to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'messages': messages.map((msg) => msg.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

// Dummy Data
List<ChatRoomModel> dummyChatRooms = [
  ChatRoomModel(
    id: '1',
    title: 'Chat with AI Assistant',
    messages: [
      ChatMessageModel(
        id: 'msg1',
        senderId: 'user123',
        content: 'Hello! How can you assist me today?',
        timestamp: DateTime.now().subtract(Duration(minutes: 5)),
        isUser: true,
      ),
      ChatMessageModel(
        id: 'msg2',
        senderId: 'aiBot',
        content:
            'Hi there! I can help you with various topics. What do you need assistance with?',
        timestamp: DateTime.now().subtract(Duration(minutes: 4)),
        isUser: false,
      ),
      ChatMessageModel(
        id: 'msg3',
        senderId: 'user123',
        content: 'Can you explain the weather today?',
        timestamp: DateTime.now().subtract(Duration(minutes: 3)),
        isUser: true,
      ),
      ChatMessageModel(
        id: 'msg4',
        senderId: 'aiBot',
        content:
            'Sure! Today is sunny with a high of 25°C. Do you have any plans?',
        timestamp: DateTime.now().subtract(Duration(minutes: 2)),
        isUser: false,
      ),
    ],
    createdAt: DateTime.now().subtract(Duration(days: 1)),
    updatedAt: DateTime.now().subtract(Duration(minutes: 1)),
  ),
];
