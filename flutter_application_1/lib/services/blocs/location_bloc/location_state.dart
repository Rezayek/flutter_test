import 'package:flutter/foundation.dart';

@immutable
abstract class LocationState {
  final bool isLoading;
  final String loadingText;
  final Exception? exception;
  const LocationState({
    required this.isLoading,
    this.loadingText = 'Sending Location',
    this.exception,
  });
}

class LocationStateInit extends LocationState {
  const LocationStateInit(
      {
      required super.isLoading,
      super.exception});
}


