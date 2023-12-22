import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/services/data/chat_data.dart';

import '../../../data/user_data.dart';
import '../../generic_service/firebase_service.dart';

class ChatService {
  // Private constructor to prevent external instantiation
  ChatService._privateConstructor();
  // Static instance variable for the singleton
  static final ChatService _instance = ChatService._privateConstructor();

  // Factory constructor to provide access to the instance
  factory ChatService() {
    return _instance;
  }

  final StreamController<List<ChatData>> _chatController =
      StreamController<List<ChatData>>.broadcast();

  Stream<List<ChatData>> getMessages(String friendId) {
    _fetchMessges(friendId);
    return _chatController.stream;
  }

  void updateMessageStream(String friendId) async {
    await _fetchMessges(friendId);
  }

  Future<void> sendMessage(String message, String friendId) async {
    await FirebaseService().chatCollection.add({
      'sender_id': UserData().userId,
      'reciever_id': friendId,
      'message': message,
    });
  }

  Future<void> _fetchMessges(String friendId) async {
    List<ChatData> messages = [];
    final currentUserID = UserData().userId;
    FirebaseService()
        .chatCollection
        .where(Filter.or(
          Filter.and(
            Filter("sender_id", isEqualTo: friendId),
            Filter("reciever_id", isEqualTo: currentUserID),
          ),
          Filter.and(
            Filter("sender_id", isEqualTo: currentUserID),
            Filter("reciever_id", isEqualTo: friendId),
          ),
        ))
        .snapshots()
        .listen((event) async {
      messages.clear();
      for (var e in event.docs) {
        messages.add(ChatData.fromSnapshot(e));
      }

      if (messages.isNotEmpty) {
        _chatController.sink.add(messages);
      }
    });
  }
}
