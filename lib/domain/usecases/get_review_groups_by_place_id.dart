import '../entities/place/place_review_group.dart';
import '../../data/repositories/place_repository.dart';

class GetPlaceReviewGroupsByPlaceId {
  final PlaceRepository repository;

  GetPlaceReviewGroupsByPlaceId(this.repository);

  Future<List<PlaceReviewGroup>> execute(String placeId) {
    return repository.getPlaceReviewGroupsByPlaceId(placeId);
  }
}
