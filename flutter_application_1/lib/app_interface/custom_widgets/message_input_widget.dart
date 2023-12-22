import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MessageInputWidget extends StatelessWidget {
  final double height;
  final double width;
  final TextEditingController controller;
  final Function(bool isTapped) onTap;
  const MessageInputWidget(
      {super.key,
      required this.height,
      required this.width,
      required this.controller,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.8,
      width: width * 0.8,
      margin: EdgeInsets.only(
          top: height * 0.05,
          bottom: height * 0.05,
          right: width * 0.1,
          left: width * 0.1),
      decoration: BoxDecoration(
          color: appColorsWhite,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                blurRadius: 1.5,
                spreadRadius: 2,
                color: appColorsBlack.withOpacity(0.1))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.75,
            width: width * 0.6,
            child: TextField(controller: controller),
          ),
          IconButton(
              onPressed: () {
                onTap(true);
              },
              icon: Icon(
                Icons.send,
                size: 20.sp,
                color: appColorsOrange,
              ))
        ],
      ),
    );
  }
}
