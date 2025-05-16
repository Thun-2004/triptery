import '../entities/place/place_review.dart';
import 'package:uuid/uuid.dart';

List<PlaceReview> mapGoogleJsonToPlaceReviews({
  required List<dynamic>? rawReviews,
  required String groupId,
}) {
  final uuid = const Uuid();

  if (rawReviews == null || rawReviews.isEmpty) return [];

  return rawReviews.map((r) {
    return PlaceReview(
      id: uuid.v4(),
      placeReviewGroupId: groupId,
      username: r['author_name'] ?? 'Anonymous',
      userProfilePictureUrl: r['profile_photo_url'],
      rating: (r['rating'] ?? 0).toDouble(),
      description: r['text'] ?? '',
      approved: 'true',
      createdAt: DateTime.now(),
      createdBy: 'admin',
      updatedAt: DateTime.now(),
      updatedBy: 'admin',
      deleted: 'false',
      deletedAt: null,
      deletedBy: null,
    );
  }).toList();
}
