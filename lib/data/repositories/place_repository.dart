import '../../domain/entities/place/place.dart';
import '../../domain/entities/place/place_review_group.dart';
import '../../domain/entities/place/place_review.dart';

abstract class PlaceRepository {
  Future<Place> getPlaceById(String placeId);
  Future<List<PlaceReviewGroup>> getPlaceReviewGroupsByPlaceId(String placeId);
  Future<List<PlaceReview>> getPlaceReviewsByGroupId(String groupId);
}
