import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/domain/entities/trip/plan.dart';
import 'package:triptery/presentation/controllers/plan_controller.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';
import 'package:triptery/presentation/widgets/trip/components/trip_tag.dart';

class TripSummaryWindow extends StatefulWidget {
  const TripSummaryWindow({
    super.key,
    required this.onChangeGroup,
    required this.onChangeBudget,
    required this.onChangeCalendar,
    required this.onChangeTag,
  });

  final VoidCallback onChangeGroup;
  final VoidCallback onChangeBudget;
  final VoidCallback onChangeCalendar;
  final VoidCallback onChangeTag;

  @override
  _TripSummaryWindowState createState() => _TripSummaryWindowState();
}

class _TripSummaryWindowState extends State<TripSummaryWindow> {
  bool _isPublic = true;
  bool _showCursor = false;
  final FocusNode _tripNameFocus = FocusNode();
  final planController = Get.find<PlanController>();

  double _estimateTagWidth(String tag) {
    const basePadding = 16; // adjust based on your TripTag padding
    const charWidth = 8; // approximate per character
    return tag.length * charWidth + basePadding * 2;
  }

  @override
  void initState() {
    super.initState();
    _tripNameFocus.addListener(() {
      setState(() {
        _showCursor = _tripNameFocus.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _tripNameFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(color: Colors.white),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        'https://i.pinimg.com/736x/b5/ea/78/b5ea78bc0bac20e8bda063b4f168aeda.jpg',
                        width: double.infinity,
                        height: 140,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black54,
                      ),
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.camera_alt, color: Colors.white),
                    ),
                  ],
                ),
                Obx(() {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5, top: 15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: 'Trip Name',
                                        type: TextType.subHeading,
                                        color: AppColors.darkGray,
                                        textSize: 14,
                                      ),
                                      TextFormField(
                                        initialValue: planController.plan.value?.name ?? 'Untitled',
                                        autofocus: false,
                                        focusNode: _tripNameFocus,
                                        showCursor: _showCursor,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          // labelText: 'Enter trip username',
                                        ),
                                        onTap: () {
                                          setState(() {
                                            _showCursor = true;
                                          });
                                        },
                                        onChanged: (value) {
                                          planController.updatePlanName(value);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Trip Dates',
                              type: TextType.subHeading,
                              color: AppColors.darkGray,
                              textSize: 14,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'May 25 to May 27, 2025',
                                  type: TextType.subHeading,
                                  color: AppColors.black,
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    textDirection: TextDirection.rtl,
                                    size: 16,
                                  ),
                                  onPressed: widget.onChangeCalendar,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Party',
                              type: TextType.subHeading,
                              color: AppColors.darkGray,
                              textSize: 14,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'A couple',
                                  type: TextType.subHeading,
                                  color: AppColors.black,
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    textDirection: TextDirection.rtl,
                                    size: 16,
                                  ),
                                  onPressed: widget.onChangeGroup,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Budget',
                              type: TextType.subHeading,
                              color: AppColors.darkGray,
                              textSize: 14,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'Luxury',
                                  type: TextType.subHeading,
                                  color: AppColors.black,
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    textDirection: TextDirection.rtl,
                                    size: 16,
                                  ),
                                  onPressed: widget.onChangeBudget,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 15, right: 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Invited Friends',
                              type: TextType.subHeading,
                              color: AppColors.darkGray,
                              textSize: 14,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 32,
                                  width:
                                      60, // adjust width based on number of avatars
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        child: CircleAvatar(
                                          radius: 16,
                                          backgroundImage: NetworkImage(
                                            'https://i.pinimg.com/736x/cc/ef/e1/ccefe13166d611943acdaca183e2663c.jpg', // replace with real URL
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 20,
                                        child: CircleAvatar(
                                          radius: 16,
                                          backgroundImage: NetworkImage(
                                            'https://i.pinimg.com/736x/c7/11/a5/c711a50ef7ee499797e24cfe9b18898b.jpg',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.arrow_forward_ios, size: 16),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Visibility',
                              type: TextType.subHeading,
                              color: AppColors.darkGray,
                              textSize: 14,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'Private trip',
                                  type: TextType.subHeading,
                                  color: AppColors.black,
                                ),
                                // ToggleSwitch(),
                                Transform.scale(
                                  scale: 0.8,
                                  child: Switch(
                                    value:
                                        planController.plan.value?.visibility ==
                                                PlanVisibility.public
                                            ? true
                                            : false,
                                    onChanged: (bool value) {
                                      setState(() {
                                        _isPublic = value;
                                      });
                                    },
                                    activeColor: const Color.fromARGB(
                                      255,
                                      81,
                                      234,
                                      160,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Tags',
                              type: TextType.subHeading,
                              color: AppColors.darkGray,
                              textSize: 14,
                            ),

                            LayoutBuilder(
                              builder: (context, constraints) {
                                double maxWidth = constraints.maxWidth;

                                double usedWidth = 0;
                                int shownCount = 0;

                                List<Widget> tagWidgets = [];

                                final tags = planController.tags.value ?? [];

                                for (var tag in tags) {
                                  double tagWidth = _estimateTagWidth(tag.name);

                                  if (usedWidth + tagWidth > maxWidth - 50) {
                                    break;
                                  }

                                  usedWidth += tagWidth;
                                  shownCount += 1;

                                  tagWidgets.add(
                                    TripTag(tagId: tag.id, tagName: tag.name),
                                  );
                                }

                                int remaining = tags.length - shownCount;
                                if (remaining > 0) {
                                  tagWidgets.add(
                                    TripTag(
                                      tagId: "-1",
                                      tagName: "+$remaining",
                                    ),
                                  );
                                }

                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: tagWidgets),
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        textDirection: TextDirection.rtl,
                                        size: 16,
                                      ),
                                      onPressed: widget.onChangeTag,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
                // Add your trip summary details here
              ],
            ),
          ),
        ),
      ),
    );
  }
}
