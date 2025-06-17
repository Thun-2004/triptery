enum PlanVisibility {
  public,
  private,
}

class Plan {
  final String id;
  final String name;
  final String ownerId;
  final String ownerName;
  final String ownerProfilePictureUrl;
  final String coverImageUrl;
  final int totalCopied;
  final int totalLikes;
  final DateTime dayStart;
  final DateTime dayEnd;
  final int dayCount; 
  final String location; 
  final String note;
  final PlanVisibility visibility; 
  final int budget; 
  final DateTime createdAt;

  Plan({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.ownerName,
    required this.ownerProfilePictureUrl,
    required this.coverImageUrl,
    required this.totalCopied,
    required this.totalLikes,
    required this.dayStart,
    required this.dayEnd,
    required this.dayCount, 
    required this.location, 
    required this.note,
    required this.visibility,
    required this.budget,
    required this.createdAt,
  });

}

