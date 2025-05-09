class PlaceReview {
  final String authorName;
  final double rating;
  final String relativeTime;
  final String text;
  final String profilePhotoUrl;

  PlaceReview({
    required this.authorName,
    required this.rating,
    required this.relativeTime,
    required this.text,
    String? profilePhotoUrl,
  }) : profilePhotoUrl =
           profilePhotoUrl ??
           'https://www.gravatar.com/avatar/placeholder?d=mp&s=200'; // Default image
}
