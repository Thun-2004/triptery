enum PlanVisibility { public, private }
enum Party { onlyMe, couple, family, friends, work }
enum Budget { cheap, balanced, luxury }

class Plan {
  final String id;
  String name;
  final String ownerId;
  final String ownerName;
  String ownerProfilePictureUrl;
  String coverImageUrl;
  int totalCopied;
  int totalLikes;
  DateTime dayStart;
  DateTime dayEnd;
  int dayCount;
  String location;
  String note;
  PlanVisibility visibility;
  Budget budget;
  Party party; 
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
    required this.party, 
    required this.budget,
    required this.createdAt,
  });

}
