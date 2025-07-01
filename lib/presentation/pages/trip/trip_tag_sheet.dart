import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triptery/presentation/controllers/tag_controller.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';
import 'package:triptery/presentation/widgets/trip/components/trip_tag.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';

class TripTagWindow extends StatefulWidget {
  @override
  TripTagWindowState createState() => TripTagWindowState();
}

class TripTagWindowState extends State<TripTagWindow> {
  final tagController = Get.find<TagController>();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 800,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                CustomText(
                  text: 'Tailor your adventure of your tastes 🌟',
                  type: TextType.heading,
                  color: Colors.black,
                ),
                const SizedBox(height: 20),
                CustomText(
                  text:
                      'Selected your travel preference to customize your trip plan.',
                  type: TextType.body,
                  color: Colors.black,
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Obx(() {
                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    ...List.generate(tagController.tagsValue.length ?? 0, (
                      index,
                    ) {
                      return TripTag(
                        tagId: tagController.tagsValue[index].id.toString(),
                        tagName: tagController.tagsValue[index].name,
                        isSelected: tagController.selectedTags.any(
                          (tag) => tag.id == tagController.tagsValue[index].id,
                        ),
                        onClick: (id) {
                          tagController.toggleTag(
                            tagController.tagsValue[index].id,
                          );
                        },
                      );
                    }),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
