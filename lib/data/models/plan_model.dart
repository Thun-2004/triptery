import 'package:triptery/domain/entities/trip/plan.dart';

class PlanModel {
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
  final String note;
  final PlanVisibility visibility; 
  final int budget; 
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
    required this.note,
    required this.visibility,
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
      note: json['note'],
      visibility: PlanVisibility.values.firstWhere(
        (e) => e.toString().split('.').last == json['visibility'],
      ), 
      budget: json['budget'],
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
      note: note,
      visibility: visibility,
      budget: budget,
      createdAt: createdAt
    );
  }
}

