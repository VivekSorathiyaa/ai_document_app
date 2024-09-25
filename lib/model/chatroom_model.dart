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

List<ChatRoomModel> dummyChatRooms = [
  ChatRoomModel(
    id: '1',
    title: 'Chat with AI Assistant',
    messages: [
      ChatMessageModel(
        id: 'msg1_1',
        senderId: 'user123',
        content: 'Hello! Can you assist me with some general inquiries?',
        timestamp: DateTime.now().subtract(Duration(minutes: 10)),
        isUser: true,
      ),
      ChatMessageModel(
        id: 'msg1_2',
        senderId: 'aiBot',
        content: '''
# Welcome to AI Assistance

Hi there! I can help you with a wide range of topics, including:

- **Weather updates**
- _News highlights_
- *Programming tips*
- [Visit our FAQ](https://www.example.com/faq)

Just ask me anything!
''',
        timestamp: DateTime.now().subtract(Duration(minutes: 9)),
        isUser: false,
      ),
      ChatMessageModel(
        id: 'msg1_3',
        senderId: 'user123',
        content: 'Can you tell me about today’s weather?',
        timestamp: DateTime.now().subtract(Duration(minutes: 8)),
        isUser: true,
      ),
      ChatMessageModel(
        id: 'msg1_4',
        senderId: 'aiBot',
        content: '''
## Today’s Weather

The current weather in your area is sunny with a high of 27°C. Perfect for outdoor activities!

Would you like a 7-day forecast?
''',
        timestamp: DateTime.now().subtract(Duration(minutes: 7)),
        isUser: false,
      ),
      ChatMessageModel(
        id: 'msg1_5',
        senderId: 'user123',
        content:
            'No, thanks! Could you give me some motivational quotes instead?',
        timestamp: DateTime.now().subtract(Duration(minutes: 6)),
        isUser: true,
      ),
      ChatMessageModel(
        id: 'msg1_6',
        senderId: 'aiBot',
        content: '''
> "Success is not final, failure is not fatal: it is the courage to continue that counts."
>
> - Winston Churchill

Keep pushing forward!
''',
        timestamp: DateTime.now().subtract(Duration(minutes: 5)),
        isUser: false,
      ),
      ChatMessageModel(
        id: 'msg1_7',
        senderId: 'user123',
        content:
            'That’s really inspiring! Can you help me with Dart programming?',
        timestamp: DateTime.now().subtract(Duration(minutes: 4)),
        isUser: true,
      ),
      ChatMessageModel(
        id: 'msg1_9',
        senderId: 'user123',
        content: 'Thanks for the tips! What’s the best way to learn Dart?',
        timestamp: DateTime.now().subtract(Duration(minutes: 3)),
        isUser: true,
      ),
      ChatMessageModel(
        id: 'msg1_10',
        senderId: 'aiBot',
        content: '''
## Learning Resources for Dart

1. **Official Dart Documentation**: A great starting point for understanding Dart's features.
2. **Online Courses**: Platforms like Udemy and Coursera offer comprehensive courses.
3. **Practice Projects**: Build small projects to apply what you learn.

Consistent practice is key!
''',
        timestamp: DateTime.now().subtract(Duration(minutes: 2)),
        isUser: false,
      ),
      ChatMessageModel(
        id: 'msg1_11',
        senderId: 'user123',
        content:
            'Got it! Can you explain what Flutter is? Is it related to Dart?',
        timestamp: DateTime.now().subtract(Duration(minutes: 1)),
        isUser: true,
      ),
      ChatMessageModel(
        id: 'msg1_12',
        senderId: 'aiBot',
        content: '''
# What is Flutter?

Flutter is an open-source UI software development toolkit created by Google. It allows developers to create natively compiled applications for mobile, web, and desktop from a single codebase. It is built with Dart and provides beautiful, fast UIs with rich components.

## Key Features:
- **Hot Reload**: Instantly see changes in your app without restarting it.
- **Expressive UI**: Create visually attractive apps using customizable widgets.

Would you like to learn how to set up Flutter?
''',
        timestamp: DateTime.now(),
        isUser: false,
      ),
    ],
    createdAt: DateTime.now().subtract(Duration(days: 1)),
    updatedAt: DateTime.now(),
  ),
  ChatRoomModel(
    id: '2',
    title: 'Chat about Health and Fitness',
    messages: [
      ChatMessageModel(
        id: 'msg2_1',
        senderId: 'user456',
        content: 'Hey! What are some good workouts for beginners?',
        timestamp: DateTime.now().subtract(Duration(minutes: 15)),
        isUser: true,
      ),
      ChatMessageModel(
        id: 'msg2_2',
        senderId: 'aiBot',
        content: '''
## Beginner Workouts

Here are a few beginner-friendly workouts:

1. **Bodyweight Squats**: Great for legs.
2. **Push-ups**: Start with knee push-ups if necessary.
3. **Plank**: Hold for 20-30 seconds to strengthen your core.

Make sure to warm up before starting your workout!
''',
        timestamp: DateTime.now().subtract(Duration(minutes: 14)),
        isUser: false,
      ),
      ChatMessageModel(
        id: 'msg2_3',
        senderId: 'user456',
        content: 'How often should I work out per week?',
        timestamp: DateTime.now().subtract(Duration(minutes: 13)),
        isUser: true,
      ),
      ChatMessageModel(
        id: 'msg2_4',
        senderId: 'aiBot',
        content: '''
## Workout Frequency

For beginners, it's recommended to work out:

- **3 to 4 times a week**: This allows for recovery and muscle building.
- **Incorporate rest days**: Give your body time to heal.

Listen to your body and adjust your routine as needed!
''',
        timestamp: DateTime.now().subtract(Duration(minutes: 12)),
        isUser: false,
      ),
      ChatMessageModel(
        id: 'msg2_5',
        senderId: 'user456',
        content: 'What should I eat before and after workouts?',
        timestamp: DateTime.now().subtract(Duration(minutes: 11)),
        isUser: true,
      ),
//       ChatMessageModel(
//         id: 'msg2_6',
//         senderId: 'aiBot',
//         content: '''
// ## Nutrition Tips
//
// **Before Workout**:
// - Eat a light snack rich in carbohydrates (like a banana or toast) to fuel your workout.
//
// **After Workout**:
// - Focus on protein-rich foods (like chicken, fish, or legumes) to help with recovery.
// - Hydrate well!
//
// Nutrition is crucial for optimal performance and recovery!
// ''',
//         timestamp: DateTime.now().subtract(Duration(minutes: 10)),
//         isUser: false,
//       ),
      ChatMessageModel(
        id: 'msg2_6',
        senderId: 'aiBot',
        content:
            " ```python\nimport matplotlib.pyplot as plt\n\n# Sample data for the top 4 states based on vegetarian and non-vegetarian percentages\nstates = ['Gujarat', 'Punjab', 'Kerala', 'West Bengal']\nvegetarian_percentage = [60, 50, 30, 20]\nnon_vegetarian_percentage = [40, 50, 70, 80]\n\n# Bar width\nbar_width = 0.35\nindex = range(len(states))\n\n# Creating the bar chart\nfig, ax = plt.subplots()\n\nbar1 = ax.bar(index, vegetarian_percentage, bar_width, label='Vegetarian', color='green')\nbar2 = ax.bar([i + bar_width for i in index], non_vegetarian_percentage, bar_width, label='Non-Vegetarian', color='red')\n\n# Adding labels and title\nax.set_xlabel('States')\nax.set_ylabel('Percentage')\nax.set_title('Vegetarian vs Non-Vegetarian Population in Top 4 States')\nax.set_xticks([i + bar_width / 2 for i in index])\nax.set_xticklabels(states)\nax.legend()\n\n# Displaying the chart\nplt.tight_layout()\nplt.show()\n``` ",
        timestamp: DateTime.now().subtract(Duration(minutes: 10)),
        isUser: false,
      ),
    ],
    createdAt: DateTime.now().subtract(Duration(days: 2)),
    updatedAt: DateTime.now(),
  )
];
