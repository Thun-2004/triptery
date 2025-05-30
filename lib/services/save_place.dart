import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/entities/place/place.dart';
import '../utils/convert_to_timestamp.dart';

Future<void> savePlaceToSupabase(Place place) async {
  final supabase = Supabase.instance.client;

  try {
    final response = await supabase.from('places').insert({
      'id': place.id,
      'googlePlaceId': place.googlePlaceId,
      'name': place.name,
      'description': place.description,
      'openingTime': convertToPostgresTimestamp(place.openingTime),
      'closingtime': convertToPostgresTimestamp(place.closingTime), // note: lowercase 'time'
      'latitude': place.latitude,
      'longtitude': place.longtitude,
      'rating': place.rating,
      'totalUserRating': place.totalUserRatings,
      'address': place.address,
      'city': place.city,
      'countryCode': place.countryCode,
      'createdAt': place.createdAt.toIso8601String(),
      'createdBy': 0, // default fallback
      'updatedAt': place.updatedAt.toIso8601String(),
      'updatedBy': 0,
      'deleted': place.deleted,
      'deletedAt': place.deletedAt?.toIso8601String(),
      'deletedBy': place.deletedBy ?? 0,
      'imageUrl': place.imageUrl,
    });

    print('📤 Supabase insert response: $response');
  } catch (e) {
    print('🔥 Supabase insert failed: $e');
    throw Exception('Failed to save place to Supabase.');
  }
}

