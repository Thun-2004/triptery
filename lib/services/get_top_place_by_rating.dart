import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/entities/place/place.dart';

Future<List<Place>> getTopPlacesByRatingService({int limit = 5}) async {
  final response = await Supabase.instance.client
      .from('places')
      .select()
      .order('rating', ascending: false)
      .limit(limit);

  // 🔍 Check for null or empty
  if (response == null || response.isEmpty) return [];

  print(response);

  return response.map<Place>((placeData) {
    return Place(
      id: placeData['id'],
      googlePlaceId: placeData['googlePlaceId'],
      name: placeData['name'],
      address: placeData['address'],
      latitude: placeData['latitude'],
      longtitude: placeData['longtitude'],
      rating:
          (placeData['rating'] is num)
              ? (placeData['rating'] as num).toDouble()
              : 0.0,

      totalUserRatings: placeData['totalUserRating'] ?? 0,
      description: placeData['description'] ?? '',
      createdAt: DateTime.parse(placeData['createdAt']),
      createdBy: 'admin',
      updatedAt: DateTime.now(),
      updatedBy: 'admin',
      deleted: false,
      deletedAt: null,
      deletedBy: null,
      openingTime: '',
      closingTime: '',
      city: '',
      countryCode: '',
      imageUrl: '',
    );
  }).toList();
}
