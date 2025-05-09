import 'place_review.dart';

class PlaceReviewGroup {
  final String sourceName; // e.g., "Google", "Tripadvisor"
  final String sourceLogo; // logo image url or asset path
  final List<PlaceReview> reviews;

  PlaceReviewGroup({
    required this.sourceName,
    required this.sourceLogo,
    required this.reviews,
  });
}
