import 'package:flutter_application_1/services/services/location_service/managers/location_manager.dart';
import 'package:flutter_application_1/services/services/location_service/managers/location_sms_manager.dart';

class LocationService {
  final LocationManager _locationManager = LocationManager();
  final LocationSMSManager _locationSmsManager = LocationSMSManager();

  void requestLocationPermission() async {
    await _locationManager.requestLocationPermission();
  }

  void sendRequest(String phoneNumber) async {
    await _locationSmsManager.sendLocationRquest(phoneNumber);
  }

}
