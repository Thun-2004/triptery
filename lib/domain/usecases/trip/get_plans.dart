

import 'package:triptery/data/repositories/plan_repository.dart';
import 'package:triptery/domain/entities/trip/plan.dart';
import 'package:triptery/domain/entities/trip/plan_review.dart';

class GetPlans {
  final PlanRepositoryImpl repository; 
  GetPlans({required this.repository}); 

  Plan execute() {
    return repository.getPlanById('1');
  }
}

class GetPlanReviews {
  final PlanRepositoryImpl repository; 
  GetPlanReviews({required this.repository}); 

  List<PlanReview> execute(String planId) {
    return repository.getPlanReviews(planId);
  }
}