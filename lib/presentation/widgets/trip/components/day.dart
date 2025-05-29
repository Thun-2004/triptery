import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';
import 'package:triptery/presentation/widgets/trip/components/place_card.dart';
import 'package:triptery/presentation/widgets/trip/components/route_dropdown.dart';
import 'package:triptery/data/mock/mock_trips.dart';
import 'package:triptery/domain/entities/trip/trip.dart';
import 'package:triptery/presentation/controllers/trip_controller.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class Day extends StatefulWidget {
  Day({super.key, required this.day});
  final int day;
  @override
  State<Day> createState() => _DayState();
}

class _DayState extends State<Day> {
  final tripController = Get.find<TripController>();
  late bool _isEditing;

  bool _isExpanded = false;
  int _selectedIndex = 0;
  List<Trip> trips = mockTrips;
  List<Map<String, String>> routeChoices = [
    {
      // 1- 2
      //dest : placeId
      "Dest1": "1",
      "Dest2": "2",
      "mode": "Car -> Train -> Bus",
      "time": "21mins",
      "price": "100THB",
    },
    {
      //dest : placeId
      "Dest1": "1",
      "Dest2": "2",
      "mode": "Bus -> Train",
      "time": "16mins",
      "price": "140THB",
    },
    {
      //dest : placeId
      "Dest1": "1",
      "Dest2": "2",
      "mode": "Train -> Walk",
      "time": "22mins",
      "price": "130THB",
    },
    //2 -> 1
    {
      //dest : placeId
      "Dest1": "2",
      "Dest2": "1",
      "mode": "Bus -> Train",
      "time": "30mins",
      "price": "140THB",
    },
    {
      //dest : placeId
      "Dest1": "2",
      "Dest2": "1",
      "mode": "Train -> Walk",
      "time": "2mins",
      "price": "130THB",
    },

    // 2 - 3
    {
      //dest : placeId
      "Dest1": "2",
      "Dest2": "3",
      "mode": "Walk -> Train",
      "time": "40mins",
      "price": "130THB",
    },
    // 3 - 2
    {
      //dest : placeId
      "Dest1": "3",
      "Dest2": "2",
      "mode": "Train -> Walk",
      "time": "2mins",
      "price": "130THB",
    },
    // 3 - 1
    {
      //dest : placeId
      "Dest1": "3",
      "Dest2": "1",
      "mode": "Train -> Bus",
      "time": "25mins",
      "price": "130THB",
    },
    {
      //dest : placeId
      "Dest1": "1",
      "Dest2": "3",
      "mode": "Walk -> Bus",
      "time": "2mins",
      "price": "10THB",
    },
    {
      //dest : placeId
      "Dest1": "1",
      "Dest2": "5",
      "mode": "Walk -> Bus",
      "time": "2mins",
      "price": "10THB",
    },
    {
      //dest : placeId
      "Dest1": "5",
      "Dest2": "2",
      "mode": "Walk -> Bus",
      "time": "2mins",
      "price": "10THB",
    },
    {
      //dest : placeId
      "Dest1": "2",
      "Dest2": "5",
      "mode": "Walk -> Bus",
      "time": "2mins",
      "price": "10THB",
    },
    {
      //dest : placeId
      "Dest1": "5",
      "Dest2": "3",
      "mode": "Walk -> Bus",
      "time": "2mins",
      "price": "10THB",
    },
    {
      //dest : placeId
      "Dest1": "3",
      "Dest2": "5",
      "mode": "Walk -> Bus",
      "time": "2mins",
      "price": "10THB",
    },
  ];

  void _onCardSelected(int index) {
    setState(() {
      if (_selectedIndex == index) {
        _selectedIndex = -1;
      } else {
        _selectedIndex = index;
      }
      _handleReorder;
    });
  }

