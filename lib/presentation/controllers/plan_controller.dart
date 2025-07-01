import 'dart:developer';

import 'package:get/get.dart';
import 'package:triptery/domain/entities/tag/tag.dart';
import 'package:triptery/domain/entities/trip/plan_with_tag.dart';
import 'package:triptery/domain/entities/trip/plan.dart';
import 'package:triptery/domain/usecases/trip/get_plans.dart';

// This controller is responsible for managing the state of the plan data in the application.

class PlanController extends GetxController {
  final GetPlans getPlans;

  PlanController({required this.getPlans});

  var isLoading = true.obs;

  var planWithTag = Rx<PlanWithTag?>(null);
  var plan = Rx<Plan?>(null);
  var tags = RxList<Tag>([]);
  PlanWithTag? get planWithTagValue => planWithTag.value;

  @override
  void onInit() {
    super.onInit();
    // fetchPlan();
    fetchPlanWithTag(1);
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

  void updatePlan(Plan newPlan) {
    plan.value = newPlan;
    log("🔄 Plan updated: ${plan.value?.name}");
  }

  void updatePlanName(String newName) {
    if (plan.value != null) {
      plan.value?.name = newName;
      plan.refresh(); //FIXME: shouldn't use refresh
      if (planWithTag.value != null) {
        planWithTag.value!.plan.name = plan.value!.name;
      }
      log("🔄 Plan name updated: ${plan.value?.name}");
    } else {
      log("❗️ Cannot update name, plan is null");
    }
  }

  void updatePlanParty(Party newParty) {
    if (plan.value != null) {
      plan.value?.party = newParty;
      plan.refresh(); //FIXME: shouldn't use refresh
      if (planWithTag.value != null) {
        planWithTag.value!.plan.party = plan.value!.party;
      }
      log("🔄 Plan party updated: ${plan.value?.party}");
    } else {
      log("❗️ Cannot update party, plan is null");
    }
  }

  void updatePlanBudget(Budget newBudget) {
    if (plan.value != null) {
      plan.value?.budget = newBudget;
      plan.refresh(); //FIXME: shouldn't use refresh
      if (planWithTag.value != null) {
        planWithTag.value!.plan.budget = plan.value!.budget;
      }
      log("🔄 Plan budget updated: ${plan.value?.budget}");
    } else {
      log("❗️ Cannot update budget, plan is null");
    }
  }

  Future<void> fetchPlanWithTag(int planId) async {
    try {
      isLoading(true);
      final result = getPlans.getPlanWithTag(planId);
      plan.value = result.plan;
      tags.value = result.tags; // Assuming PlanWithTag has a tags field
      planWithTag.value = result;
      log("✅ Plan with tags fetched: ${plan.value?.name}");
    } finally {
      isLoading(false);
    }
  }

  //FIXME: Add methods loading to เเบ่ง load plan/trip อาจจะ load plan ก่อนแล้วค่อย load trip but add to the same response
  //FIXME: Add another fields in Plan to show all trips in the plan like plan.trips = [Trip1, Trip2, Trip3]
}
