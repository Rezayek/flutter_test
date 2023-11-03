import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/services/data/friend_data.dart';
import 'package:flutter_application_1/services/data/position_data.dart';

@immutable
abstract class FriendEvent {
  const FriendEvent();
}

class FriendEventInit extends FriendEvent {
  const FriendEventInit();
}

class FriendEventAddFriendInit extends FriendEvent {
  const FriendEventAddFriendInit();
}

class FriendEventAddFriend extends FriendEvent {
  final FriendData friendData;
  const FriendEventAddFriend({required this.friendData});
}

class FriendEventGetLocation extends FriendEvent {
  const FriendEventGetLocation();
}

class FriendEventUploadLocation extends FriendEvent {
  final PositionData positionData;
  const FriendEventUploadLocation({required this.positionData});
}

class FriendEventGetBestLocations extends FriendEvent {
  const FriendEventGetBestLocations();

}
