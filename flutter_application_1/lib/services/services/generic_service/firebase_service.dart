import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class FirebaseService {

  late final FirebaseFirestore _firestoreInstance;
  // Private constructor to prevent external instantiation
  FirebaseService._privateConstructor(){
    _firestoreInstance = FirebaseFirestore.instance;
  }

  // Static instance variable for the singleton
  static final FirebaseService _instance = FirebaseService._privateConstructor();

  // Factory constructor to provide access to the instance
  factory FirebaseService() {
    return _instance;
  }

  CollectionReference<Map<String, dynamic>> get friendCollection => _firestoreInstance.collection('friends');
  CollectionReference<Map<String, dynamic>> get positionCollection => _firestoreInstance.collection('position');
  CollectionReference<Map<String, dynamic>> get usersCollection => _firestoreInstance.collection('users');
  CollectionReference<Map<String, dynamic>> get chatCollection => _firestoreInstance.collection('chat');
  FirebaseAuth get authInstance => FirebaseAuth.instance;
}