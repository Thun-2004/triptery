import '../entities/place/place.dart';
import '../../data/repositories/place_repository.dart';

class GetPlaceById {
  final PlaceRepository repository;

  GetPlaceById(this.repository);

  Future<Place> execute(String googlePlaceId) async {
    // Try to get from cache (Supabase)
    final cachedPlace = await repository.getCachedPlaceByGoogleId(googlePlaceId);
    if (cachedPlace != null) {
      return cachedPlace;
    }

    // If not in cache, fetch from Google
    final place = await repository.fetchAndCachePlaceFromGoogle(googlePlaceId);
    return place;
  }
}
