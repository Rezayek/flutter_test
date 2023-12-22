import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_interface/custom_widgets/text_widget.dart';
import 'package:flutter_application_1/constants/app_colors.dart';
import 'package:flutter_application_1/services/data/user_data.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../services/data/chat_data.dart';

class MessageWidget extends StatefulWidget {
  final Stream<List<ChatData>> messages;
  final double height;
  final double width;
  const MessageWidget(
      {super.key,
      required this.height,
      required this.width,
      required this.messages});

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: StreamBuilder(
        stream: widget.messages,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var messages = snapshot.data as List<ChatData>;
            return ListView.builder(
              itemCount: messages.length,
              scrollDirection: Axis.vertical,
              reverse: true,
              itemBuilder: (context, index) =>
                  _message(messages[index].message, messages[index].senderId),
            );
          } else {
            return TextWidget(
                text: "Say Hi!!!",
                center: true,
                height: 10.h,
                width: widget.width,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                textColor: appColorsOrange);
          }
        },
      ),
    );
  }

  Widget _message(String text, String senderId) {
    return Wrap(
      direction: Axis.horizontal,
      children: [
        Align(
          alignment: senderId == UserData().userId
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: const CircleAvatar(
            backgroundImage: AssetImage("assets/app_logo.png"),
          ),
        ),
        Align(
            alignment: senderId == UserData().userId
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Text(text))
      ],
    );
  }
}
