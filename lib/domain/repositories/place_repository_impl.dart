import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/place/place.dart';
import '../../domain/entities/place/place_review_group.dart';
import '../../domain/entities/place/place_review.dart';
import '../../data/repositories/place_repository.dart';
import '../../domain/repositories/to_place.dart';
import '../../domain/repositories/to_place_review.dart';
import '../../domain/repositories/to_place_review_group.dart';
import '../../services/get_place.dart';
import '../../services/save_place.dart';
import '../../services/fetch_place_from_google.dart';
import '../../services//get_place_by_name.dart';

class PlaceRepositoryImpl implements PlaceRepository {
  Map<String, dynamic>? _json;

  Future<void> _loadJson() async {
    if (_json != null) return;
    final jsonString =
        await rootBundle.loadString('lib/data/mock/mock_response.json');
    _json = jsonDecode(jsonString);
  }

  @override
  Future<Place> getPlaceById(String placeId) async {
    await _loadJson();
    final result = _json!['result'];
    final generatedId = const Uuid().v4();

    return mapGoogleJsonToPlace(result, generatedId);
  }

  @override
  Future<List<PlaceReviewGroup>> getPlaceReviewGroupsByPlaceId(
      String placeId) async {
    await _loadJson();
    final result = _json!['result'];

    final groupId = const Uuid().v4();
    final group =
        mapGoogleJsonToReviewGroup(groupId: groupId, placeId: placeId);

    return [
      PlaceReviewGroup(
        id: group.id,
        companyName: group.companyName,
        companyLogo: group.companyLogo,
        placeId: group.placeId,
      )
    ];
  }

  @override
  Future<List<PlaceReview>> getPlaceReviewsByGroupId(String groupId) async {
    await _loadJson();
    final result = _json!['result'];

    return mapGoogleJsonToPlaceReviews(
      rawReviews: result['reviews'] ?? [],
      groupId: groupId,
    );
  }
  @override
  Future<Place?> getCachedPlaceByGoogleId(String googlePlaceId) {
    return getCachedPlaceByGoogleIdService(googlePlaceId);
  }

  @override
  Future<Place> fetchAndCachePlaceFromGoogle(String placeName) async {
    // 1. Fetch full Google place detail JSON
    final googlePlaceJson = await fetchPlaceFromGoogleApiService(placeName, 'AIzaSyDkpK__n05zMQb49-ydguva8RmP_z4K1IY');

    // 2. Extract `result` field if needed (if your fetch already returns it, skip this line)
    final result = googlePlaceJson['result'] ?? googlePlaceJson;

    // 3. Generate ID and map to Place model
    final generatedId = const Uuid().v4();
    final place = mapGoogleJsonToPlace(result, generatedId);

    // 4. Save to Supabase
    await savePlaceToSupabase(place);

    // 5. Return the cached Place object
    return place;
  }

  @override
  Future<Place?> getCachedPlaceByName(String placeName){
    return getCachedPlaceByNameService(placeName);
  }


  

}
