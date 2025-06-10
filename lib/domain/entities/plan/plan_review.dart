class PlanReview {
  final String id;
  final String userId;
  final String userName;
  final String userProfilePictureUrl;
  final String planId;
  final double rating;
  final String description;
  final DateTime createdAt;

  PlanReview({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userProfilePictureUrl,
    required this.planId,
    required this.rating,
    required this.description,
    required this.createdAt,
  });
}