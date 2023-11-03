import 'package:flutter_application_1/services/data/position_data.dart';

import '../generic_service/firebase_service.dart';

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
    return await FirebaseService().positionCollection.get().then((value) =>
        value.docs.map((e) => PositionData.fromSnapshot(e)).toList());
  }
}
