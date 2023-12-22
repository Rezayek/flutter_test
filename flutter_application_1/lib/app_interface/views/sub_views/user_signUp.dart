import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../constants/app_colors.dart';
import '../../../services/blocs/chat_bloc/chat_bloc.dart';
import '../../../services/blocs/chat_bloc/chat_event.dart';
import '../../custom_widgets/button_widget.dart';
import '../../custom_widgets/input_widget.dart';
import '../../custom_widgets/text_widget.dart';

class UserSignUp extends StatefulWidget {
  const UserSignUp({super.key});

  @override
  State<UserSignUp> createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _nameController;
  late TextEditingController _lastnameController;
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
    _lastnameController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _lastnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      width: 100.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextWidget(
            text: "SignUp",
            height: 6.h,
            width: 85.w,
            fontSize: 22.sp,
            fontWeight: FontWeight.w800,
            textColor: appColorsGreen,
            center: true,
            margin: EdgeInsets.only(
                top: 0.5.h, bottom: 3.h, left: 4.w, right: 4.w),
          ),
          InputWidget(
            height: 12.5.h,
            width: 85.w,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            inputName: "email",
            margin: EdgeInsets.only(
                top: 0.5.h, bottom: 0.5.h, left: 4.w, right: 4.w),
          ),
          InputWidget(
            height: 12.5.h,
            width: 85.w,
            controller: _passwordController,
            inputName: "password",
            margin: EdgeInsets.only(
                top: 0.5.h, bottom: 0.5.h, left: 4.w, right: 4.w),
          ),
          InputWidget(
            height: 12.5.h,
            width: 85.w,
            controller: _nameController,
            inputName: "name",
            margin: EdgeInsets.only(
                top: 0.5.h, bottom: 0.5.h, left: 4.w, right: 4.w),
          ),
          InputWidget(
            height: 12.5.h,
            width: 85.w,
            controller: _lastnameController,
            inputName: "lastname",
            margin: EdgeInsets.only(
                top: 0.5.h, bottom: 0.5.h, left: 4.w, right: 4.w),
          ),
          ButtonWidget(
            height: 8.h,
            width: 85.w,
            text: "SignUp",
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
            buttonColor: appColorsGreen,
            textColor: appColorsBlack,
            margin: EdgeInsets.only(
                top: 1.5.h, bottom: 0.5.h, left: 4.w, right: 4.w),
            onTap: (value) {
              context.read<ChatBloc>().add(ChatEventSignUp(email: _emailController.text, password: _passwordController.text, nom: _nameController.text, prenom: _lastnameController.text));
            },
          ),
          ButtonWidget(
            height: 8.h,
            width: 85.w,
            text: "LogIn",
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
            buttonColor: appColorsGreen,
            textColor: appColorsBlack,
            margin: EdgeInsets.only(
                top: 0.5.h, bottom: 0.5.h, left: 4.w, right: 4.w),
            onTap: (value) {context.read<ChatBloc>().add(const ChatEventLoginInit());},
            
          ),
        ],
      ),
    );
  }
}
