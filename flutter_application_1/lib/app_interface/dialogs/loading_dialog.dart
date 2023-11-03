import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

typedef CloseDialog = void Function();

CloseDialog showLoadingDialog({
  required BuildContext context,
  required String text,
}) {
  final dialog = AlertDialog(
    
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(color: appColorsGreen),
        const SizedBox(
          height: 10.0,
        ),
        Text(text, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: appColorsBlack )),
      ],
    ),
  );

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => dialog,
  );
  return () => Navigator.of(context).pop();
}