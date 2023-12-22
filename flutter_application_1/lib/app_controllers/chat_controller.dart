import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_interface/views/sub_views/user_login.dart';
import 'package:flutter_application_1/app_interface/views/sub_views/user_signUp.dart';
import 'package:flutter_application_1/services/blocs/chat_bloc/chat_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_interface/views/sub_views/chat_friends.dart';
import '../services/blocs/chat_bloc/chat_bloc.dart';
import '../services/blocs/chat_bloc/chat_state.dart';

class ChatController extends StatefulWidget {
  const ChatController({super.key});

  @override
  State<ChatController> createState() => _ChatControllerState();
}

class _ChatControllerState extends State<ChatController> {
  @override
  Widget build(BuildContext context) {
    context.read<ChatBloc>().add(const ChatEventLoginInit());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state is ChatStateLogin) {
              return const UserLogin();
            } else if (state is ChatStateSignUp) {
              return const UserSignUp();
            } else if (state is ChatStateChatInit) {
              return ChatFriends(
                friends: state.friendsData,messages: state.chatData,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
