import 'package:triptery/domain/entities/plan/plans.dart';
import '../../services/get_top_plan.dart'; // import your service file

class GetTopPlans {
  final int limit;

  GetTopPlans({this.limit = 5}); // allow optional custom limit

  Future<List<Plan>> execute() async {
    return await getTopPlansService(limit: limit);
  }
}
