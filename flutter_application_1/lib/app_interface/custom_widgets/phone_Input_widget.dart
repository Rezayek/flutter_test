import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/app_colors.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PhoneInputWidget extends StatefulWidget {
  final double height;
  final double width;
  final TextEditingController controller;
  final EdgeInsetsGeometry? margin;
  final Function(bool isValid) numberValidation;
  final Function(PhoneNumber number) getDialCode;
  const PhoneInputWidget(
      {super.key,
      required this.height,
      required this.width,
      required this.controller,
      this.margin,
      required this.numberValidation,
      required this.getDialCode});

  @override
  State<PhoneInputWidget> createState() => _PhoneInputWidgetState();
}

class _PhoneInputWidgetState extends State<PhoneInputWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String initialCountry = 'TN';
  PhoneNumber number = PhoneNumber(isoCode: 'TN');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        margin: widget.margin,
        height: widget.height,
        width: widget.width,
        child: InternationalPhoneNumberInput(
          autoFocus: true,
          onInputChanged: (PhoneNumber number) {
            widget.getDialCode(number);
          },
          onInputValidated: (bool value) {
            if (value) 
            {
              widget.numberValidation(true);
            } 
            else 
            {
              widget.numberValidation(false);
            }
          },
          selectorConfig: const SelectorConfig(
            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          ),
          ignoreBlank: false,
          autoValidateMode: AutovalidateMode.disabled,
          selectorTextStyle: const TextStyle(color: appColorsOrange),
          initialValue: number,
          textFieldController: widget.controller,
          formatInput: true,
          keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
          inputBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: appColorsOrange, width: 0.0,style: BorderStyle.solid),
            borderRadius: BorderRadius.all(Radius.circular(5))
          ),
        ),
      ),
    );
  }


  
}
