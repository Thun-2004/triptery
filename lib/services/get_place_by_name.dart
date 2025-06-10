import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:triptery/domain/entities/place/place.dart';


Future<Place?> getCachedPlaceByNameService(String name) async {
  final response = await Supabase.instance.client
      .from('test_place.place')
      .select()
      .eq('name', name) // 🔍 exact match on name
      .maybeSingle();

  if (response == null) return null;

  return Place(
    id: response['id'],
    googlePlaceId: response['google_place_id'],
    name: response['name'],
    address: response['address'],
    latitude: response['latitude'],
    longtitude: response['longitude'],
    rating: (response['rating'] ?? 0).toDouble(),
    totalUserRatings: response['user_ratings_total'] ?? 0,
    description: response['description'] ?? '',
    createdAt: DateTime.parse(response['created_at']),
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
}
