
import 'package:cloud_firestore/cloud_firestore.dart';

class FriendData {
  final String id;
  final String numero;
  final String nom;
  final String prenom;
  final String longitude;
  final String latitude;

  FriendData(
      {required this.id,
      required this.numero,
      required this.nom,
      required this.prenom,
      required this.longitude,
      required this.latitude});

  FriendData.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        numero = snapshot.get('numero'),
        nom = snapshot.get('nom'),
        prenom = snapshot.get('prenom'),
        longitude = snapshot.get('longitude'),
        latitude = snapshot.get('latitude');
}
