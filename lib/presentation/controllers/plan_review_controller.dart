import 'dart:developer';

import 'package:get/get.dart';
import 'package:triptery/domain/entities/trip/plan_review.dart';
import 'package:triptery/domain/usecases/trip/get_plans.dart';

// This controller is responsible for managing the state of the plan data in the application.

class PlanReviewController extends GetxController {
  final GetPlanReviews getPlanReviews;

  PlanReviewController({required this.getPlanReviews});
  var planReview = RxList<PlanReview>([]);
  var isLoading = true.obs;
  RxDouble rating = 0.0.obs; 

  @override
  void onInit() {
    super.onInit();
    fetchPlanReview(1);
    log("🚀 PlanController initialized");
  }

  Future<void> fetchPlanReview(int planId) async {
    try {
      isLoading(true);
      final result = await getPlanReviews.execute(planId);
      planReview.value = result;
      fetchAvgRating();
      log("✅ Plan review fetched: ${planReview[0].description}");
    } catch (e) {
      log("❌ Error fetching plan review: $e");
    } finally {
      isLoading(false);
    }
  }

  void addPlanReview(int userId, PlanReview review){
    planReview.insert(0, review);
    log("✅ Plan review added: ${planReview[planReview.length-1].description}");
  }

  void fetchAvgRating() {
    if (planReview.isEmpty) {
      rating.value = 0.0;
      return;
    }
    double sum = 0.0; 
    for (var review in planReview) {
      sum += review.rating;
    }
    rating.value = double.parse((sum / planReview.length).toStringAsFixed(1));
  }

  // void reCalcRating(int newRating) {
  //   rating.value = (rating.value + newRating) / planReview.length;
  //   log("✅ Average rating recalculated: ${rating.value}");
  // }
}