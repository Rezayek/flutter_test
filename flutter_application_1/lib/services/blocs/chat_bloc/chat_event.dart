import 'package:flutter/foundation.dart';

@immutable
abstract class ChatEvent {
  const ChatEvent();
}

class ChatEventLogin extends ChatEvent {
  final String email;
  final String password;

  const ChatEventLogin({required this.email, required this.password});
}

class ChatEventSignUp extends ChatEvent {
  final String email;
  final String password;
  final String nom;
  final String prenom;
  const ChatEventSignUp({required this.email, required this.password, required this.nom, required this.prenom});
}

class ChatEventLoginInit extends ChatEvent {
  const ChatEventLoginInit();
}

class ChatEventSignUpInit extends ChatEvent {

  const ChatEventSignUpInit();
}

class ChatEventInit extends ChatEvent {
  const ChatEventInit();
}

class ChatEventSendMessage extends ChatEvent {
  final String recieverId;
  final String message;

  const ChatEventSendMessage({required this.message, required this.recieverId});
}

class ChatEventSwithChat extends ChatEvent {
  final String friendId;

  const ChatEventSwithChat({required this.friendId});
}

class ChatEventSendFriendRequest extends ChatEvent {
  final String friendId;

  const ChatEventSendFriendRequest({required this.friendId});
}
