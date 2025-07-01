
import 'package:triptery/domain/entities/tag/tag.dart';
import 'package:triptery/domain/entities/trip/plan.dart';

class PlanWithTag {
  Plan plan; 
  List<Tag> tags; 

  PlanWithTag({
    required this.plan,
    required this.tags,
  });
}