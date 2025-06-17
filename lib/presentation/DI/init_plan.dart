
import 'dart:developer';

import 'package:get/get.dart';
import 'package:triptery/data/datasources/plan_data_source.dart';
import 'package:triptery/data/repositories/plan_repository.dart';
import 'package:triptery/domain/usecases/trip/get_plans.dart';
import 'package:triptery/presentation/controllers/plan_controller.dart';

//dependencies injection
//help initialize controllers and dependencies
// this is the main entry point for the dependency injection in the presentation layer
//call if user is valid
//init widely use controller here like user controller
//otherwise use Get.lazyPut(), Get.put()
class PlanDI {
  static void init() {
    final dataSource = PlanDataSource();
    final repository = PlanRepositoryImpl(planDataSource: dataSource);
    final getPopularMovies = GetPlans(repository: repository);
    Get.put(PlanController(getPlans: getPopularMovies));
  }
}
