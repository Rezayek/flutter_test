import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/services/data/friend_data.dart';

import '../../data/chat_data.dart';

@immutable
abstract class ChatState {
  final bool isLoading;
  final String loadingText;
  final Exception? exception;
  const ChatState({
    required this.isLoading,
    this.loadingText = 'Processing...',
    this.exception,
  });
}

class ChatStateLogin extends ChatState {
  const ChatStateLogin({required super.isLoading});
}

class ChatStateSignUp extends ChatState {
  const ChatStateSignUp({required super.isLoading});
}

class ChatStateChatInit extends ChatState {
  final Stream<List<ChatData>> chatData;
  final Stream<List<FriendData>> friendsData;
  const ChatStateChatInit({required this.chatData, required this.friendsData, required super.isLoading, });
}
