import 'package:cloud_firestore/cloud_firestore.dart';

class PositionData {
  final String id;
  final String description;
  final String longitude;
  final String latitude;

  PositionData(
      {required this.id,
      required this.description,
      required this.longitude,
      required this.latitude});

  PositionData.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        description = snapshot.get('description'),
        longitude = snapshot.get('longitude'),
        latitude = snapshot.get('latitude');


  PositionData.fromUrl(Map<String, dynamic> snapshot)
      : id = "0",
        description = snapshot['description'],
        longitude = snapshot['longitude'],
        latitude = snapshot['latitude'];
}