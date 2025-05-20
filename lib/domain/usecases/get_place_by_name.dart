import '../entities/place/place.dart';
import '../../data/repositories/place_repository.dart';

class GetPlaceByName {
  final PlaceRepository repository;

  GetPlaceByName(this.repository);

  Future<Place> execute(String name) async {
    // Step 1: Use Google to get place from name
    final cachedPlace = await repository.getCachedPlaceByName(name);

    if (cachedPlace != null) {
      return cachedPlace;
    }

    // Step 3: If not cached, fetch from Google using name (which does full fetch + save)
    final place = await repository.fetchAndCachePlaceFromGoogle(name);
    return place;
  }
}
