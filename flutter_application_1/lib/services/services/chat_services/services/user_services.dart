import 'package:flutter_application_1/services/data/friend_data.dart';
import 'package:flutter_application_1/services/data/user_data.dart';

import '../../generic_service/firebase_service.dart';
import 'auth_services.dart';

class UserServices {
  // Private constructor to prevent external instantiation
  UserServices._privateConstructor();
  // Static instance variable for the singleton
  static final UserServices _instance = UserServices._privateConstructor();

  // Factory constructor to provide access to the instance
  factory UserServices() {
    return _instance;
  }

  Future<void> createUser(
      String email, String name, String lastname) async {
    await FirebaseService().usersCollection.add({
      "id": AuthSrvices().currentUser,
      "name": lastname,
      "last_name": name,
      "email": email,
    });
  }

  Future<void> getUserData() async {
    var res = await FirebaseService()
        .usersCollection
        .where("id", isEqualTo: AuthSrvices().currentUser)
        .get();
    UserData().friendData = FriendData.fromSnapshot(res.docs.first);
  }
}
