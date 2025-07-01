
import 'package:triptery/data/datasources/tag_data_source.dart';
import 'package:triptery/data/models/tag_model.dart';
import 'package:triptery/domain/entities/tag/tag.dart';
import 'package:triptery/domain/repositories/tag_repository.dart';

class TagRepositoryImpl implements TagRepository {
  final TagDataSource tagDataSource;
  TagRepositoryImpl({required this.tagDataSource});
  
  @override
  List<Tag> getAllTags() {
    final result = tagDataSource.getTags();
    final tags = result.map((tag) => TagModel.fromJson(tag).toEntity()).toList(); 
    return tags; 
  }

  @override
  List<Tag> getTagsByPlanId(int planId) {
    final result = tagDataSource.getTagsByPlanId(planId); 
    final tags = result.map((tag) => TagModel.fromJson(tag).toEntity()).toList(); 
    return tags;
  }

  @override
  void updateSelectedTags(String tagId, String planId) {
    tagDataSource.updateSelectedTags(tagId, planId);
  }
}




