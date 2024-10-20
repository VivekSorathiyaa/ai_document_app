import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:ai_document_app/utils/input_text_field_widget.dart';
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

// @JS('extractTextFromPDF')
// external dynamic extractTextFromPDF(String pdfUrl);

class ChatController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference collectionDocuments =
      FirebaseFirestore.instance.collection('documents');

  Rxn<ChatModel> currentChatRoom = Rxn<ChatModel>();
  final TextEditingController chatRoomNameController = TextEditingController();
  final TextEditingController messageTextController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  var currentIndex = 0.obs;
  // var selectedDocumentsId = <String>[].obs;
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

  RxList<ChatModel> selectedChatList = <ChatModel>[].obs;
  RxList<DocumentModel> selectedDocumentList = <DocumentModel>[].obs;

  RxBool loading = false.obs;

  void listenToChatRooms() {
    FirebaseFirestore.instance
        .collection('chat_rooms')
        .where('participants',
            arrayContains: CommonMethod.auth.currentUser?.email)
        .snapshots()
        .listen((snapshot) {
      // Convert the documents into ChatModel instances
      List<ChatModel> chatRooms =
          snapshot.docs.map((doc) => ChatModel.fromFirestore(doc)).toList();

      // Assign the converted list to your chatRoomList
      chatRoomList.assignAll(chatRooms);
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

          log("-----documents------$documentIds");

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
    FirebaseFirestore.instance
        .collection('documents')
        .where('uploaded_by', isEqualTo: CommonMethod.auth.currentUser?.email)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      documentsList.assignAll(snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return DocumentModel(
          id: doc.id,
          name: data['name'] ?? '',
          url: data['url'] ?? '',
          status: data['upload_status'] ?? 'Unknown',
          uploadedBy: data['uploaded_by'] ?? '',
          size: data['size']?.toDouble() ?? 0.0,
          date: data['timestamp']?.toDate().toString() ??
              '', // Adjust date format as needed
          actions: 'Action ${doc.id}', // Or set this based on your needs
        );
      }).toList());

      documentsList.refresh();
      listenToSelectedDocuments();
    });
  }

  void fetchMessages(String chatRoomId) {
    if (chatRoomId.isNotEmpty) {
      firestore
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .listen((snapshot) {
        // Convert the documents into MessageModel instances
        List<MessageModel> messages = snapshot.docs
            .map((doc) =>
                MessageModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList();

        // Assign the converted list to your messagesList
        messagesList.assignAll(messages);
        messagesList.refresh(); // Refresh to notify listeners about the changes
      });
    }
  }

  void setCurrentChatRoomId(ChatModel model) {
    currentChatRoom.value = model;
    currentChatRoom.refresh();
    fetchMessages(currentChatRoom.value?.id ??
        ""); // Fetch messages whenever the current chat room ID is set
    refreshPage();
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
        // Document exists, proceed with the update
        // Get the selected document IDs and remove duplicates
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
    listenToChatRooms();
    fetchDocuments();
    fetchApiKey();
    initializeChatRoom();
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

  Future<void> sendMessage(
      {required String message,
      required String chatRoomId,
      required String userId}) async {
    if (message.trim().isEmpty) {
      return;
    }

    try {
      await firestore
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .add({
        'text': message,
        'senderId': userId,
        'timestamp': FieldValue.serverTimestamp(),
      });

      final botMessage = await geminiGenerateBotResponse(message);

      if (botMessage != null && loading.value == false) {
        await firestore
            .collection('chat_rooms')
            .doc(chatRoomId)
            .collection('messages')
            .add({
          'text': botMessage,
          'senderId': 'Bot',
          'timestamp': FieldValue.serverTimestamp(),
        });
        scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } else {
        // CommonMethod.getXSnackBar(
        //     "Error", 'Failed to get response from the bot.', redColor);
      }
    } catch (e) {
      CommonMethod.getXSnackBar("Error", 'Error sending message.');
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
      log("----storedExtractedText----${storedExtractedText}");
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
      log("----storedExtractedText----${storedExtractedText}");

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

  void showEditChatRoomNameDialog(DocumentSnapshot chatRoom) {
    chatRoomNameController.text = chatRoom['name'];

    Get.defaultDialog(
      title: 'Edit Conversation Name',
      titlePadding: EdgeInsets.all(20),
      titleStyle: AppTextStyle.normalBold20.copyWith(color: primaryBlack),
      content: Padding(
        padding: const EdgeInsets.all(20),
        child: TextFormFieldWidget(
          controller: chatRoomNameController,
          hintText: 'Enter new name',
          labelText: 'Name',
        ),
      ),
      confirm: ElevatedButton(
        onPressed: () async {
          if (chatRoomNameController.text.isNotEmpty) {
            await CommonMethod.updateChatRoomName(
                chatRoom.id, chatRoomNameController.text);
            Get.back(); // Close the dialog
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlack,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
        ),
        child: Text(
          'Save',
          style: AppTextStyle.normalBold16.copyWith(color: primaryWhite),
        ),
      ),
      cancel: TextButton(
        onPressed: () {
          Get.back(); // Close the dialog
        },
        child: Text(
          'Cancel',
          style: AppTextStyle.normalBold16.copyWith(color: primaryBlack),
        ),
      ),
      barrierDismissible:
          false, // Prevent closing the dialog by tapping outside
      radius: 12, // Rounded corners for the dialog
      backgroundColor: Colors.white,
    );
  }

  void showCreateChatRoomDialog() {
    Get.defaultDialog(
      title: 'Create New Conversation',
      titlePadding: EdgeInsets.all(20),

      titleStyle: AppTextStyle.normalBold20.copyWith(color: primaryBlack),
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormFieldWidget(
              controller: chatRoomNameController,
              hintText: 'Enter conversation name',
              labelText: 'Name',
            ),
          ),
        ],
      ),
      confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlack,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
        ),
        onPressed: () async {
          if (chatRoomNameController.text.isNotEmpty) {
            ChatModel model =
                await CommonMethod.createChatRoom(chatRoomNameController.text);
            Get.back();
            setCurrentChatRoomId(model);
            chatRoomNameController.clear();
          }
        },
        child: Text(
          "Create",
          style: AppTextStyle.normalBold16.copyWith(color: primaryWhite),
        ),
      ),
      cancel: TextButton(
        onPressed: () {
          Get.back(); // Close the dialog
        },
        child: Text(
          'Cancel',
          style: AppTextStyle.normalBold16.copyWith(color: primaryBlack),
        ),
      ),
      barrierDismissible:
          false, // Prevent closing the dialog by tapping outside
      radius: 12, // Rounded corners for the dialog
      backgroundColor: Colors.white,
    );
  }

  Future<void> showDeleteChatRoomDialog(DocumentSnapshot chatRoom) async {
    Get.defaultDialog(
      title: 'Delete Conversation',
      titlePadding: EdgeInsets.all(20),
      titleStyle: AppTextStyle.normalBold20.copyWith(color: primaryBlack),
      content: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          'Are you sure you want to delete this conversation?',
          style: AppTextStyle.normalBold16.copyWith(color: primaryBlack),
        ),
      ),
      confirm: ElevatedButton(
        onPressed: () async {
          await CommonMethod.deleteChatRoom(chatRoom.id);
          Get.back(); // Close the dialog after deletion
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlack,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
        ),
        child: Text(
          'Delete',
          style: AppTextStyle.normalBold16.copyWith(color: primaryWhite),
        ),
      ),
      cancel: TextButton(
        onPressed: () {
          Get.back(); // Close the dialog
        },
        child: Text(
          'Cancel',
          style: AppTextStyle.normalBold16.copyWith(color: primaryBlack),
        ),
      ),
      barrierDismissible:
          false, // Prevent closing the dialog by tapping outside
      radius: 12, // Rounded corners for the dialog
      backgroundColor: Colors.white,
    );
  }

  Future<void> initializeChatRoom() async {
    // Fetch chat rooms where the current user is a participant
    QuerySnapshot chatRoomsSnapshot = await firestore
        .collection('chat_rooms')
        .where('participants',
            arrayContains: CommonMethod.auth.currentUser?.email)
        .get();

    if (chatRoomsSnapshot.docs.isNotEmpty) {
      // If currentChatRoom is not set, assign the first chat room
      currentChatRoom.value ??=
          ChatModel.fromFirestore(chatRoomsSnapshot.docs.first);
    } else {
      ChatModel newChatRoom =
          await CommonMethod.createChatRoom('New Conversation');
      currentChatRoom.value = newChatRoom; // Set the current chat room
    }
    // Fetch messages for the current chat room
    fetchMessages(currentChatRoom.value?.id ?? '');
    update();
  }

  // Future<void> initializeChatRoom() async {
  //   QuerySnapshot chatRoomsSnapshot = await firestore
  //       .collection('chat_rooms')
  //       .where('participants',
  //           arrayContains: CommonMethod.auth.currentUser?.email)
  //       .get();
  //
  //   if (chatRoomsSnapshot.docs.isNotEmpty) {
  //     if (currentChatRoom.value == null) {
  //       currentChatRoom.value = chatRoomsSnapshot.docs.first;
  //       currentChatRoomName.value = chatRoomsSnapshot.docs.first['name'];
  //     }
  //   } else {
  //     String newChatRoomId =
  //         await CommonMethod.createChatRoom('New Conversation');
  //
  //     currentChatRoomId.value = newChatRoomId;
  //     currentChatRoomName.value = 'New Conversation';
  //   }
  //   fetchMessages(currentChatRoomId.value.toString());
  //   clearSelectedDocuments();
  //   update();
  // }

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

  Future<DocumentSnapshot?> getDocumentById(String documentId) async {
    try {
      DocumentSnapshot snapshot =
          await collectionDocuments.doc(documentId).get();
      if (snapshot.exists) {
        return snapshot;
      } else {
        print('Document does not exist');
        return null;
      }
    } catch (e) {
      print('Error fetching document: $e');
      return null;
    }
  }

  void setCurrentIndex(int index) {
    currentIndex.value = index;
  }
}
