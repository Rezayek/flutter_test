import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_interface/custom_widgets/text_widget.dart';
import 'package:flutter_application_1/constants/app_colors.dart';
import 'package:flutter_application_1/services/data/friend_data.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FriendsWidget extends StatefulWidget {
  final double height;
  final double width;
  final Stream<List<FriendData>> friends;
  final EdgeInsetsGeometry? margin;
  final Function(String recieverId) onTap;
  const FriendsWidget(
      {super.key,
      required this.height,
      required this.width,
      required this.friends,
      this.margin,
      required this.onTap});

  @override
  State<FriendsWidget> createState() => _FriendsWidgetState();
}

class _FriendsWidgetState extends State<FriendsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: appColorsWhite,
          boxShadow: [
            BoxShadow(
                blurRadius: 1.5,
                spreadRadius: 2,
                color: appColorsBlack.withOpacity(0.1)),
            BoxShadow(
                blurRadius: 1.5,
                spreadRadius: -2,
                color: appColorsBlack.withOpacity(0.1))
          ]),
      child: StreamBuilder(
        stream: widget.friends,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var friends = snapshot.data as List<FriendData>;
            return _friendList(friends);
          } else {
            return TextWidget(
                text: "No Friends",
                height: widget.height,
                width: widget.width,
                fontSize: 24.sp,
                center: true,
                fontWeight: FontWeight.w600,
                textColor: appColorsBlack);
          }
        },
      ),
    );
  }

  Widget _friendList(List<FriendData> friends) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: friends.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          widget.onTap(friends[index].id);
        },
        child: Container(
          height: widget.height * 0.9,
          width: widget.width * 0.2,
          decoration: const BoxDecoration(color: appColorsWhite),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage("assets/app_logo.png"),
              ),
              TextWidget(
                  center: true,
                  text: friends[index].nom,
                  height: widget.height * 0.3,
                  width: widget.width * 0.2,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  textColor: appColorsBlack)
            ],
          ),
        ),
      ),
    );
  }
}
