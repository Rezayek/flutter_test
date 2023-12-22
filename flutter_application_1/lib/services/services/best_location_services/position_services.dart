import 'dart:convert';

import 'package:flutter_application_1/services/data/position_data.dart';

import '../generic_service/firebase_service.dart';
import 'dart:developer' as debug;
import 'package:http/http.dart' as http;

class PositionService {
  // Private constructor to prevent external instantiation
  PositionService._privateConstructor();
  // Static instance variable for the singleton
  static final PositionService _instance =
      PositionService._privateConstructor();

  // Factory constructor to provide access to the instance
  factory PositionService() {
    return _instance;
  }

  Future<void> addPosition(PositionData positionData) async {
    await FirebaseService().positionCollection.add({
      'description': positionData.description,
      'longitude': positionData.longitude,
      'latitude': positionData.longitude,
    });
  }

  Future<List<PositionData>> fetchPositions() async {
    var res = await FirebaseService().positionCollection.get();
    debug.log(res.docs.toString());
    return await FirebaseService().positionCollection.get().then((value) =>
        value.docs.map((e) => PositionData.fromSnapshot(e)).toList());
  }

  Future<List<PositionData>> fetchPostionsUrl() async {
    var url = Uri.http('192.168.7.87', '/');
    var response = await http.post(url);

    var responseBody = json.decode(response.body);
    List<dynamic> allNovels = responseBody['locations'];
    List<PositionData> positions = [];
    for (int index = 0; index < allNovels.length; index++) {
      Map<String, dynamic> novelMap = allNovels.elementAt(index);
      positions.add(PositionData.fromUrl(novelMap));
    }

    return positions;
  }
}
