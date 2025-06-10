
class Notifications {
  final String id;
  final String userId;
  final String userName;
  final String userProfilePictureUrl;
  final String content;
  final String senderId;
  final bool seen;
  final DateTime createdAt;

  Notifications({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userProfilePictureUrl,
    required this.content,
    required this.createdAt,
    required this.seen,
    required this.senderId,
  });
}