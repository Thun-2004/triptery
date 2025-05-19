import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

import '../entities/place/place.dart';
import '../repositories/to_place.dart';

class GetTopPlacesFromMock {
  final _uuid = const Uuid();

Future<List<Place>> execute({int limit = 3}) async {
  final jsonString = await rootBundle.loadString('lib/data/mock/mock_response.json');
  final Map<String, dynamic> decoded = jsonDecode(jsonString);
  final placeId = _uuid.v4();

  final place = mapGoogleJsonToPlace(decoded['result'], placeId);
  return [place]; // Return as a list for compatibility
}

}
