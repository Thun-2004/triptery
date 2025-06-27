import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/presentation/DI/init_plan.dart';
import 'package:triptery/presentation/controllers/plan_controller.dart';
import 'package:triptery/presentation/controllers/plan_review_controller.dart';
import 'package:triptery/presentation/pages/trip/trip_flow_control_sheet.dart';
import 'package:triptery/presentation/pages/trip/trip_summary_sheet.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:triptery/presentation/pages/trip_review_page.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';
import 'package:triptery/presentation/widgets/tag.dart';

class HeaderSection extends StatefulWidget {
  final VoidCallback toggleMap;
  const HeaderSection({super.key, required this.toggleMap});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  final PlanReviewController planReviewController =
      Get.find<PlanReviewController>();
  bool isClicked = false;

  void _openBottomModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      showDragHandle: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: TripFlowControlSheet(),
        );
      },
    );
  }

  void openReviewPage() {
    log("open review page");
    Get.to(() => ReviewsPage());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final plan = Get.find<PlanController>().plan.value;

      return Container(
        height: 350,
        decoration: BoxDecoration(color: AppColors.grayBg),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  image: DecorationImage(
                    image: NetworkImage(
                      plan != null
                          ? plan.coverImageUrl
                          : 'https://i.pinimg.com/736x/39/58/56/395856fb254a9c67277ba2c635613923.jpg', // Replace with your image path
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Gradient overlay
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0.7),
                      AppColors.grayBg.withOpacity(1),
                    ],
                    stops: const [0.5, 0.6, 0.7, 1.0],
                  ),
                ),
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16, top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.arrow_back, color: AppColors.white),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              LucideIcons.pencil,
                              color: AppColors.white,
                            ),
                            onPressed: () {
                              // widget.tripController.toggleEditTripInfo();
                              _openBottomModal();
                            },
                          ),

                          SizedBox(width: 8),

                          Icon(
                            LucideIcons.copy,
                            size: 20,
                            color: AppColors.white,
                          ),
                          SizedBox(width: 8),
                          Icon(
                            LucideIcons.ellipsisVertical,
                            color: AppColors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: plan != null ? plan.name : 'Untitled',
                                    type: TextType.heading,
                                    color: AppColors.black,
                                  ),

                                  Row(
                                    children: [
                                      Text("by  "),
                                      CircleAvatar(
                                        backgroundImage: AssetImage(
                                          plan != null
                                              ? plan.ownerProfilePictureUrl
                                              : "assets/images/guess.jpg",
                                        ),
                                        radius: 12,
                                      ),
                                      const SizedBox(width: 5),
                                      CustomText(
                                        text:
                                            plan != null
                                                ? plan.ownerName
                                                : 'Guest',
                                        type: TextType.body,
                                        color: AppColors.black,
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(height: 2),

                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        LucideIcons.calendar,
                                        size: 16,
                                        color: AppColors.black,
                                      ),
                                      const SizedBox(width: 4),
                                      CustomText(
                                        text:
                                            plan != null
                                                ? '${plan.dayCount} days'
                                                : '0 days',
                                        type: TextType.body,
                                        color: AppColors.black,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        LucideIcons.mapPin,
                                        size: 16,
                                        color: AppColors.black,
                                      ),
                                      CustomText(
                                        text:
                                            plan != null ? plan.location : '-',
                                        type: TextType.body,
                                        color: AppColors.black,
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(height: 3),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        size: 20,
                                        color: AppColors.black,
                                      ),
                                      const CustomText(
                                        text: '2',
                                        type: TextType.body,
                                        color: AppColors.black,
                                      ),
                                      const SizedBox(width: 4),
                                      Row(
                                        children: List.generate(
                                          3,
                                          (_) => const Icon(
                                            LucideIcons.dollarSign,
                                            size: 16,
                                            color: AppColors.black,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 4),

                                      Tag(
                                        text:
                                            '${planReviewController.rating.value} (${planReviewController.planReview.length})',
                                        textSize: 12,
                                        textColor: AppColors.black,
                                        tagColor: AppColors.white,
                                        height: 22,
                                        borderRadius: 4,
                                        borderColor: AppColors.gray,
                                        icon: Icons.star,
                                        iconColor: const Color.fromARGB(
                                          255,
                                          255,
                                          193,
                                          59,
                                        ),
                                        onTap: openReviewPage,
                                      ),
                                      const SizedBox(width: 5),
                                      Tag(
                                        text:
                                            plan != null
                                                ? plan.totalLikes.toString()
                                                : '-',
                                        textSize: 12,
                                        textColor: AppColors.black,
                                        tagColor: AppColors.white,
                                        height: 22,
                                        borderRadius: 4,
                                        borderColor: AppColors.gray,
                                        icon: LucideIcons.heart,
                                        iconColor: AppColors.black,
                                      ),
                                      const SizedBox(width: 5),
                                      Tag(
                                        text:
                                            plan != null
                                                ? plan.totalLikes.toString()
                                                : '-',
                                        textSize: 12,
                                        textColor: AppColors.black,
                                        tagColor: AppColors.white,
                                        height: 22,
                                        borderRadius: 4,
                                        borderColor: AppColors.gray,
                                        icon: LucideIcons.clipboardList,
                                        iconColor: AppColors.black,
                                      ),

                                      const SizedBox(width: 8),
                                    ],
                                  ),

                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 0,
                                      horizontal: 0,
                                    ),
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color:
                                          isClicked
                                              ? AppColors.orange_950
                                              : AppColors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color:
                                            isClicked
                                                ? AppColors.orange_950
                                                : AppColors.darkGray,
                                        width: 1,
                                      ),
                                    ),
                                    child: IconButton(
                                      icon: Icon(LucideIcons.map),
                                      iconSize: 16,
                                      color:
                                          isClicked
                                              ? AppColors.white
                                              : AppColors.black,
                                      onPressed: (() {
                                        // Toggle map view
                                        widget.toggleMap();
                                        setState(() {
                                          isClicked = !isClicked;
                                        });
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 5),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
