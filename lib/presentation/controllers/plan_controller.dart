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
  }

  Future<void> fetchPopularMovies() async {
    try {
      isLoading(true); 
      final result = await getPlans.execute();
      plan.value = result; 
    } finally {
      isLoading(false); 
    }
  }
}