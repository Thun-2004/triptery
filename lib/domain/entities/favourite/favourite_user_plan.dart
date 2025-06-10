class FavouriteUsersPlans {
  final String userId;     // Primary Key
  final String planId;     // Foreign Key
  final DateTime createdAt;

  FavouriteUsersPlans({
    required this.userId,
    required this.planId,
    required this.createdAt,
  });
}