import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

import '../entities/place/place.dart';
import '../entities/place/place_review.dart';
import '../entities/place/place_review_group.dart';
import '../repositories/to_place.dart';
import '../repositories/to_place_review.dart';
import '../repositories/to_place_review_group.dart';

class GetTopPlacesFromMock {
  final _uuid = const Uuid();

  Future<List<Place>> execute({int limit = 3}) async {
    // 1. Load JSON file
    final jsonString = await rootBundle.loadString('lib/data/mock/mock_multiple_places.json');
    final Map<String, dynamic> decoded = jsonDecode(jsonString);
    final List<dynamic> rawPlaces = decoded['places'];

    // 2. Convert each JSON result to a Place + attach review group if needed
    final List<Place> allPlaces = rawPlaces.map((placeJson) {
      final placeId = _uuid.v4();
      final reviewGroupId = _uuid.v4();

      final place = mapGoogleJsonToPlace(placeJson, placeId);

      final reviewGroup = mapGoogleJsonToReviewGroup(
        groupId: reviewGroupId,
        placeId: placeId,
      );

      final reviews = mapGoogleJsonToPlaceReviews(
        rawReviews: placeJson['reviews'],
        groupId: reviewGroupId,
      );

      final groupWithReviews = PlaceReviewGroup(
        id: reviewGroup.id,
        companyName: reviewGroup.companyName,
        companyLogo: reviewGroup.companyLogo,
        placeId: reviewGroup.placeId,
      );

      // Add group to the place
      return place.copyWith(
        reviewGroups: [groupWithReviews],
      );
    }).toList();

    // 3. Sort by rating descending
    allPlaces.sort((a, b) => b.rating.compareTo(a.rating));

    // 4. Return top N
    return allPlaces.take(limit).toList();
  }
}
