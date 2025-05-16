// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:triptery/presentation/widgets/trip_page/components/place_card.dart';

// class Day extends StatefulWidget {
//   const Day({super.key});

//   @override
//   State<Day> createState() => _DayState();
// }

// class _DayState extends State<Day> {
//   static const Duration duration = Duration(milliseconds: 300);
//   static const Curve curve = Curves.easeIn;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Card(
//         margin: const EdgeInsets.all(16),
//         child: const Center(
//           child: AnimatedSizeExample(duration: duration, curve: curve),
//         ),
//       ),
//     );
//   }
// }

// class AnimatedSizeExample extends StatefulWidget {
//   const AnimatedSizeExample({
//     required this.duration,
//     required this.curve,
//     super.key,
//   });

//   final Duration duration;
//   final Curve curve;

//   @override
//   State<AnimatedSizeExample> createState() => _AnimatedSizeExampleState();
// }

// class _AnimatedSizeExampleState extends State<AnimatedSizeExample> {
//   bool _isSelected = false;
//   List<Map<String, String>> places = [
//     {
//       "name": "Place 1",
//       "description": "Description 1",
//       "image": "https://via.placeholder.com/150",
//     },
//     {
//       "name": "Place 2",
//       "description": "Description 2",
//       "image": "https://via.placeholder.com/150",
//     },
//     {
//       "name": "Place 3",
//       "description": "Description 3",
//       "image": "https://via.placeholder.com/150",
//     },
//     {
//       "name": "Place 4",
//       "description": "Description 2",
//       "image": "https://via.placeholder.com/150",
//     },
//     {
//       "name": "Place 5",
//       "description": "Description 3",
//       "image": "https://via.placeholder.com/150",
//     },
//     {
//       "name": "Place 6",
//       "description": "Description 2",
//       "image": "https://via.placeholder.com/150",
//     },
//     {
//       "name": "Place 7",
//       "description": "Description 3",
//       "image": "https://via.placeholder.com/150",
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _isSelected = !_isSelected;
//         });
//       },
//       child: Container(
//         width: double.infinity, // Ensure the container takes full width
//         padding: const EdgeInsets.all(16),
//         child: AnimatedSize(
//           duration: widget.duration,
//           curve: widget.curve,
//           child: AnimatedContainer(
//             // height: _isSelected ? 250.0 : 100,
//             duration: widget.duration,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text("Day 1"),
//                 Text("Thursday, 12th October 2023"),
//                 Text(
//                   _isSelected ? "Tap to collapse" : "Tap to expand",
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 _isSelected
//                     ? Expanded(
//                     child: ReorderableListView(
//                       shrinkWrap: true,
//                       physics: AlwaysScrollableScrollPhysics(),
//                       padding: const EdgeInsets.symmetric(horizontal: 40),
//                       children: [
//                         for (int index = 0; index < places.length; index++)
//                           PlaceCard(
//                             key: ValueKey(places[index]['name']),
//                             placeName: places[index]['name']!,
//                             placeDescription: places[index]['description']!,
//                             placeImage: places[index]['image']!,
//                           )
//                       ],
//                       onReorder: (int oldIndex, int newIndex) {
//                         setState(() {
//                           if (oldIndex < newIndex) {
//                             newIndex -= 1;
//                           }
//                           final Map<String, String> item = places.removeAt(oldIndex);
//                           places.insert(newIndex, item);
//                         });
//                       },
//                     )) : Container(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:triptery/presentation/widgets/trip_page/components/place_card.dart';
import 'package:triptery/presentation/widgets/trip_page/components/route_dropdown.dart';
import 'package:triptery/data/mock/mock_trips.dart';
import 'package:triptery/domain/entities/trip/trip.dart';

class Day extends StatefulWidget {
  const Day({super.key, required this.day});

  final int day;

  @override
  State<Day> createState() => _DayState();
}

