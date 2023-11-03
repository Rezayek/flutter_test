import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/app_colors.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final EdgeInsetsGeometry? margin;
  final bool? center;
  final bool? hasshadow;
  const TextWidget(
      {super.key,
      required this.text,
      required this.height,
      required this.width,
      required this.fontSize,
      required this.fontWeight,
      required this.textColor,
      this.margin,
      this.center = false,
      this.hasshadow = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: width,
      padding: hasshadow == true
          ? EdgeInsets.all(height * 0.03)
          : const EdgeInsets.all(0),
      decoration: BoxDecoration(
          color: appColorsWhite,
          borderRadius: BorderRadius.circular(10),
          boxShadow: hasshadow == true
              ? [
                  BoxShadow(
                      color: appColorsBlack.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1),
                ]
              : []),
      child: Text(text,
          maxLines: 2,
          textAlign: center! ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: textColor,
            overflow: TextOverflow.ellipsis,
          )),
    );
  }
}
