import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/services/data/friend_data.dart';
import 'package:flutter_application_1/services/data/user_data.dart';
import 'package:flutter_application_1/services/services/generic_service/firebase_service.dart';
import 'dart:developer' as debug;

class FriendsService {
  // Private constructor to prevent external instantiation
  FriendsService._privateConstructor();
  // Static instance variable for the singleton
  static final FriendsService _instance = FriendsService._privateConstructor();

  // Factory constructor to provide access to the instance
  factory FriendsService() {
    return _instance;
  }

  final StreamController<List<FriendData>> _friendController =
      StreamController<List<FriendData>>.broadcast();

  Future<void> addFriend(String friendId) async {
    await FirebaseService().friendCollection.add({
      'user_id_1': UserData().userId,
      'user_id_2': friendId,
    });
  }

  Stream<List<FriendData>> getFreinds() {
    _fetchFriends();
    return _friendController.stream;
  }

  Future<void> _fetchFriends() async {
    List<FriendData> friends = [];
    final currentUserID = UserData().userId;
    debug.log(currentUserID);
    FirebaseService()
        .friendCollection
        .where(Filter.or(
          Filter("user_id_2", isEqualTo: currentUserID),
          Filter("user_id_1", isEqualTo: currentUserID),
        ))
        .snapshots()
        .listen((event) async {
      friends.clear();
      for (var e in event.docs) {
        final targetUserID = e.get("user_id_2") == currentUserID
            ? e.get("user_id_1")
            : e.get("user_id_2");
        final querySnapshot = await FirebaseService()
            .usersCollection
            .where("id", isEqualTo: targetUserID)
            .get();

        for (var snapshot in querySnapshot.docs) {
          friends.add(FriendData.fromSnapshot(snapshot));
        }
        if (friends.isNotEmpty) {
          _friendController.add(friends);
        }
      }
    });

  }
}
