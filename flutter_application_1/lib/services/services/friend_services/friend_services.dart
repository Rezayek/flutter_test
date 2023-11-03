import 'package:flutter_application_1/services/data/friend_data.dart';
import 'package:flutter_application_1/services/services/generic_service/firebase_service.dart';

class FriendsService {
  // Private constructor to prevent external instantiation
  FriendsService._privateConstructor();
  // Static instance variable for the singleton
  static final FriendsService _instance = FriendsService._privateConstructor();

  // Factory constructor to provide access to the instance
  factory FriendsService() {
    return _instance;
  }

  Future<void> addFriend(FriendData friendData) async {
    await FirebaseService().friendCollection.add({
      'numero': friendData.numero,
      'nom': friendData.nom,
      'prenom': friendData.prenom,
      'longitude': friendData.longitude,
      'latitude': friendData.latitude,
    });
  }

  Future<List<FriendData>> fetchFriends() async {
    return await FirebaseService().friendCollection.get().then(
        (value) => value.docs.map((e) => FriendData.fromSnapshot(e)).toList());
  }
}
