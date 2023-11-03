import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_interface/custom_widgets/button_widget.dart';
import 'package:flutter_application_1/app_interface/custom_widgets/input_widget.dart';
import 'package:flutter_application_1/app_interface/custom_widgets/text_widget.dart';
import 'package:flutter_application_1/constants/app_colors.dart';
import 'package:flutter_application_1/services/data/position_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../services/blocs/friend_bloc/friend_bloc.dart';
import '../../../services/blocs/friend_bloc/friend_event.dart';
import '../../../services/blocs/friend_bloc/friend_state.dart';
import '../../dialogs/loading_dialog.dart';

class LocationBest extends StatefulWidget {
  final Position? location;
  const LocationBest({super.key, this.location});

  @override
  State<LocationBest> createState() => _LocationBestState();
}

class _LocationBestState extends State<LocationBest> {
  late TextEditingController _latController;
  late TextEditingController _longController;
  late TextEditingController _descriptionController;
  late Position _location;
  CloseDialog? _closeDialogHandle;

  @override
  void initState() {
    super.initState();
    _latController = TextEditingController();
    _longController = TextEditingController();
    _descriptionController = TextEditingController();
    setState(() {
      if (widget.location != null) {
        _latController.text = widget.location!.latitude as String;
        _longController.text = widget.location!.longitude as String;
      }
    });
    
  }

  @override
  void dispose() {
    _latController.dispose();
    _longController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FriendBloc, FriendState>(
      listener: (context, state) {
        final closeDialog = _closeDialogHandle;
        if (state is FriendStateInit) {
          if (!state.isLoading && closeDialog != null) {
            closeDialog();
            _closeDialogHandle = null;
          } else if (state.isLoading && closeDialog == null) {
            _closeDialogHandle =
                showLoadingDialog(context: context, text: "Processing");
          }

          if (state.location != null) {
            _location = state.location!;
            setState(() {
              _latController.text = _location.altitude.toString();
              _longController.text = _location.longitude.toString();
            });
          }
        }
      },
      child: SizedBox(
        height: 180.h,
        width: 100.w,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            TextWidget(
              text: "Add location",
              height: 6.h,
              width: 85.w,
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              textColor: appColorsBlack,
              margin: EdgeInsets.only(
                  top: 0.75.h, bottom: 1.h, left: 4.w, right: 4.w),
            ),
            InputWidget(
              height: 12.5.h,
              width: 85.w,
              controller: _latController,
              inputName: "Altitude",
              margin: EdgeInsets.only(
                  top: 0.75.h, bottom: 1.h, left: 4.w, right: 4.w),
            ),
            InputWidget(
              height: 12.5.h,
              width: 85.w,
              controller: _latController,
              inputName: "longtitude",
              margin: EdgeInsets.only(
                  top: 0.75.h, bottom: 1.h, left: 4.w, right: 4.w),
            ),
            InputWidget(
              height: 40.h,
              width: 85.w,
              controller: _descriptionController,
              inputName: "Provide description",
              maxLines: 8,
              margin: EdgeInsets.only(
                  top: 0.75.h, bottom: 1.h, left: 4.w, right: 4.w),
            ),
            ButtonWidget(
              height: 6.h,
              width: 25.w,
              text: "Upload",
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
              buttonColor: appColorsGreen,
              textColor: appColorsBlack,
              onTap: (value) {
                if (_location == null) return;
                context.read<FriendBloc>().add(FriendEventUploadLocation(
                    positionData: PositionData(
                        id: "0",
                        description: _descriptionController.text,
                        longitude: _longController.text,
                        latitude: _latController.text)));
              },
              margin: EdgeInsets.only(
                  top: 0.75.h, bottom: 1.h, left: 4.w, right: 4.w),
            ),
            ButtonWidget(
              height: 6.h,
              width: 25.w,
              text: "Fetch Location",
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
              buttonColor: appColorsGreen,
              textColor: appColorsBlack,
              onTap: (value) {
                context.read<FriendBloc>().add(const FriendEventGetLocation());
              },
              margin: EdgeInsets.only(
                  top: 0.75.h, bottom: 1.h, left: 4.w, right: 4.w),
            ),
            ButtonWidget(
              height: 6.h,
              width: 25.w,
              text: "View Locations",
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
              buttonColor: appColorsGreen,
              textColor: appColorsBlack,
              onTap: (value) {
                context
                    .read<FriendBloc>()
                    .add(const FriendEventGetBestLocations());
              },
              margin: EdgeInsets.only(
                  top: 0.75.h, bottom: 1.h, left: 4.w, right: 4.w),
            )
          ],
        ),
      ),
    );
  }
}
