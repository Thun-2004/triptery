
import 'dart:developer';

import 'package:get/get.dart';
import 'package:triptery/data/datasources/plan_data_source.dart';
import 'package:triptery/data/datasources/tag_data_source.dart';
import 'package:triptery/data/repositories/plan_repository.dart';
import 'package:triptery/data/repositories/tag_repository.dart';
import 'package:triptery/domain/usecases/trip/get_plans.dart';
import 'package:triptery/presentation/controllers/plan_controller.dart';
import 'package:triptery/presentation/controllers/plan_review_controller.dart';

//dependencies injection
//help initialize controllers and dependencies
// this is the main entry point for the dependency injection in the presentation layer
//call if user is valid
//init widely use controller here like user controller
//otherwise use Get.lazyPut(), Get.put()
class PlanDI {
  static void init() {
    final planDataSource = PlanDataSource();
    final tagDataSource = TagDataSource(); 
    final planRepository = PlanRepositoryImpl(planDataSource: planDataSource);
    final tagRepository = TagRepositoryImpl(tagDataSource: tagDataSource);
    final getPopularMovies = GetPlans(planRepository: planRepository, tagRepository: tagRepository);
    Get.put(PlanController(getPlans: getPopularMovies));
  }
}

class PlanReviewDI {
  static void init() {
    final planReviewDataSource = PlanDataSource();
    final repository = PlanRepositoryImpl(planDataSource: planReviewDataSource);
    final getPlanReviews = GetPlanReviews(repository: repository);
    Get.put(PlanReviewController(getPlanReviews: getPlanReviews));
  }
}
