import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_interface/custom_widgets/button_widget.dart';
import 'package:flutter_application_1/app_interface/custom_widgets/text_widget.dart';
import 'package:flutter_application_1/constants/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../services/blocs/location_bloc/location_bloc.dart';
import '../../services/blocs/location_bloc/location_event.dart';
import 'dart:developer' as debug;

class LocationDisplayView extends StatefulWidget {
  const LocationDisplayView({
    super.key,
  });

  @override
  State<LocationDisplayView> createState() => _LocationDisplayViewState();
}

class _LocationDisplayViewState extends State<LocationDisplayView> {
  @override
  Widget build(BuildContext context) {
    //Get The passed location
    final location = ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: const BoxDecoration(color: appColorsWhite),
        height: 100.h,
        width: 100.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextWidget(
              text: location ?? "no loc",
              height: 7.h,
              width: 85.w,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              textColor: appColorsBlack,
              margin: EdgeInsets.only(top: 1.h, bottom: 1.h),
            ),
            ButtonWidget(
              height: 6.h,
              width: 30.w,
              text: "View Location",
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              buttonColor: appColorsOrange,
              textColor: appColorsBlack,
              onTap: (value) {
                _openMap(location);
              },
              margin: EdgeInsets.only(top: 1.h, bottom: 1.h),
            )
          ],
        ),
      ),
    );
  }

  void _openMap(String? location) async {
    String url = 'https://www.google.com/maps/search/?api=1&query=$location';
    debug.log(url);
    try {
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
