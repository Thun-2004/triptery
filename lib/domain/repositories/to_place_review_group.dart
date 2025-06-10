import '../entities/place/place_review_group.dart';

PlaceReviewGroup mapGoogleJsonToReviewGroup({
  required String groupId,
  required String placeId,
}) {
  return PlaceReviewGroup(
    id: groupId,
    companyName: 'Google Reviews',
    companyLogo: 'assets/images/google_icon.png',
    placeId: placeId,
  );
}
