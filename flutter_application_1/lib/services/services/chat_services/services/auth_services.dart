import 'package:flutter_application_1/services/services/generic_service/firebase_service.dart';

class AuthSrvices {
  // Private constructor to prevent external instantiation
  AuthSrvices._privateConstructor();
  // Static instance variable for the singleton
  static final AuthSrvices _instance = AuthSrvices._privateConstructor();

  // Factory constructor to provide access to the instance
  factory AuthSrvices() {
    return _instance;
  }

  Future<void> createUser(
      {required String email, required String password}) async {
        await FirebaseService().authInstance.createUserWithEmailAndPassword(
              email: email,
              password: password,
            );
  }

  Future<void> login({required String email, required String password}) async {
    await FirebaseService()
        .authInstance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  String get currentUser {
    final user = FirebaseService().authInstance.currentUser;
    return user!.uid;
  }
}
