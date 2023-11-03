import 'package:flutter/foundation.dart';

@immutable
abstract class LocationEvent {
  const LocationEvent();
}

class LocationEventInit extends LocationEvent {
  const LocationEventInit();
}

class LocationEventInitListeners extends LocationEvent {
  const LocationEventInitListeners();
}

class LocationEventProcessRequestLocation extends LocationEvent {
  final String dialCode;
  final String phoneNumber;

  const LocationEventProcessRequestLocation(
      {required this.dialCode, required this.phoneNumber});
}

class LocationEventRcieveMessage extends LocationEvent {
  const LocationEventRcieveMessage();
}
