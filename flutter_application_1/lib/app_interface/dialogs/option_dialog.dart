import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_interface/custom_widgets/button_widget.dart';
import 'package:flutter_application_1/constants/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/app_enums.dart';

typedef DialogOptions<T> = Map<String, T?> Function();

Future<T?> optionDialog<T>({
  required BuildContext context,
  required DialogOptions optionBuilder,
  required WarningDialogType warnigType,
  required String message,
}) {
  final option = optionBuilder();

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        titlePadding: const EdgeInsets.all(0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        backgroundColor: Colors.white,
        title: Container(
          height: 6.h,
          decoration:  BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              gradient: LinearGradient(
                  colors: [Colors.white, _getColor(warnigType),],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight)),
          child:  Center(
            child: Text(
                    _getText(warnigType),
                    style: const TextStyle(
                        color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
          ),
        ),
        contentPadding: const EdgeInsets.only(top: 5),
        content: SizedBox(
          height: 18.h,
          width: 80.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(1.5.h),
                child: SizedBox(
                  height: 10.h,
                  width: 70.w,
                  child: Center(child: Text(message, textAlign: TextAlign.center, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black),))),
              ),
            ],
          ),
        ),
        actionsPadding: const EdgeInsets.all(5),
        actions: [
          option.isEmpty? 
          Center(child: _getStandartButton(context, option)):
          SizedBox(
            width: 80.w,
            height: 15.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                  _getStandartButton(context, option),
                  ButtonWidget(
                  height: 7.h, 
                  width: 30.w, 
                  text: "No", 
                  fontSize: 20.sp, 
                  fontWeight: FontWeight.w700, 
                  buttonColor: appColorsOrange,
                  textColor: appColorsBlack, 
                  margin: EdgeInsets.only(top: 5.h,),
                  onTap: (value) {
                    Navigator.of(context).pop();
                  } ,),
              ],
            ),
          )
        ],
      );
    },
  );

  
}
Widget _getStandartButton(BuildContext context, Map<String, dynamic>  option){
  return ButtonWidget(
    height: 7.h, 
    width: 30.w, 
    text: option.isEmpty? "Okay": "Yes" , 
    fontSize: 20.sp, 
    fontWeight: FontWeight.w700, 
    buttonColor: appColorsOrange, 
    textColor: appColorsBlack, 
    margin: EdgeInsets.only(top: 5.h,),
    onTap: (value) {
      Navigator.of(context).pop(option["confirm"]);
    } ,);
}

Color _getColor(WarningDialogType warningType) {
  switch (warningType) {
    case WarningDialogType.error:
      return Colors.red; // Return the color for the error type.
    case WarningDialogType.info:
      return Colors.blue; // Return the color for the info type.
    case WarningDialogType.caution:
      return Colors.orange; // Return the color for the caution type.
    case WarningDialogType.custom:
      return Colors.yellow; // Return the color for the custom type (you can set it to your desired color).
  }
}
String _getText(WarningDialogType warningType) {
  switch (warningType) {
    case WarningDialogType.error:
      return "Error"; // Return the color for the error type.
    case WarningDialogType.info:
      return "Info"; // Return the color for the info type.
    case WarningDialogType.caution:
      return "Warning!"; // Return the color for the caution type.
    case WarningDialogType.custom:
      return "Reminder"; // Return the color for the custom type (you can set it to your desired color).
  }
}