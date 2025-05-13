class PlaceReview {
  final String id;
  final String placeReviewGroupId;
  final String username;
  final String userProfilePictureUrl;
  final double rating;
  final String description;
  final String approved;
  final String createdAt;
  final String createdBy;
  final String updatedAt;
  final String updatedBy;
  final String deleted;
  final String deletedAt;
  final String deletedBy;

  PlaceReview({
    required this.id,
    required this.placeReviewGroupId,
    required this.username,
    required this.rating,
    required this.description,
    required this.approved,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    required this.updatedBy,
    required this.deleted,
    required this.deletedAt,
    required this.deletedBy,
    String? userProfilePictureUrl,
  }) : userProfilePictureUrl =
           userProfilePictureUrl ??
           'https://www.gravatar.com/avatar/placeholder?d=mp&s=200';
}
