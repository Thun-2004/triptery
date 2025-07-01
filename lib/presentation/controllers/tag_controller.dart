import 'dart:developer';

import 'package:get/get.dart';
import 'package:triptery/domain/entities/tag/tag.dart';
import 'package:triptery/domain/usecases/tag/get_tags.dart';
import 'package:triptery/presentation/controllers/plan_controller.dart';

class TagController extends GetxController {
  final GetTagsUseCases getTagsUseCases;
  final planController = Get.find<PlanController>();
  var selectedTags = <Tag>[].obs;
  var tags = <Tag>[].obs;
  List<Tag> get tagsValue => tags.toList();
  var isLoading = true.obs;

  TagController({required this.getTagsUseCases});

  @override
  void onInit() {
    super.onInit();
    fetchTags();
    fetchSelectedTags(1);
  }

  Future<void> fetchTags() async {
    try {
      isLoading(true);
      final result = getTagsUseCases.getAllTags();
      tags.value = result;
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchSelectedTags(int planId) async {
    try {
      isLoading(true);
      final result = getTagsUseCases.getTagsByPlanId(planId);
      selectedTags.value = result;
    } finally {
      isLoading(false);
    }
  }

  void toggleTag(String tagId) {
    Tag tag = tags.firstWhere((tag) => tag.id == tagId);

    if (!selectedTags.contains(tag)) {
      selectedTags.add(tag);
      getTagsUseCases.updateSelectedTags(
        tagId,
        planController.planWithTagValue!.plan.id,
      );
    } else {
      selectedTags.remove(tag);
    }
  }
}
