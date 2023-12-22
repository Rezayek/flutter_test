import 'package:flutter_application_1/services/data/friend_data.dart';

class UserData {
  late final FriendData _userData;

  // Private constructor to prevent external instantiation
  UserData._privateConstructor();

  // Static instance variable for the singleton
  static final UserData _instance = UserData._privateConstructor();

  // Factory constructor to provide access to the instance
  factory UserData() {
    return _instance;
  }

  set friendData(FriendData userData) => _userData = userData;

  String get userId => _userData.id;
  String get userName => _userData.nom;
  String get userLastname => _userData.prenom;
}
