import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_interface/custom_widgets/button_widget.dart';
import 'package:flutter_application_1/services/blocs/friend_bloc/friend_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../constants/app_colors.dart';
import '../../../services/blocs/friend_bloc/friend_bloc.dart';
import '../../../services/blocs/friend_bloc/friend_state.dart';
import '../../../services/data/position_data.dart';

class LocationsBest extends StatefulWidget {
  final List<PositionData> locations;
  const LocationsBest({super.key, required this.locations});

  @override
  State<LocationsBest> createState() => _LocationsBestState();
}

class _LocationsBestState extends State<LocationsBest> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<FriendBloc, FriendState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: SizedBox(
        width: 100.w,
        height: 100.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonWidget(
              height: 6.h,
              width: 40.w,
              text: "Add new location",
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
              buttonColor: appColorsGreen,
              textColor: appColorsBlack,
              onTap: (value) {
                context.read<FriendBloc>().add(const FriendEventInit());
              },
              margin: EdgeInsets.only(
                  top: 0.75.h, bottom: 1.h, left: 4.w, right: 4.w),
            ),
            SizedBox(
                width: 100.w,
                height: 80.h,
                child: _locationsList(widget.locations)),
          ],
        ),
      ),
    );
  }

  Widget _locationsList(List<PositionData> positions) {
    return ListView.builder(
      itemCount: positions.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            openMap(
                positions[index].longitude + ',' + positions[index].latitude);
          },
          leading: Icon(
            Icons.location_on,
            color: appColorsGreen,
            size: 22.sp,
          ),
          title: Text(positions[index].description),
          subtitle: Text(
              'Longitude: ${positions[index].longitude}, Latitude: ${positions[index].latitude}'),
        );
      },
    );
  }

  openMap(String? location) async {
    String url = 'https://www.google.com/maps/search/?api=1&query=$location';
    try {
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {}
  }
}
