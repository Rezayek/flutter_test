import 'package:cloud_firestore/cloud_firestore.dart';

class FriendData {
  final String id;
  final String nom;
  final String prenom;

  FriendData({
    required this.id,
    required this.nom,
    required this.prenom,
  });

  FriendData.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.get('id'),
        nom = snapshot.get('name'),
        prenom = snapshot.get('last_name');
}
