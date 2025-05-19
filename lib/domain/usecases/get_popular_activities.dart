import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

import '../entities/place/place.dart';
import '../repositories/to_place.dart';

class GetPopularActivitiesFromMock {
  final _uuid = const Uuid();

  Future<List<Place>> execute({int limit = 3}) async {
    final jsonString = await rootBundle.loadString('lib/data/mock/mock_multiple_places.json');
    final Map<String, dynamic> decoded = jsonDecode(jsonString);
    final List<dynamic> rawPlaces = decoded['places'];

    final List<Place> allPlaces = rawPlaces.map((placeJson) {
      final placeId = _uuid.v4();
      return mapGoogleJsonToPlace(placeJson, placeId);
    }).toList();

    // Sort by popularity (user_ratings_total)
    allPlaces.sort((a, b) => b.totalUserRatings.compareTo(a.totalUserRatings));

    return allPlaces.take(limit).toList();
  }
}
