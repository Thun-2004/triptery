
import 'package:triptery/domain/entities/trip/plan_review.dart';

class PlanReviewModel {
  final String id;
  final String userId;
  final String username;
  final String userProfilePictureUrl;
  final String planId;
  final int rating;
  final String description;
  final int createdAt;

  PlanReviewModel({
    required this.id,
    required this.userId,
    required this.username,
    required this.userProfilePictureUrl,
    required this.planId,
    required this.rating,
    required this.description,
    required this.createdAt,
  });

  factory PlanReviewModel.fromJson(Map<String, dynamic> json) {
    return PlanReviewModel(
      id: json['id'],
      userId: json['userId'],
      username: json['username'],
      userProfilePictureUrl: json['userProfilePictureUrl'],
      planId: json['planId'],
      rating: json['rating'],
      description: json['description'],
      createdAt: json['createdAt'],
    );
  }

  PlanReview toEntity() {
    return PlanReview(
      id: id,
      userId: userId,
      username: username,
      userProfilePictureUrl: userProfilePictureUrl,
      planId: planId,
      rating: rating,
      description: description,
      createdAt: createdAt,
    );
  }
}