import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_interface/custom_widgets/button_widget.dart';
import 'package:flutter_application_1/app_interface/custom_widgets/input_widget.dart';
import 'package:flutter_application_1/app_interface/custom_widgets/text_widget.dart';
import 'package:flutter_application_1/constants/app_colors.dart';
import 'package:flutter_application_1/services/blocs/chat_bloc/chat_bloc.dart';
import 'package:flutter_application_1/services/blocs/chat_bloc/chat_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      width: 100.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextWidget(
            text: "Login",
            height: 6.h,
            width: 85.w,
            fontSize: 22.sp,
            fontWeight: FontWeight.w800,
            center: true,
            textColor: appColorsGreen,
            margin: EdgeInsets.only(
                top: 0.5.h, bottom: 0.5.h, left: 4.w, right: 4.w),
          ),
          InputWidget(
            height: 13.h,
            width: 85.w,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            inputName: "email",
            margin: EdgeInsets.only(
                top: 0.5.h, bottom: 0.5.h, left: 4.w, right: 4.w),
          ),
          InputWidget(
            height: 13.h,
            width: 85.w,
            controller: _passwordController,
            inputName: "password",
            margin: EdgeInsets.only(
                top: 0.5.h, bottom: 0.5.h, left: 4.w, right: 4.w),
          ),
          ButtonWidget(
            height: 8.h,
            width: 85.w,
            text: "Login",
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
            buttonColor: appColorsGreen,
            textColor: appColorsBlack,
            onTap: (value) {
              context.read<ChatBloc>().add(ChatEventLogin(
                  email: _emailController.text,
                  password: _passwordController.text));
            },
            margin: EdgeInsets.only(
                top: 0.5.h, bottom: 0.5.h, left: 4.w, right: 4.w),
          ),
          ButtonWidget(
            height: 8.h,
            width: 85.w,
            text: "SignIn",
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
            buttonColor: appColorsGreen,
            textColor: appColorsBlack,
            onTap: (value) {
              context.read<ChatBloc>().add(const ChatEventSignUpInit());
            },
            margin: EdgeInsets.only(
                top: 0.5.h, bottom: 0.5.h, left: 4.w, right: 4.w),
          ),
        ],
      ),
    );
  }
}
