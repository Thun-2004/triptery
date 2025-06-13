import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/presentation/controllers/place_controller.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';
import 'package:triptery/presentation/widgets/trip/components/add_place_card.dart';

class AddPlaceSheet extends StatefulWidget {
  const AddPlaceSheet({super.key});

  @override
  AddPlaceSheetState createState() => AddPlaceSheetState();
}

class AddPlaceSheetState extends State<AddPlaceSheet> {
  final PlaceController placeController = Get.put(PlaceController());

  //temp
  void onSearch(String query) {
    log("Search query: $query");
  }

  @override
  void initState() {
    super.initState();
    placeController.init();
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
                      placeController.clearSelectedPlaces();
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
                  CustomText(
                    text: 'Done',
                    type: TextType.subHeading,
                    color: Colors.black,
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
                          placeController.selectedPlaces.isEmpty
                              ? 'No places selected'
                              : 'Selected places (${placeController.selectedPlaces.length})',
                      type: TextType.subHeading,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 120,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ...placeController.selectedPlaces.map(
                            (place) => AddPlaceCard(
                              placeId: int.parse(place.id),
                              placeName: place.name,
                              placeImage: place.imageUrl,
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
                            ...placeController.recommendedPlaces.map(
                              (place) => AddPlaceCard(
                                placeId: int.parse(place.id),
                                placeName: place.name,
                                placeImage: place.imageUrl,
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
                          ...placeController.bookmarkedPlaces.map(
                            (place) => AddPlaceCard(
                              placeId: int.parse(place.id),
                              placeName: place.name,
                              placeImage: place.imageUrl,
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
