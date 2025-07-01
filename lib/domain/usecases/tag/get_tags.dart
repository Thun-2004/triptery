
import 'package:triptery/data/repositories/tag_repository.dart';
import 'package:triptery/domain/entities/tag/tag.dart';

class GetTagsUseCases {
  final TagRepositoryImpl tagRepository; 

  GetTagsUseCases({required this.tagRepository}); 

  List<Tag> getAllTags() {
    return tagRepository.getAllTags();
  }

  List<Tag> getTagsByPlanId(int planId) {
    return tagRepository.getTagsByPlanId(planId);
  }

  void updateSelectedTags(String tagId, String planId) {
    tagRepository.updateSelectedTags(tagId, planId);
  }

}

