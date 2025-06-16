
import 'package:triptery/domain/entities/trip/plan.dart';
import 'package:triptery/domain/entities/trip/plan_review.dart';

//FIXME: change to future later on cuz this is a mock repository
abstract class PlanRepository {
  Plan getPlanById(String planId);
  List<PlanReview> getPlanReviews(String planId);
}
