
class PlanReview {
  final String id;
  final String userId;
  final String username;
  final String userProfilePictureUrl;
  final String planId;
  final int rating;
  final String description;
  final int createdAt;

  PlanReview({
    required this.id,
    required this.userId,
    required this.username,
    required this.userProfilePictureUrl,
    required this.planId,
    required this.rating,
    required this.description,
    required this.createdAt,
  });

}