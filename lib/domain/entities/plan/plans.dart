
class Plans {
  final String id;
  final String name;
  final String ownerId;
  final String ownerName;
  final String ownerProfilePictureUrl;
  final String coverImageUrl;
  final int totalView;
  final int totalCopied;
  final int totalLikes;
  final String note;
  final String visibility;
  final String budget;
  final String createdAt;

  Plans({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.ownerName,
    required this.ownerProfilePictureUrl,
    required this.coverImageUrl,
    required this.totalView,
    required this.totalCopied,
    required this.totalLikes,
    required this.note,
    required this.visibility,
    required this.budget,
    required this.createdAt,
  });
}