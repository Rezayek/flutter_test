import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/app_colors.dart';

class ButtonWidget extends StatelessWidget {
  final double height;
  final double width;
  final bool? addShadow;
  final bool? load;
  final EdgeInsetsGeometry? margin;
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color buttonColor;
  final Color textColor;
  final Function(bool value) onTap;
  final BorderRadius? borderRadius;
  const ButtonWidget({
    super.key,
    required this.height,
    required this.width,
    this.addShadow = false,
    this.margin,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    required this.buttonColor,
    required this.textColor,
    required this.onTap,
    this.load = false,
    BorderRadius? borderRadius,
  }) : borderRadius =
            borderRadius ?? const BorderRadius.all(Radius.circular(8.0));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(true),
      child: Container(
        margin: margin,
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: buttonColor,
            boxShadow: addShadow!
                ? [
                    const BoxShadow(
                        color: appColorsBlack, spreadRadius: 2, blurRadius: 1)
                  ]
                : [],
            borderRadius: borderRadius),
        child: Center(
            child: !load!
                ? Text(
                    text,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: textColor,
                    ),
                  )
                : const CircularProgressIndicator(
                    color: appColorsOrange,
                  )),
      ),
    );
  }
}
