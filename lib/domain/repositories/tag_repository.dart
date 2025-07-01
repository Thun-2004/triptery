
import '../entities/tag/tag.dart';

abstract class TagRepository {
  List<Tag> getAllTags();
  List<Tag> getTagsByPlanId(int planId); 
  void updateSelectedTags(String tagId, String planId);
}