import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import '../../data/repositories/place_repository.dart';
import '../../domain/entities/place/place.dart';
import '../../domain/entities/place/place_review_group.dart';
import '../../domain/entities/place/place_review.dart';

class MockPlaceRepositoryImpl implements PlaceRepository {
  final _uuid = const Uuid();
  late Map<String, dynamic> _json;

  MockPlaceRepositoryImpl() {
    _loadJson();
  }

  Future<void> _loadJson() async {
    final jsonString =
        await rootBundle.loadString('lib/data/mock/mock_response.json');
    _json = jsonDecode(jsonString);
  }

  @override
  Future<Place> getPlaceById(String placeId) async {
    if (_json.isEmpty) await _loadJson();
    final result = _json['result'];

    return Place(
      id: _uuid.v4(),
      googlePlaceId: result['place_id'],
      name: result['name'],
      description: '', // Placeholder
      openingTime: _extractOpening(result),
      closingTime: _extractClosing(result),
      latitude: result['geometry']['location']['lat'],
      longitude: result['geometry']['location']['lng'],
      rating: (result['rating'] ?? 0).toDouble(),
      totalUserRatings: result['user_ratings_total'] ?? 0,
      address: result['formatted_address'],
      city: _extractCity(result),
      countryCode: _extractCountry(result),
      createdAt: DateTime.now(),
      createdBy: 'admin',
      updatedAt: DateTime.now(),
      updatedBy: 'admin',
      deleted: false,
      deletedAt: null,
      deletedBy: null,
      imageUrl: '',
      reviewGroups: [],
    );
  }

  @override
  Future<List<PlaceReviewGroup>> getPlaceReviewGroupsByPlaceId(String placeId) async {
    if (_json.isEmpty) await _loadJson();
    final result = _json['result'];

    final group = PlaceReviewGroup(
      id: _uuid.v4(),
      companyName: 'Google Reviews',
      companyLogo: 'assets/images/google_icon.png',
      placeId: placeId,
      reviews: (result['reviews'] as List<dynamic>?)
              ?.map((r) => PlaceReview(
                    id: _uuid.v4(),
                    placeReviewGroupId: placeId,
                    username: r['author_name'],
                    userProfilePictureUrl: r['profile_photo_url'],
                    rating: (r['rating'] ?? 0).toDouble(),
                    description: r['text'],
                    approved: true,
                    createdAt: DateTime.now(),
                    createdBy: 'admin',
                    updatedAt: DateTime.now(),
                    updatedBy: 'admin',
                    deleted: false,
                    deletedAt: null,
                    deletedBy: null,
                  ))
              .toList() ??
          [],
    );

    return [group];
  }

  String _extractOpening(Map<String, dynamic> result) {
    try {
      return result['opening_hours']['weekday_text'][0]
          .split(': ')
          .last
          .split('–')
          .first
          .trim();
    } catch (_) {
      return '';
    }
  }

  String _extractClosing(Map<String, dynamic> result) {
    try {
      return result['opening_hours']['weekday_text'][0]
          .split('–')
          .last
          .trim();
    } catch (_) {
      return '';
    }
  }

  String _extractCity(Map<String, dynamic> result) {
    return _extractAddressComponent(result, 'locality');
  }

  String _extractCountry(Map<String, dynamic> result) {
    return _extractAddressComponent(result, 'country', useShortName: true);
  }

  String _extractAddressComponent(Map<String, dynamic> result, String type, {bool useShortName = false}) {
    final components = result['address_components'] as List<dynamic>;
    final match = components.firstWhere(
      (c) => (c['types'] as List).contains(type),
      orElse: () => null,
    );
    return match == null ? '' : match[useShortName ? 'short_name' : 'long_name'];
  }
}
