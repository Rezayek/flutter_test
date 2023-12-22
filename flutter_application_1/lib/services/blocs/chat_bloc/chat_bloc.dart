import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/services/blocs/chat_bloc/chat_event.dart';

import '../../services/chat_services/chat_manager.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(ChatManager chatManager)
      : super(const ChatStateLogin(isLoading: false)) {
    on<ChatEventLogin>((event, emit) async {
      emit(const ChatStateLogin(isLoading: true));
      await chatManager.login(event.email, event.password);
      emit(const ChatStateLogin(isLoading: false));
      await chatManager.getUserData();

      emit(ChatStateChatInit(
          chatData: chatManager.getMessages(""),
          friendsData: chatManager.getFriends(),
          isLoading: true));
    });

    on<ChatEventSignUp>(
      (event, emit) async {
        emit(const ChatStateSignUp(isLoading: true));
        await chatManager.createUser(event.email, event.password);
        await chatManager.createUserData(event.email, event.nom, event.prenom);
        emit(const ChatStateSignUp(isLoading: false));
        emit(const ChatStateLogin(isLoading: false));
      },
    );

    on<ChatEventLoginInit>(
      (event, emit) => emit(const ChatStateLogin(isLoading: false)),
    );

    on<ChatEventSignUpInit>(
      (event, emit) => emit(const ChatStateSignUp(isLoading: false)),
    );

    on<ChatEventSendMessage>(
      (event, emit) async {
        await chatManager.sendMessage(event.message, event.recieverId);
      },
    );

    on<ChatEventSwithChat>(
      (event, emit) {
        chatManager.updateMessage(event.friendId);
      },
    );
  }
}


//CAMpAozm4gNtsmxKqHXXQWSW1mF3
//2PODv5fSRsfdaFbuMJKOhgILgDY2

//sender_id
//reciever_id
//message