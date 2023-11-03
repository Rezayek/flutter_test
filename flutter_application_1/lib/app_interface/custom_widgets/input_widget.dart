import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class InputWidget extends StatefulWidget {
  final double height;
  final double width;
  final TextEditingController controller;
  final String inputName;
  final EdgeInsetsGeometry? margin;
  final int? maxLines;
  const InputWidget(
      {super.key,
      required this.height,
      required this.width,
      required this.controller,
      required this.inputName,
      this.margin,
      this.maxLines});

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      height: widget.height,
      width: widget.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.inputName,
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: appColorsGreen),
            overflow: TextOverflow.ellipsis,
          ),
          TextFormField(
            maxLines: widget.maxLines,
            controller: widget.controller,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                counterText: '',
                hintStyle: TextStyle(color: appColorsGreen, fontSize: 20.0)),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter ${widget.inputName}';
              }
              return null;
            },
          )
        ],
      ),
    );
  }
}
