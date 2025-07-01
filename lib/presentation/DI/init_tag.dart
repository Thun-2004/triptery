

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:triptery/data/datasources/tag_data_source.dart';
import 'package:triptery/data/repositories/tag_repository.dart';
import 'package:triptery/domain/usecases/tag/get_tags.dart';
import 'package:triptery/presentation/controllers/tag_controller.dart';

class TagDI {
  static void init() {
    final tagDataSource = TagDataSource();
    final tagRepository = TagRepositoryImpl(tagDataSource: tagDataSource);
    final getTagsUseCases = GetTagsUseCases(tagRepository: tagRepository);
    Get.put(TagController(getTagsUseCases: getTagsUseCases));
  }
}