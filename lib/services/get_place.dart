import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/entities/place/place.dart';

Future<Place?> getCachedPlaceByGoogleIdService(String googlePlaceId) async {
final response = await Supabase.instance.client
    .from('test_place.place')
    .select()
    .eq('google_place_id', googlePlaceId)
    .maybeSingle(); // 👈 this automatically returns `Map<String, dynamic>?`

if (response == null) return null;

return Place(
  id: response['id'],
  googlePlaceId: response['google_place_id'],
  name: response['name'],
  address: response['address'],
  latitude: response['latitude'],
  longitude: response['longitude'],
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
