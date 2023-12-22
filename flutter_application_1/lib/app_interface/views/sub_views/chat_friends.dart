import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_interface/custom_widgets/button_widget.dart';
import 'package:flutter_application_1/app_interface/custom_widgets/friends_widget.dart';
import 'package:flutter_application_1/app_interface/custom_widgets/message_input_widget.dart';
import 'package:flutter_application_1/app_interface/custom_widgets/messages_widget.dart';
import 'package:flutter_application_1/constants/app_colors.dart';
import 'package:flutter_application_1/services/blocs/chat_bloc/chat_event.dart';
import 'package:flutter_application_1/services/data/chat_data.dart';
import 'package:flutter_application_1/services/data/friend_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../services/blocs/chat_bloc/chat_bloc.dart';

class ChatFriends extends StatefulWidget {
  final Stream<List<FriendData>> friends;
  final Stream<List<ChatData>> messages;
  const ChatFriends({super.key, required this.friends, required this.messages});

  @override
  State<ChatFriends> createState() => _ChatFriendsState();
}

class _ChatFriendsState extends State<ChatFriends> {
  late TextEditingController _messageContoller;
  late String _currentFriend;
  @override
  void initState() {
    super.initState();
    _currentFriend = "";
    _messageContoller = TextEditingController();
  }

  @override
  void dispose() {
    _messageContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 87.h,
      width: 100.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _friendWidget(),
          MessageWidget(height: 65.h, width: 95.w, messages: widget.messages),
          _sendWidget(),
        ],
      ),
    );
  }

  Widget _friendWidget() {
    return SizedBox(
      height: 8.h,
      width: 100.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FriendsWidget(
            height: 8.h,
            width: 75.w,
            friends: widget.friends,
            onTap: (recieverId) {
              setState(() {
                _currentFriend = recieverId; 
              });
              context.read<ChatBloc>().add(ChatEventSwithChat(friendId: _currentFriend));
            },
          ),
          ButtonWidget(
            height: 8.h,
            width: 20.w,
            text: "Add",
            fontSize: 19.sp,
            fontWeight: FontWeight.w900,
            buttonColor: appColorsGreen,
            textColor: appColorsBlack,
            margin: EdgeInsets.only(left: 0.5.h, right: 0.5.h),
            onTap: (value) {},
          )
        ],
      ),
    );
  }

  Widget _sendWidget() {
    return MessageInputWidget(
      height: 10.h,
      width: 100.w,
      controller: _messageContoller,
      onTap: (isTapped) {
        context.read<ChatBloc>().add(ChatEventSendMessage(
            message: _messageContoller.text, recieverId: _currentFriend));
      },
    );
  }
}
