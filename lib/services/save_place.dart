import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/entities/place/place.dart';

Future<void> savePlaceToSupabase(Place place) async {
  final supabase = Supabase.instance.client;

  try {
    final response = await supabase
        .from('places')
        .insert({
          'id': place.id,
          'googlePlaceId': place.googlePlaceId,
          'name': place.name,
          'address': place.address,
          'latitude': place.latitude,
          'longtitude': place.longtitude,
          'rating': place.rating,
          'totalUserRating': place.totalUserRatings,
          'description': place.description,
          'createdAt': place.createdAt.toIso8601String(),
        });

    print('📤 Supabase insert response: $response');

  } catch (e) {
    print('🔥 Supabase insert failed: $e');
    throw Exception('Failed to save place to Supabase.');
  }
}

