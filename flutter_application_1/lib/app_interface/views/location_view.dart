import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_interface/custom_widgets/button_widget.dart';
import 'package:flutter_application_1/app_interface/custom_widgets/phone_Input_widget.dart';
import 'package:flutter_application_1/app_interface/custom_widgets/text_widget.dart';
import 'package:flutter_application_1/app_interface/dialogs/option_dialog.dart';
import 'package:flutter_application_1/constants/app_colors.dart';
import 'package:flutter_application_1/constants/app_enums.dart';
import 'package:flutter_application_1/services/blocs/location_bloc/location_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../services/blocs/location_bloc/location_bloc.dart';
import '../../services/blocs/location_bloc/location_state.dart';
import '../../services/services/location_service/location_excptions.dart';
import '../../services/services/location_service/managers/location_sms_manager.dart';
import '../dialogs/loading_dialog.dart';
import 'dart:developer' as debug;

class LocationView extends StatefulWidget {
  const LocationView({super.key});

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  late TextEditingController phoneController;
  String _dialCode = "+216";
  late bool sendSms;
  CloseDialog? _closeDialogHandle;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationBloc, LocationState>(
      listener: (context, state) async {
        _stateBlocHandler(state);
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            height: 100.h,
            width: 100.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextWidget(
                  text: "Please Provide your phone Number to send location",
                  height: 12.h,
                  width: 95.w,
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w800,
                  textColor: appColorsBlack,
                  center: true,
                  margin: EdgeInsets.only(top: 0.5.h, bottom: 5.h),
                ),
                PhoneInputWidget(
                  height: 8.h,
                  width: 80.w,
                  controller: phoneController,
                  numberValidation: (isValid) =>
                      isValid ? sendSms = true : sendSms = false,
                  getDialCode: (number) => _dialCode = number.dialCode!,
                  margin: EdgeInsets.only(top: 1.5.h, bottom: 0.5.h),
                ),
                ButtonWidget(
                  height: 7.h,
                  width: 35.w,
                  text: "Send SMS",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  buttonColor: appColorsOrange,
                  textColor: appColorsBlack,
                  onTap: (value) => _buttonAction(),
                  margin: EdgeInsets.only(top: 2.h, bottom: 0.5.h),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _buttonAction() {
    !sendSms
        ? _displayWrongPhone()
        : context.read<LocationBloc>().add(LocationEventProcessRequestLocation(
            dialCode: _dialCode, phoneNumber: phoneController.text));
  }

  void _displayWrongPhone() async {
    await optionDialog(
        context: context,
        optionBuilder: () => {},
        warnigType: WarningDialogType.error,
        message: "Wrong phone format");
  }

  void _stateBlocHandler(LocationState state) async {
    final closeDialog = _closeDialogHandle;
    if (state is LocationStateInit) {
      if (!state.isLoading && closeDialog != null) {
        closeDialog();
        _closeDialogHandle = null;
      } else if (state.isLoading && closeDialog == null) {
        _closeDialogHandle =
            showLoadingDialog(context: context, text: "Processing");
      }

      if (state.exception is LocationExceptionFailedToGetLocation) {
        await optionDialog(
            context: context,
            optionBuilder: () => {},
            warnigType: WarningDialogType.error,
            message: "Failed to get Location");
      } else if (state.exception is LocationExceptionFailedToSendLocation) {
        await optionDialog(
            context: context,
            optionBuilder: () => {},
            warnigType: WarningDialogType.error,
            message: "Failed to send Location");
      } else if (state.exception is LocationExceptionFailedToRecieveLocation) {
        await optionDialog(
            context: context,
            optionBuilder: () => {},
            warnigType: WarningDialogType.error,
            message: "Failed to recieve Location");
      }
    }
  }

  
}
