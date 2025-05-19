import '../../domain/entities/place/place_review.dart';
import '../../data/repositories/place_repository.dart';
import '../../domain/repositories/place_repository_impl.dart';

class GetReviewsByReviewGroupId {
  final PlaceRepository repository;

  GetReviewsByReviewGroupId(this.repository);

  Future<List<PlaceReview>> execute(String groupId) {
    return repository.getPlaceReviewsByGroupId(groupId);
  }
}
