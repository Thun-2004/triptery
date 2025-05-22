import 'package:flutter/material.dart';
import 'package:triptery/presentation/widgets/trip_page/components/place_card.dart';
import 'package:triptery/presentation/widgets/trip_page/components/route_dropdown.dart';
import 'package:triptery/data/mock/mock_trips.dart';
import 'package:triptery/domain/entities/trip/trip.dart';



class Day extends StatefulWidget {
  Day({super.key, required this.day});
  final int day;
  @override
  State<Day> createState() => _DayState();
}

class _DayState extends State<Day> {
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

      _selectedIndex = -1;
   
      _recalculateAllRoutes();

      print('Updated route: ${routes[0].routeMode} , ${routes[1].routeMode}');
    });
  }

  // void _recalculateAllRoutes() {
  //   // routes.clear();
    
  //   for (int i = 0; i < places2.length - 1; i++) {
  //     if (places2[i].placeId != null && places2[i + 1].placeId != null) {
  //       routes[i] = Trip(
  //         id: places2[i].id,
  //         planId: places2[i].planId,
  //         day: widget.day,
  //         type: TripType.route,
  //         placeId: null,
  //         placeName: null,
  //         placeDescription: null,
  //         placeImageUrl: null,
  //         arrivalTime: null,
  //         routeMode: RouteMode.unselected,
  //         routeFrom: places2[i].placeId,
  //         routeTo: places2[i + 1].placeId,
  //         routeTotalTime: null,
  //         routeTotalCost: null,
  //         routeTotalDistance: null,
  //         routeDistance: null,
  //         routeNote: null,
  //         note: null,
  //       );
  //     }
  //   }
    
  //   // Force UI update
  //   // setState(() {});
  // }
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
          routes.add(Trip(
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
          ));
        }
        routeIndex++;
      }

      print('route options: ${findRouteOptions(places2[i].id, places2[i+1].id)}'); 
    }
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
    places2 = trips.where((trip) => trip.type == TripType.dest).toList();
    routes = trips.where((trip) => trip.type == TripType.route).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (places2.isEmpty && trips.isNotEmpty) {
      places2 = trips.where((trip) => trip.type == TripType.dest).toList();
    }

    if (trips.isEmpty){
      routes = trips.where((trip) => trip.type == TripType.route).toList();
    }

    return Container(
      // margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header section (always visible)
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Day 1",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      const Text("Thursday, 12th October 2023"),
                      const Spacer(),
                      Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                      
                    ],
                  ),
                ],
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
                         List<Map<String, String>> routeOptions = index < places2.length - 1 && 
                            places2[index].placeId != null && 
                            places2[index + 1].placeId != null
                            ? findRouteOptions(places2[index].placeId!, places2[index + 1].placeId!)
                            : [];
                        return Padding(
                          key: ValueKey('place-$index'),
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(0),
                                      child: Column(
                                        children: [
                                          if (places2[index].day ==
                                                  widget.day &&
                                              index <= places2.length - 1 && places2[index].placeId != null)
                                            GestureDetector(
                                              onTap:
                                                  () => _onCardSelected(index),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color:
                                                        _selectedIndex == index
                                                            ? Colors.blue
                                                            : Colors
                                                                .transparent,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: PlaceCard(
                                                  placeId:
                                                      places2[index].placeId!,
                                                  placeName:
                                                      places2[index].placeName!,
                                                  placeDescription:
                                                      places2[index]
                                                          .placeDescription!,
                                                  placeImage:
                                                      places2[index]
                                                          .placeImageUrl!,
                                                ),
                                              ),
                                            ),

                                          if (index == places2.length - 1)
                                            const SizedBox(height: 10)
                                          else if (index < places2.length - 1 &&
                                              index < routes.length &&
                                              routes[index].day == widget.day && places2[index].placeId != null && places2[index+1].placeId != null)
                                            RouteDropdown(
                                              key: ValueKey(
                                                'route-${places2[index].placeId}-${places2[index+1].placeId}-$index',
                                              ), 
                                              // key: ValueKey(
                                              //   'route-${_selectedIndex == index ? "selected" : "normal"}-$index',
                                              // ),
                                              choices: routeOptions,
                                              pastChoice:
                                                  _selectedIndex == index
                                                      ? "Select route mode"
                                                      : routes[index].routeMode
                                                          .toString(),
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
  }
}
