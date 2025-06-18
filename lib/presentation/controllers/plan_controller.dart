import 'dart:developer';

import 'package:get/get.dart';
import 'package:triptery/domain/entities/trip/plan.dart';
import 'package:triptery/domain/usecases/trip/get_plans.dart';

// This controller is responsible for managing the state of the plan data in the application.

class PlanController extends GetxController {
  final GetPlans getPlans; 

  PlanController({required this.getPlans});
  var plan = Rx<Plan?>(null);
  var isLoading = true.obs; 

  @override
  void onInit() {
    super.onInit();
    fetchPlan();
    log("🚀 PlanController initialized");
  }

  Future<void> fetchPlan() async {
    try {
      isLoading(true);
      final result = await getPlans.execute();
      plan.value = result;
      log("✅ Plan fetched: ${plan.value?.name}");
    } finally {
      isLoading(false); 
    }
  }

  //FIXME: Add methods loading to เเบ่ง load plan/trip อาจจะ load plan ก่อนแล้วค่อย load trip but add to the same response
  //FIXME: Add another fields in Plan to show all trips in the plan like plan.trips = [Trip1, Trip2, Trip3]
}