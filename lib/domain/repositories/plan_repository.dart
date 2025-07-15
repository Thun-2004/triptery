
import 'package:triptery/domain/entities/trip/plan.dart';
import 'package:triptery/domain/entities/trip/plan_review.dart';

//FIXME: change to future later on cuz this is a mock repository
abstract class PlanRepository {
  Plan getPlanById(int planId);
  List<PlanReview> getPlanReviews(int planId);
  void addDay(int planId); 
  void deleteDay(int planId, int dayId);
}
