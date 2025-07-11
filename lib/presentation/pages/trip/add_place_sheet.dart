import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/presentation/controllers/trip_controller.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';
import 'package:triptery/presentation/widgets/trip/components/add_place_card.dart';

class AddPlaceSheet extends StatefulWidget {
  const AddPlaceSheet({super.key, required this.prevPlaceId});

  final int prevPlaceId;

  @override
  AddPlaceSheetState createState() => AddPlaceSheetState();
}

class AddPlaceSheetState extends State<AddPlaceSheet> {
  final TripController tripController = Get.put(TripController());

  //temp
  void onSearch(String query) {
    log("Search query: $query");
  }

  @override
  void initState() {
    super.initState();
    // placeController.init();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(
          children: [
            // Header: not scrollable
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      overlayColor: AppColors.lightGray,
                    ),
                    onPressed: () {
                      tripController.clearSelectedPlaces();
                    },
                    child: const CustomText(
                      text: 'Clear',
                      type: TextType.subHeading,
                      color: Colors.black,
                    ),
                  ),
                  CustomText(
                    text: 'Select a place',
                    type: TextType.heading,
                    color: Colors.black,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      overlayColor: AppColors.lightGray,
                    ),
                    onPressed: () {
                      tripController.addPlaceToTripRoute(widget.prevPlaceId);
                      // Future.delayed(Duration(milliseconds: 300), () {
                      //   tripController.places.refresh(); // Force refresh after pop
                      //   tripController.routes.refresh();
                      // });
                      Navigator.pop(context);
                    },
                    child: const CustomText(
                      text: 'Done',
                      type: TextType.subHeading,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable body
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      //search bar
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 1,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.lightGray,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          onChanged: onSearch,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            prefixIcon: const Icon(
                              LucideIcons.search,
                              color: Colors.grey,
                            ),
                            suffixIcon: const Icon(
                              LucideIcons.x,
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text("Cancel"),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    //selected
                    CustomText(
                      text:
                          tripController.selectedPlaces.isEmpty
                              ? 'No places selected'
                              : 'Selected places (${tripController.selectedPlaces.length})',
                      type: TextType.subHeading,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 120,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ...tripController.selectedPlaces.map(
                            (place) => AddPlaceCard(
                              placeId: place["placeId"],
                              placeName: place["placeName"],
                              placeImage: place["placeImageUrl"],
                              // isAdded: true,
                            ),
                          ),
                        ],
                      ),
                    ),

                    //recommended
                    CustomText(
                      text: 'Recommended places',
                      type: TextType.subHeading,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 120,
                      child: Obx(
                        () => ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            ...tripController.recommendedPlaces.map(
                              (place) => AddPlaceCard(
                                placeId: place["placeId"],
                                placeName: place["placeName"],
                                placeImage: place["placeImageUrl"],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //bookmarked
                    CustomText(
                      text: 'Bookmarked places',
                      type: TextType.subHeading,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 120,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ...tripController.bookmarkedPlaces.map(
                            (place) => AddPlaceCard(
                              placeId: place["placeId"],
                              placeName: place["placeName"],
                              placeImage: place["placeImageUrl"],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
