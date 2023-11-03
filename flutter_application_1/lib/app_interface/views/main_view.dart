import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_interface/custom_widgets/button_widget.dart';
import 'package:flutter_application_1/constants/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Center(
          child: ListView(
            scrollDirection: Axis.vertical,  
            children: [
              ButtonWidget(height: 7.h, width: 85.w, text: "Find me", fontSize: 20.sp, fontWeight: FontWeight.w800, buttonColor: appColorsOrange, textColor: appColorsBlack, onTap: (value) {
                Navigator.of(context).pushNamed("/find_me");
              },margin: EdgeInsets.only(top: 1.h, bottom: 1.h, left: 5.w, right: 5.w)),
              ButtonWidget(height: 7.h, width: 85.w, text: "Best Location", fontSize: 20.sp, fontWeight: FontWeight.w800, buttonColor: appColorsOrange, textColor: appColorsBlack, onTap: (value) {
                Navigator.of(context).pushNamed("/best_location");
              },margin: EdgeInsets.only(top: 1.h, bottom: 1.h, left: 5.w, right: 5.w)),
            ],
          ),
        ),
      ),
    );
  }
}