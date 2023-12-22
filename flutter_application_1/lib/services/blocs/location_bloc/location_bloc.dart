import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/services/blocs/location_bloc/location_state.dart';
import '../../services/location_service/location_services.dart';
import 'location_event.dart';
import 'dart:developer' as debug;

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc(LocationService locationService)
      : super(const LocationStateInit(isLoading: false)) {
    on<LocationEventInit>((event, emit) {
      locationService.requestLocationPermission();
    });
    on<LocationEventProcessRequestLocation>((event, emit) async {
      emit(const LocationStateInit(isLoading: true));
      await locationService.sendRequest('${event.dialCode}+${event.phoneNumber}');
      emit(const LocationStateInit(isLoading: false));
    });
  }
}
