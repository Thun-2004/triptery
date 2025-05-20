import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/entities/place/place.dart';

Future<void> savePlaceToSupabase(Place place) async {
  final supabase = Supabase.instance.client;

  final response = await supabase
      .from('test_place.place') // schema.table
      .insert({
        'id': place.id,
        'google_place_id': place.googlePlaceId,
        'name': place.name,
        'formatted_address': place.address,
        'lat': place.latitude,
        'lng': place.longitude,
        'rating': place.rating,
        'user_ratings_total': place.totalUserRatings,
        'description': place.description,
        'created_at': place.createdAt.toIso8601String(),
      });

  if (response.error != null) {
    throw Exception('Failed to save place: ${response.error!.message}');
  }
}