  void _handleReorder(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      //swap place
      final Trip item = places2.removeAt(oldIndex);
      places2.insert(newIndex, item);

      //swap time
      String tempTime = places2[newIndex].arrivalTime ?? '';
      places2[newIndex].arrivalTime = places2[oldIndex].arrivalTime;
      places2[oldIndex].arrivalTime = tempTime;


      //recalculate routes
      _selectedIndex = -1;
      _recalculateAllRoutes();
      print('Updated route: ${routes[0].routeMode} , ${routes[1].routeMode}');
    });
  }

  void _recalculateAllRoutes() {
    // Calculate how many routes we should have based on places
    int expectedRouteCount = 0;
    for (int i = 0; i < places2.length - 1; i++) {
      if (places2[i].placeId != null && places2[i + 1].placeId != null) {
        expectedRouteCount++;
      }
    }

    // Resize routes list if needed
    if (routes.length > expectedRouteCount) {
      routes = routes.sublist(0, expectedRouteCount);
    }

    // Update existing routes or add new ones
    int routeIndex = 0;
    for (int i = 0; i < places2.length - 1; i++) {
      if (places2[i].placeId != null && places2[i + 1].placeId != null) {
        // Create or update route
        if (routeIndex < routes.length) {
          // Update existing route
          routes[routeIndex] = Trip(
            id: routes[routeIndex].id,
            planId: routes[routeIndex].planId,
            day: widget.day,
            type: TripType.route,
            placeId: null,
            placeName: null,
            placeDescription: null,
            placeImageUrl: null,
            arrivalTime: null,
            routeMode: routes[routeIndex].routeMode ?? RouteMode.unselected,
            routeFrom: places2[i].placeId,
            routeTo: places2[i + 1].placeId,
            routeTotalTime: routes[routeIndex].routeTotalTime,
            routeTotalCost: routes[routeIndex].routeTotalCost,
            routeTotalDistance: routes[routeIndex].routeTotalDistance,
            routeDistance: routes[routeIndex].routeDistance,
            routeNote: routes[routeIndex].routeNote,
            note: routes[routeIndex].note,
          );
        } else {
          // Add new route
          routes.add(
            Trip(
              id: places2[i].id,
              planId: places2[i].planId,
              day: widget.day,
              type: TripType.route,
              placeId: null,
              placeName: null,
              placeDescription: null,
              placeImageUrl: null,
              arrivalTime: null,
              routeMode: RouteMode.unselected,
              routeFrom: places2[i].placeId,
              routeTo: places2[i + 1].placeId,
              routeTotalTime: null,
              routeTotalCost: null,
              routeTotalDistance: null,
              routeDistance: null,
              routeNote: null,
              note: null,
            ),
          );
        }
        routeIndex++;
      }

      print(
        'route options: ${findRouteOptions(places2[i].id, places2[i + 1].id)}',
      );
    }
  }

  void addPlace(index) {
    Trip newPlace = Trip(
      id: "1",
      planId: "1",
      day: 1,
      type: TripType.dest,
      placeId: "5",
      placeName: "Pattaya Floating Market",
      placeDescription:
          "Established since 2008, Pattaya Floating Market is riverside attraction in Pattaya displaying and showcasing the beautiful ancient Thai riverside living community and authentic ways of life",
      placeImageUrl:
          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/11/53/6d/b7/pattaya-floating-market.jpg?w=1400&h=-1&s=1",
      arrivalTime: null,
      routeMode: null,
      routeTotalTime: null,
      routeTotalCost: null,
      routeTotalDistance: null,
      routeDistance: null,
      routeNote: null,
      note: null,
    );

    places2.insert(index + 1, newPlace);
    _recalculateAllRoutes();

    setState(() {});
  }

  void deleteCard(index) {
    setState(() {
      places2.removeAt(index);
      _recalculateAllRoutes();
    });
  }

  final List<Map<String, String>> places = [
    {"name": "Place 1", "description": "Description 1", "image": ""},
    {"name": "Place 2", "description": "Description 2", "image": ""},
  ];

  List<Trip> places2 = [];
  List<Trip> routes = [];

  bool isExpanded = false;
  isExtended() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  List<Map<String, String>> findRouteOptions(String placeId1, String placeId2) {
    return routeChoices
        .where(
          (route) => (route["Dest1"] == placeId1 && route["Dest2"] == placeId2),
        )
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _isEditing = tripController.isEditingPlaceOrder;
    places2 = trips.where((trip) => trip.type == TripType.dest).toList();
    routes = trips.where((trip) => trip.type == TripType.route).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (places2.isEmpty && trips.isNotEmpty) {
      places2 = trips.where((trip) => trip.type == TripType.dest).toList();
    }

    if (trips.isEmpty) {
      routes = trips.where((trip) => trip.type == TripType.route).toList();
    }

    return Obx(() {
      _isEditing = tripController.isEditingPlaceOrder;
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.1),
              offset: const Offset(0, 2),
              blurRadius: 1,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header section (always visible)
            Container(
              decoration: BoxDecoration(
                color: _isExpanded ? AppColors.orange_950 : AppColors.white, 
                borderRadius: _isExpanded ? const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ) : BorderRadius.all(Radius.circular(16)),
              ),
              margin: _isExpanded ? const EdgeInsets.only(bottom: 20) : const EdgeInsets.all(0),

              child: InkWell(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            LucideIcons.gripVertical,
                            size: 24,
                            color: AppColors.gray,
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "Day 1",
                                type: TextType.subHeading,
                                color: _isExpanded ?AppColors.white : AppColors.black,
                              ),
                              CustomText(
                                text: "Thursday, 12th October 2023",
                                type: TextType.body,
                                color: _isExpanded ? AppColors.white : AppColors.darkGray,
                              ),
                            ],
                          ),
                        ],
                      ),

                      Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                    ],
                  ),
                ),
              ),
            ),

            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: _isExpanded ? 600 : 0,
              child:
                  _isExpanded
                      ? ReorderableListView.builder(
                        buildDefaultDragHandles: true,
                        scrollDirection: Axis.vertical,
                        // shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: places2.length,

                        onReorder: _handleReorder,
                        itemBuilder: (context, index) {
                          List<Map<String, String>> routeOptions =
                              index < places2.length - 1 &&
                                      places2[index].placeId != null &&
                                      places2[index + 1].placeId != null
                                  ? findRouteOptions(
                                    places2[index].placeId!,
                                    places2[index + 1].placeId!,
                                  )
                                  : [];
                          return Padding(
                            key: ValueKey('place-$index'),
                            padding: const EdgeInsets.only(bottom: 0.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [

                                      Container(
                                        margin: EdgeInsets.all(0),
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 4),
                                            if (places2[index].day ==
                                                    widget.day &&
                                                index <= places2.length - 1 &&
                                                places2[index].placeId != null)
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children : [                                             
                                                  Icon(LucideIcons.clock, color: AppColors.orange_950, size: 16),
                                                  CustomText(
                                                    text: places2[index].arrivalTime!,                                               
                                                    type: TextType.body,
                                                    color: AppColors.orange_950,), 
                                                ]
                                              ), 
                                            // const SizedBox(height: 4),

                                            if (places2[index].day ==
                                                    widget.day &&
                                                index <= places2.length - 1 &&
                                                places2[index].placeId != null)
                                              GestureDetector(
                                                onTap:
                                                    () =>
                                                        _onCardSelected(index),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          _selectedIndex ==
                                                                  index
                                                              ? Colors.blue
                                                              : Colors
                                                                  .transparent,
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8,
                                                        ),
                                                  ),
                                                  child: PlaceCard(
                                                    placeId:
                                                        places2[index].placeId!,
                                                    placeName:
                                                        places2[index]
                                                            .placeName!,
                                                    placeDescription:
                                                        places2[index]
                                                            .placeDescription!,
                                                    placeImage:
                                                        places2[index]
                                                            .placeImageUrl!,
                                                    arrivalTime:
                                                        places2[index]
                                                            .arrivalTime!,
                                                    onClick:
                                                        () => deleteCard(index),
                                                    isEdit: _isEditing,
                                                  ),
                                                ),
                                              ),

                                            if (index == places2.length - 1)
                                              const SizedBox(height: 10)
                                            else if (index <
                                                    places2.length - 1 &&
                                                index < routes.length &&
                                                routes[index].day ==
                                                    widget.day &&
                                                places2[index].placeId !=
                                                    null &&
                                                places2[index + 1].placeId !=
                                                    null &&
                                                routeOptions.isNotEmpty)
                                             
                                              RouteDropdown(
                                                key: ValueKey(
                                                  'route-${places2[index].placeId}-${places2[index + 1].placeId}-$index',
                                                ),

                                                choices: routeOptions,
                                                pastChoice:
                                                    _selectedIndex == index
                                                        ? "Select route mode"
                                                        : routes[index]
                                                            .routeMode
                                                            .toString(),
                                              ),

                                            if (_isEditing &&
                                                index < places2.length - 1)
                                              ElevatedButton(
                                                onPressed:
                                                    () => addPlace(index),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                        255,
                                                        250,
                                                        98,
                                                        47,
                                                      ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          15,
                                                        ),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 10,
                                                      ),
                                                ),
                                                child: Text(
                                                  "Add Place",
                                                  style: TextStyle(
                                                    color: AppColors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                      : const SizedBox.shrink(),
            ),
          ],
        ),
      );
    });
  }
}
