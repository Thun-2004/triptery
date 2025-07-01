

import 'package:triptery/data/repositories/plan_repository.dart';
import 'package:triptery/data/repositories/tag_repository.dart';
import 'package:triptery/domain/entities/trip/plan_with_tag.dart';
import 'package:triptery/domain/entities/trip/plan.dart';
import 'package:triptery/domain/entities/trip/plan_review.dart';
import 'package:triptery/domain/repositories/tag_repository.dart';

class GetPlans {
  final PlanRepositoryImpl planRepository; 
  final TagRepositoryImpl tagRepository;

  GetPlans({required this.planRepository, required this.tagRepository}); 

  Plan execute() {
    return planRepository.getPlanById(1);
  }

  PlanWithTag getPlanWithTag(int planId) {
    final plan = planRepository.getPlanById(planId);
    final tags = tagRepository.getTagsByPlanId(planId);
    return PlanWithTag(plan: plan, tags: tags);
  }
}

class GetPlanReviews {
  final PlanRepositoryImpl repository; 
  GetPlanReviews({required this.repository}); 

  List<PlanReview> execute(int planId) {
    return repository.getPlanReviews(planId);
  }
}