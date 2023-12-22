import 'package:flutter_application_1/services/data/chat_data.dart';
import 'package:flutter_application_1/services/data/friend_data.dart';
import 'package:flutter_application_1/services/services/chat_services/services/auth_services.dart';
import 'package:flutter_application_1/services/services/chat_services/services/friend_services.dart';
import 'package:flutter_application_1/services/services/chat_services/services/user_services.dart';

import 'services/chat_services.dart';

class ChatManager {
  // Private constructor to prevent external instantiation
  ChatManager._privateConstructor();
  // Static instance variable for the singleton
  static final ChatManager _instance = ChatManager._privateConstructor();

  // Factory constructor to provide access to the instance
  factory ChatManager() {
    return _instance;
  }

  Future<void> createUser(String email, String password) async =>
      await AuthSrvices().createUser(email: email, password: password);

  Future<void> login(String email, String password) async =>
      await AuthSrvices().login(email: email, password: password);

  Future<void> createUserData(
          String email, String name, String lastname) async =>
      await UserServices().createUser(email, name, lastname);

  Future<void> getUserData() async => await UserServices().getUserData();

  Future<void> addFriend(String friendId) async =>
      await FriendsService().addFriend(friendId);

  Stream<List<FriendData>> getFriends() => FriendsService().getFreinds();

  Stream<List<ChatData>> getMessages(String friendId) =>
      ChatService().getMessages(friendId);

  Future<void> sendMessage(String message, String friendId) async =>
      await ChatService().sendMessage(message, friendId);
  
  void updateMessage(String friendId) =>
  ChatService().updateMessageStream(friendId);
}
