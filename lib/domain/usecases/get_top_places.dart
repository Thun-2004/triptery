import '../entities/place/place.dart';
import '../../services/get_top_place_by_rating.dart'; // import your service file

class GetTopPlacesByRating {
  final int limit;

  GetTopPlacesByRating({this.limit = 5}); // allow optional custom limit

  Future<List<Place>> execute() async {
    return await getTopPlacesByRatingService(limit: limit);
  }
}
