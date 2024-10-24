import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:ai_document_app/utils/input_text_field_widget.dart';
import 'package:ai_document_app/utils/primary_text_button.dart';
import 'package:ai_document_app/utils/static_decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// import 'package:js/js.dart';

import '../model/chat_model.dart';
import '../model/document_model.dart';
import '../model/suggestion_model.dart';
import '../utils/app_text_style.dart';
import '../utils/color.dart';
import '../utils/common_method.dart';

class ChatController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference collectionDocuments =
      FirebaseFirestore.instance.collection('documents');
  Rxn<ChatModel> currentChatRoom = Rxn<ChatModel>();
  TextEditingController chatRoomNameController = TextEditingController();
  TextEditingController messageTextController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  var currentIndex = 0.obs;
  var extractedTextList = <String>[].obs;
  var messagesList = <MessageModel>[].obs;
  RxList<ChatModel> chatRoomList = <ChatModel>[].obs;
  RxList<DocumentModel> documentsList = <DocumentModel>[].obs;
  RxnString geminiApiKey = RxnString();
  RxnString openaiApiKey = RxnString();

  RxList<SuggestionModel> suggestionList = RxList<SuggestionModel>([
    SuggestionModel(id: '1', name: "Write summary of book?"),
    SuggestionModel(id: '2', name: "Write summary of book?"),
    SuggestionModel(id: '3', name: "Write summary of book?"),
    SuggestionModel(id: '4', name: "Write summary of book?"),
    SuggestionModel(id: '5', name: "Write summary of book?"),
    SuggestionModel(id: '6', name: "Write summary of book?"),
    SuggestionModel(id: '7', name: "Write summary of book?"),
    SuggestionModel(id: '8', name: "Write summary of book?"),
  ]);

  RxList<DocumentModel> selectedDocumentList = <DocumentModel>[].obs;
  RxBool loading = false.obs;

  void listenToChatRooms() {
    final userEmail = CommonMethod.auth.currentUser?.email;
    if (userEmail == null || userEmail.isEmpty) {
      print("No user email found for chat room listener.");
      return;
    }
    FirebaseFirestore.instance
        .collection('chat_rooms')
        .where('participants', arrayContains: userEmail)
        .snapshots()
        .listen((snapshot) {
      final List<ChatModel> chatRooms = snapshot.docs
          .map((doc) => ChatModel.fromFirestore(doc))
          .where((chatRoom) => chatRoom != null)
          .toList();
      if (chatRoomList.length != chatRooms.length ||
          !chatRoomList.every((room) => chatRooms.contains(room))) {
        chatRoomList.assignAll(chatRooms);
      }
    });
  }

  void listenToSelectedDocuments() {
    if (currentChatRoom.value != null) {
      FirebaseFirestore.instance
          .collection('chat_rooms')
          .doc(currentChatRoom.value!.id)
          .snapshots()
          .listen((documentSnapshot) async {
        if (documentSnapshot.exists) {
          final data = documentSnapshot.data() as Map<String, dynamic>?;

          // Get the list of document IDs, ensuring they are unique
          final List<dynamic> documents = data?['selected_documents'] ?? [];
          List<String> documentIds = List<String>.from(documents.toSet());

          // Fetch all documents at once using a batched get request
          if (documentIds.isNotEmpty) {
            List<DocumentSnapshot> snapshots = await FirebaseFirestore.instance
                .collection('documents')
                .where(FieldPath.documentId, whereIn: documentIds)
                .get()
                .then((querySnapshot) => querySnapshot.docs);

            // Map the snapshots to DocumentModel
            List<DocumentModel> documentModel = snapshots
                .map((snapshot) => DocumentModel.fromFirestore(snapshot))
                .toList();
            documentsList.refresh();
            selectedDocumentList.value = documentModel;
            selectedDocumentList.refresh();
            getDocumentsByIdList();
            update();
          }
        } else {
          log("Document does not exist.");
        }
      }, onError: (error) {
        log("Error listening to chat room: $error");
      });
    }
  }

  void fetchDocuments() {
    final userEmail = CommonMethod.auth.currentUser?.email;

    if (userEmail == null || userEmail.isEmpty) {
      print("No user email found for fetching documents.");
      return;
    }

    FirebaseFirestore.instance
        .collection('documents')
        .where('uploaded_by', isEqualTo: userEmail)
        // Fetch only the necessary fields for performance
        .orderBy('timestamp', descending: true)
        // Add a limit to fetch only a specific number of documents (for pagination if needed)
        //.limit(20)
        .snapshots()
        .listen((snapshot) {
      // Map Firestore documents to DocumentModel efficiently
      final List<DocumentModel> fetchedDocuments = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return DocumentModel(
          id: doc.id,
          name: data['name'] ?? '',
          url: data['url'] ?? '',
          status: data['upload_status'] ?? 'Unknown',
          uploadedBy: data['uploaded_by'] ?? '',
          size: (data['size'] as num?)?.toDouble() ?? 0.0,
          date: data['timestamp']?.toDate().toString() ?? '',
          actions: 'Action ${doc.id}', // Customize this action field as needed
        );
      }).toList();

      // Update documentsList only if there are changes
      if (documentsList.length != fetchedDocuments.length ||
          !documentsList.every((doc) => fetchedDocuments.contains(doc))) {
        documentsList.assignAll(fetchedDocuments);
      }

      listenToSelectedDocuments(); // Only if needed
    });
  }

  void fetchMessages(String chatRoomId) {
    print("-----chatRoomId-----$chatRoomId");
    if (chatRoomId.isNotEmpty) {
      messagesList.value.clear();
      firestore
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .listen((snapshot) {
        List<MessageModel> messages = snapshot.docs
            .map((doc) =>
                MessageModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList();
        messagesList.assignAll(messages);
        messagesList.refresh(); // Refresh to notify listeners about the changes
      });
    }
  }

  List<String> getSelectedDocumentIds() {
    return selectedDocumentList.value.map((doc) => doc.id).toList();
  }

  Future<void> updateSelectedDocumentsInFirestore() async {
    // Check if the currentChatRoomId is not null or empty
    if (currentChatRoom.value != null) {
      // Reference to the specific document
      DocumentReference chatRoomRef = FirebaseFirestore.instance
          .collection('chat_rooms')
          .doc(currentChatRoom.value?.id ?? "");

      // Fetch the document to see if it exists
      DocumentSnapshot snapshot = await chatRoomRef.get();
      if (snapshot.exists) {
        List<String> uniqueDocumentIds =
            getSelectedDocumentIds().toSet().toList();

        await chatRoomRef.update({
          'selected_documents': uniqueDocumentIds,
        }).catchError((error) {
          print("Failed to update selected documents: $error");
        });
      } else {
        // Document does not exist
        print("No document found with ID: ${currentChatRoom.value?.id ?? ""}");
      }
    } else {
      print("Current chat room ID is null or empty.");
    }
  }

  Future<void> refreshPage() async {
    getCurrentChatRoom();
    listenToChatRooms();
    fetchDocuments();
    fetchApiKey();
  }

  Future<void> fetchApiKey() async {
    try {
      DocumentSnapshot snapshot =
          await firestore.collection('api_keys').doc('api_keys').get();

      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          if (data.containsKey('openaiApiKey')) {
            openaiApiKey.value = data['openaiApiKey'] as String;
          } else {
            CommonMethod.getXSnackBar("Error", "OpenAI API key not found.");
            return;
          }
          if (data.containsKey('geminiApiKey')) {
            geminiApiKey.value = data['geminiApiKey'] as String;
          } else {
            CommonMethod.getXSnackBar("Error", "Gemini API key not found.");
            return;
          }
        } else {
          CommonMethod.getXSnackBar("Error", "API key data is null.");
          return;
        }
      } else {
        CommonMethod.getXSnackBar("Error", "API key document not found.");
        return;
      }
    } catch (e) {
      CommonMethod.getXSnackBar(
          "Error", "Error fetching API key: ${e.toString()}");
      return;
    }
  }

  Future<void> sendMessage({
    required String message,
    required String chatRoomId,
    required String userId,
  }) async {
    print("---message---->$message");
    print("----chatRoomId--->$chatRoomId");
    print("----userId--->$userId");
    if (message.trim().isEmpty) {
      return;
    }

    try {
      // Prepare to send user message
      DocumentReference userMessageRef = firestore
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .doc(); // Generate a new document reference for the user message

      // Set the user message immediately
      await userMessageRef.set({
        'text': message,
        'senderId': userId,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Generate bot response if loading is false
      if (!loading.value) {
        final botMessage = await geminiGenerateBotResponse(message);
        if (botMessage != null) {
          // Prepare bot message
          DocumentReference botMessageRef = firestore
              .collection('chat_rooms')
              .doc(chatRoomId)
              .collection('messages')
              .doc(); // Generate a new document reference for the bot message

          // Set the bot message
          await botMessageRef.set({
            'text': botMessage,
            'senderId': 'Bot',
            'timestamp': FieldValue.serverTimestamp(),
          });
        }
      }

      // Scroll only if needed
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    } catch (e) {
      CommonMethod.getXSnackBar("Error", 'Error sending message: $e');
    }
  }

  Future<String?> openAigenerateBotResponse(String message) async {
    try {
      String? storedExtractedText;
      String customMessage;
      if (openaiApiKey.value == null || openaiApiKey.value!.isEmpty) {
        var error = "Error: API Key is missing.";
        CommonMethod.getXSnackBar("Error", error);
        return null;
      }
      String extractedText = extractedTextList.value.join("\n");
      storedExtractedText = extractedText;
      // log("----storedExtractedText----${storedExtractedText}");
      customMessage = message;
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${openaiApiKey.value}', // Use the API key
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo-0125',
          'messages': [
            {
              'role': 'system',
              'content': 'You are an intelligent assistant designed to answer questions strictly based on the provided document. '
                  'You should only use the information in the document to answer questions. '
                  'If the answer cannot be found in the document, respond with "The answer is not available in the provided document." '
                  'Document text: \n${storedExtractedText}'
            },
            {'role': 'user', 'content': customMessage},
          ],
        }),
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final String formattedJson =
            JsonEncoder.withIndent('  ').convert(jsonResponse);
        log("-----chatgpt-----${formattedJson}");
        return jsonResponse['choices'][0]['message']['content'];
      } else {
        var error = "Error: ${response.statusCode} - ${response.body}";
        log(error);
        CommonMethod.getXSnackBar(
          "Error",
          error,
        );
        return null;
      }
    } catch (e) {
      var error = "Error in generateBotResponse: $e";
      log(error);
      CommonMethod.getXSnackBar("Error", error);
      return null;
    }
  }

  Future<String?> geminiGenerateBotResponse(String message) async {
    try {
      String? storedExtractedText;

      if (geminiApiKey.value == null || geminiApiKey.value!.isEmpty) {
        var error = "Error: Gemini API Key is missing.";
        CommonMethod.getXSnackBar("Error", error);
        return null;
      }

      String extractedText = extractedTextList.value.join("\n");
      storedExtractedText = extractedText;
      // log("----storedExtractedText----${storedExtractedText}");

      final requestBody = {
        'contents': [
          {
            'parts': [
              {
                'text': 'You are an intelligent assistant designed to answer questions strictly based on the provided document. '
                    'You should only use the information in the document to answer questions. '
                    'If the answer cannot be found in the document, respond with "The answer is not available in the provided document." '
                    'Document text: \n${storedExtractedText}\nUser question: \n$message'
              }
            ]
          }
        ]
      };

      final response = await http.post(
        Uri.parse(
            'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=${geminiApiKey.value}'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final String formattedJson =
            JsonEncoder.withIndent('  ').convert(jsonResponse);
        log("-----gemini-----${formattedJson}");
        return jsonResponse['candidates'][0]['content']['parts'][0]['text'];
      } else {
        var error = "Error: ${response.statusCode} - ${response.body}";
        log(error);
        CommonMethod.getXSnackBar("Error", error);
        return null;
      }
    } catch (e) {
      var error = "Error in geminiGenerateBotResponse: $e";
      log(error);
      CommonMethod.getXSnackBar("Error", error);
      return null;
    }
  }

  void showCreateChatRoomDialog(BuildContext context) {
    CommonMethod.showSimpleDialog(
        title: 'Create New Chat',
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextFormFieldWidget(
              controller: chatRoomNameController,
              hintText: 'Enter Chat Name',
              filledColor: primaryBlack,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 300,
              child: Row(
                children: [
                  Expanded(
                    child: PrimaryTextButton(
                      title: "Cancel",
                      gradientColors: const [bgBlackColor, bgBlackColor],
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  width10,
                  Expanded(
                    child: PrimaryTextButton(
                      title: "Create",
                      onPressed: () async {
                        if (chatRoomNameController.text.isNotEmpty) {
                          Get.back();
                          ChatModel model = await CommonMethod.createChatRoom(
                              chatRoomNameController.text);
                          print("-----------setCurrentChatRoomI-----1");
                          setCurrentChatRoomId(model);
                          chatRoomNameController.clear();
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        context: context);
  }

  void showEditChatDialog(BuildContext context, ChatModel chatModel) {
    chatRoomNameController.text = chatModel.name ?? "";
    CommonMethod.showSimpleDialog(
        title: 'Edit Conversation Name',
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextFormFieldWidget(
              controller: chatRoomNameController,
              hintText: 'Enter new name',
              filledColor: primaryBlack,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 300,
              child: Row(
                children: [
                  Expanded(
                    child: PrimaryTextButton(
                      title: "Cancel",
                      gradientColors: const [bgBlackColor, bgBlackColor],
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  width10,
                  Expanded(
                    child: PrimaryTextButton(
                      title: "Create",
                      onPressed: () async {
                        if (chatRoomNameController.text.isNotEmpty) {
                          Get.back();
                          if (chatRoomNameController.text.isNotEmpty) {
                            await CommonMethod.updateChatRoomName(
                                chatModel.id ?? "",
                                chatRoomNameController.text);
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        context: context);
  }

  Future<void> showDeleteChatDialog(
      BuildContext context, ChatModel chatModel) async {
    CommonMethod.showSimpleDialog(
        title: 'Delete Conversation',
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: SelectableText(
                'Are you sure you want to delete this conversation?',
                style: AppTextStyle.normalBold16.copyWith(color: primaryWhite),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 300,
              child: Row(
                children: [
                  Expanded(
                    child: PrimaryTextButton(
                      title: "Cancel",
                      gradientColors: const [bgBlackColor, bgBlackColor],
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  width10,
                  Expanded(
                    child: PrimaryTextButton(
                      title: "Delete",
                      onPressed: () async {
                        await CommonMethod.deleteChatRoom(chatModel.id ?? "");
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        context: context);
  }

  Future<List<String>> getDocumentsByIdList() async {
    List<DocumentSnapshot<Object?>> documents = [];
    List<Future<DocumentSnapshot<Object?>>> fetchFutures = [];

    try {
      for (String documentId in getSelectedDocumentIds()) {
        fetchFutures.add(collectionDocuments.doc(documentId).get());
      }
      documents = await Future.wait(fetchFutures);

      // Extract text in a single pass
      List<String> extractedTexts = [];
      for (DocumentSnapshot<Object?> document in documents) {
        if (document.exists) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          String extractedText = data['extracted_text'] ?? '';
          extractedTexts.add(
              "****\n\n*${data['name']}*---->$extractedText-------****\n\n\n");
        } else {
          extractedTexts.add('');
        }
      }

      extractedTextList.assignAll(extractedTexts);
      extractedTextList.refresh();
    } catch (e) {
      print('Error fetching documents: $e');
    }

    return extractedTextList;
  }

  Future<void> setCurrentChatRoomId(ChatModel model) async {
    String userEmail = CommonMethod.auth.currentUser?.email ?? "";

    // Check if the user is authenticated
    if (userEmail.isEmpty) {
      print("Error: User is not authenticated.");
      CommonMethod.getXSnackBar("Error", 'User is not authenticated.');
      return; // Early exit if the user is not authenticated
    }

    // Check if the model is null
    if (model == null || model.id == null) {
      print("Error: Chat model or Chat ID is null.");
      CommonMethod.getXSnackBar("Error", 'Chat model or Chat ID is null.');
      return; // Early exit if the model or its ID is null
    }

    try {
      // Set the current chat room value and fetch messages
      currentChatRoom.value = model;
      currentChatRoom.refresh();
      fetchMessages(model.id!); // Use '!' to assert that model.id is not null

      DocumentReference userRef =
          firestore.collection('current_chat').doc(userEmail);
      DocumentSnapshot userChatSnapshot = await userRef.get();

      // Update or create the user document based on its existence
      if (userChatSnapshot.exists) {
        await userRef.update({
          'currentChatRoomId': model.id,
        });
        print("Current chat room ID updated successfully: ${model.id}");
      } else {
        await userRef.set({
          'currentChatRoomId': model.id,
        });
        print("Current chat room document created with ID: ${model.id}");
      }
    } catch (e) {
      // Handle errors during Firestore operations
      print("Failed to set current chat room ID: $e");
      CommonMethod.getXSnackBar(
          "Error", 'Failed to set current chat room ID: $e');
    }
  }

  Future getCurrentChatRoom() async {
    try {
      if (currentChatRoom.value != null) {
        return;
      }
      final userEmail = CommonMethod.auth.currentUser?.email ?? "";
      if (userEmail.isEmpty) {
        print("No user email found.");
        return null;
      }

      final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await firestore.collection('current_chat').doc(userEmail).get();
      final data = userSnapshot.data();

      if (data != null && data['currentChatRoomId'] != null) {
        final String currentChatRoomId = data['currentChatRoomId'];
        ChatModel? model = await getChatModelById(currentChatRoomId);
        if (model != null) {
          setCurrentChatRoomId(model);
        }

        return;
      } else {
        print("No current chat room found. Creating a new chat room.");
        if (currentChatRoom.value == null) {
          ChatModel? model = await CommonMethod.createChatRoom('New Chat');
          if (model != null) {
            setCurrentChatRoomId(model);
          }
          return;
        }
      }
    } catch (e) {
      print("Error retrieving current chat room ID: $e");
      return null;
    }
  }

  Future<ChatModel?> getChatModelById(String chatId) async {
    try {
      DocumentSnapshot chatSnapshot =
          await firestore.collection('chat_rooms').doc(chatId).get();

      if (chatSnapshot.exists && chatSnapshot.data() != null) {
        return ChatModel.fromFirestore(chatSnapshot);
      } else {
        return await CommonMethod.createChatRoom('New Chat');
      }
    } catch (e) {
      print("---Error retrieving chat room by ID: $e");
      return null;
    }
  }
}
