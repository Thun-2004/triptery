

import 'package:triptery/data/datasources/plan_data_source.dart';
import 'package:triptery/data/models/plan_model.dart';
import 'package:triptery/data/models/plan_review_model.dart';
import 'package:triptery/domain/entities/trip/plan.dart';
import 'package:triptery/domain/entities/trip/plan_review.dart';
import 'package:triptery/domain/repositories/plan_repository.dart';

class PlanRepositoryImpl implements PlanRepository {
  final PlanDataSource planDataSource;
  PlanRepositoryImpl({required this.planDataSource});

  //FIXME: change to future later on cuz this is a mock repository
  @override
  Plan getPlanById(int planId){
    final result = planDataSource.getPlanbyId();
    final plan = PlanModel.fromJson(result).toEntity();
    return plan;
  }

  //FIXME: change to future later on cuz this is a mock repository
  @override
  List<PlanReview> getPlanReviews(int planId){
    final result = planDataSource.getPlanReviews();
    final planReviews = result.map((review) => PlanReviewModel.fromJson(review).toEntity()).toList();
    return planReviews;
  }

  @override
  void addDay(int planId) {
    // final result = planDataSource.getPlanbyId();
    // result['dayCount'] += 1; 
    // final updatedPlan = PlanModel.fromJson(result).toEntity();
    // planDataSource.updatePlan(updatedPlan); 
  }

  @override
  void deleteDay(int planId, int dayId) { 
  }

}

