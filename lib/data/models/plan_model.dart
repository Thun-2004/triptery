import 'package:triptery/domain/entities/trip/plan.dart';

class PlanModel {
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

  PlanModel({
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

  //convert to JSON
  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      id: json['id'],
      name: json['name'],
      ownerId: json['ownerId'],
      ownerName: json['ownerName'],
      ownerProfilePictureUrl: json['ownerProfilePictureUrl'],
      coverImageUrl: json['coverImageUrl'],
      totalCopied: json['totalCopied'],
      totalLikes: json['totalLikes'],
      dayStart: DateTime.parse(json['dayStart']),
      dayEnd: DateTime.parse(json['dayEnd']),
      dayCount: json['dayCount'], 
      location: json['location'], 
      note: json['note'],
      visibility: PlanVisibility.values.firstWhere(
        (e) => e.toString().split('.').last == json['visibility'],
      ), 
      party: Party.values.firstWhere(
        (e) => e.toString().split('.').last == json['party'],
      ),
      budget: Budget.values.firstWhere(
        (e) => e.toString().split('.').last == json['budget'],
      ), // Assuming budget is stored as an index
      createdAt: DateTime.parse(json['createdAt'])
    );
  }

  Plan toEntity(){
    return Plan(
      id: id,
      name: name,
      ownerId: ownerId,
      ownerName: ownerName,
      ownerProfilePictureUrl: ownerProfilePictureUrl,
      coverImageUrl: coverImageUrl,
      totalCopied: totalCopied,
      totalLikes: totalLikes,
      dayStart: dayStart,
      dayEnd: dayEnd,
      dayCount: dayCount,
      location: location,
      note: note,
      visibility: visibility,
      party: party,
      budget: budget,
      createdAt: createdAt
    );
  }
}

