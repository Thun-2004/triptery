class Follower {
  final String followerId;  // Foreign Key
  final String followeeId;  // Foreign Key
  final DateTime createdAt;

  Follower({
    required this.followerId,
    required this.followeeId,
    required this.createdAt,
  });
}