
class PlaceReviewGroup {
  final String id;
  final String companyName; // e.g., "Google", "Tripadvisor"
  final String companyLogo; // logo image url or asset path
  final String placeId;

  PlaceReviewGroup({
    required this.id,
    required this.companyName,
    required this.companyLogo,
    required this.placeId,
  });
}
