import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_interface/views/location_display_view.dart';
import 'package:flutter_application_1/app_interface/views/location_view.dart';
import 'package:flutter_application_1/services/blocs/location_bloc/location_bloc.dart';
import 'package:flutter_application_1/services/blocs/location_bloc/location_event.dart';
import 'package:flutter_application_1/services/blocs/location_bloc/location_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationController extends StatefulWidget {
  const LocationController({super.key});

  @override
  State<LocationController> createState() => _LocationControllerState();
}

class _LocationControllerState extends State<LocationController> {

  @override
  Widget build(BuildContext context) {
    context.read<LocationBloc>().add(const LocationEventInit());    
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if (state is LocationStateInit) {
            return const LocationView();
          } else {
            return const LocationView();
          }
        },
      ),
    );
  }
}
