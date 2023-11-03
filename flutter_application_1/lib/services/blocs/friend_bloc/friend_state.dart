import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

import '../../data/position_data.dart';

@immutable
abstract class FriendState {
  final bool isLoading;
  final String loadingText;
  final Exception? exception;
  const FriendState({
    required this.isLoading,
    this.loadingText = 'Processing...',
    this.exception,
  });
}

class FriendStateInit extends FriendState {
  final Position? location;
  const FriendStateInit(
      {this.location, required super.isLoading, super.exception});
}

class FriendStateAdd extends FriendState {
  final Position position;
  const FriendStateAdd(
      {required this.position, required super.isLoading, super.exception});
}

class FriendStateLocations extends FriendState {
  final List<PositionData> bestLocations;

  const FriendStateLocations(
      {required super.isLoading, required this.bestLocations});
}