class _DayState extends State<Day> {
  bool _isExpanded = false;
  int _selectedIndex = 0;
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
  ];

  void _onCardSelected(int index) {
    setState(() {
      // If tapping the same card, toggle its selection
      if (_selectedIndex == index) {
        _selectedIndex = -1;
      } else {
        // Otherwise, select the new card
        _selectedIndex = index;
      }
    });

    if (_selectedIndex != -1 && _selectedIndex < places2.length) {
      _recalculateRouteMode(_selectedIndex);
    }
  }

  void _recalculateRouteMode(int index) {
    if (index < routes.length) {
      // Get available route options
      List<Map<String, String>> options = findRouteOptions(
        places2[index].placeId!,
        places2[index + 1].placeId!,
      );

      // Log available options
      print('Available route options: $options');

      // Here you would update the route mode based on selection
      // For example, you might set it to the first available option
      if (options.isNotEmpty) {
        setState(() {
          // Update the route mode in yoxur data model
          // routes[index].routeMode = options[0]['mode'];
          print('Selected route mode: ${options[0]['mode']}');
        });
      }
    }
  }

  void _handleReorder(int oldIndex, int newIndex) {
    setState(() {
      // Adjust newIndex if needed
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }

      // Move the place
      final Trip item = places2.removeAt(oldIndex);
      places2.insert(newIndex, item);

      // Reset selection
      _selectedIndex = -1;

      // Recalculate all routes that were affected by the reordering
      _recalculateAllRoutes();
    });
  }

  void _recalculateAllRoutes() {
    print('Recalculating all routes after reordering');

    // Loop through all places except the last one
    for (int i = 0; i < places2.length - 1; i++) {
      // Find route options between current place and next place
      List<Map<String, String>> options = findRouteOptions(
        places2[i].placeId!,
        places2[i + 1].placeId!,
      );

      print(
        'Route options between ${places2[i].placeName} and ${places2[i + 1].placeName}: $options',
      );

      // Update route if options exist
      if (options.isNotEmpty && i < routes.length) {
        // Here you would update your data model
        // For now, we'll just print the selected route
        print('Selected route: ${options[0]['mode']}');
      }
    }
  }

  List<Map<String, String>> findRoute(String placeId1, String placeId2) {
    return routeChoices
        .where(
          (route) =>
              (route["Dest1"] == placeId1 && route["Dest2"] == placeId2) ||
              (route["Dest1"] == placeId2 && route["Dest2"] == placeId1),
        )
        .toList();
  }

  final List<Map<String, String>> places = [
    {"name": "Place 1", "description": "Description 1", "image": ""},
    {"name": "Place 2", "description": "Description 2", "image": ""},
    // {
    //   "name": "Place 3",
    //   "description": "Description 3",
    //   "image": "",
    // },
    // {
    //   "name": "Place 4",
    //   "description": "Description 4",
    //   "image": "",
    // },
    // {
    //   "name": "Place 5",
    //   "description": "Description 5",
    //   "image": "",
    // },
  ];

  List<Trip> trips = mockTrips;

  List<Trip> get places2 {
    return trips.where((trip) => trip.type == TripType.dest).toList();
  }

  void logPlaces() {
    print('Places: ${places2.map((p) => p.placeName).toList()}');
  }

  List<Trip> get routes {
    return trips.where((trip) => trip.type == TripType.route).toList();
  }

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
    logPlaces(); // Log places when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
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

          // Expandable content with scrolling and reordering
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
                      // onReorder: (oldIndex, newIndex) {
                      //   setState(() {
                      //     if (oldIndex < newIndex) {
                      //       newIndex -= 1;
                      //     }
                      //     final item = places2.removeAt(oldIndex);
                      //     places2.insert(newIndex, item);

                      //     _selectedIndex = -1;
                      //   });
                      // },
                      onReorder: _handleReorder,
                      itemBuilder: (context, index) {
                        return Padding(
                          key: ValueKey('place-$index'),
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                // child : PlaceCard(
                                //       placeName: places[index]["name"]!,
                                //       placeDescription: places[index]["description"]!,
                                //       placeImage: places[index]["image"]!,
                                //     ),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(0),
                                      child: Column(
                                        // children: [
                                        //   if (places2[index].day == widget.day && index <= places2.length - 1)

                                        //     PlaceCard(
                                        //       placeId: places2[index].placeId!,
                                        //       placeName: places2[index].placeName!,
                                        //       placeDescription: places2[index].placeDescription!,
                                        //       placeImage: places2[index].placeImageUrl!,
                                        //     ),

                                        //   if (index == places2.length - 1)
                                        //     const SizedBox(height: 10)
                                        //   else if (index < places2.length - 1 && index < routes.length && routes[index].day == widget.day)
                                        //     RouteDropdown(
                                        //       choices: findRouteOptions(
                                        //         places2[index].placeId!,
                                        //         places2[index + 1].placeId!,
                                        //       ),
                                        //       pastChoice: routes[index].routeMode.toString(),

                                        //     )

                                        // ],
                                        children: [
                                          if (places2[index].day ==
                                                  widget.day &&
                                              index <= places2.length - 1)
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
                                              routes[index].day == widget.day)
                                            RouteDropdown(
                                              key: ValueKey(
                                                'route-${_selectedIndex == index ? "selected" : "normal"}-$index',
                                              ),
                                              choices: findRouteOptions(
                                                places2[index].placeId!,
                                                places2[index + 1].placeId!,
                                              ),
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
