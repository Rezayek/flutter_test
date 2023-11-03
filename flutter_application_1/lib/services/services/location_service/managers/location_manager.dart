import 'package:android_intent/android_intent.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:location/location.dart' as loc;

import '../location_excptions.dart';

class LocationManager {

  // Private constructor to prevent external instantiation
  LocationManager._privateConstructor();

  // Singleton instance variable
  static final LocationManager _instance = LocationManager._privateConstructor();

  // Factory constructor to return the singleton instance
  factory LocationManager() {
    return _instance;
  }


  Future<Position?> locationFunc() async {
    final Position? position =
        await _getUserLocation().onError((error, stackTrace) => null);
    if (position == null) return null;
    return position;
  }

  Future<void> requestLocationPermission() async {
    _enableLocation();
    final LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      final LocationPermission newPermission = await Geolocator.requestPermission();
      if (newPermission == LocationPermission.denied) {
        // Handle the case where the user denied location permission.
      }
      return;
    }
  }

  void _enableLocation() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      const AndroidIntent intent = AndroidIntent(
        action: 'android.settings.LOCATION_SOURCE_SETTINGS',
      );

      intent.launch();
    }
  }

  Future<Position?> _getUserLocation() async {
    final bool isLocationServiceEnabled =
        await Geolocator.isLocationServiceEnabled();

    if (!isLocationServiceEnabled) {
      _enableLocation();
    }

    final LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      final LocationPermission newPermission =
          await Geolocator.requestPermission();
      if (newPermission == LocationPermission.denied) {
        throw LocationExceptionFailedToGetLocation;
      }
    } else if (permission == LocationPermission.deniedForever) {
      throw LocationExceptionFailedToGetLocation;
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      forceAndroidLocationManager: true,
    );
  }

  Future<String?> _getCountry(Position position) async {
    GeoCode geoCode = GeoCode();
    Address address = await geoCode.reverseGeocoding(
        latitude: position.latitude, longitude: position.longitude);

    return address.countryName;
  }
}
