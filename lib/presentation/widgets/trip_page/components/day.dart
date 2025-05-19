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
  ];

  List<Trip> places2 = [];

  // List<Trip> get places2 {
  //   return trips.where((trip) => trip.type == TripType.dest).toList();
  // }
  // final List<Trip> places2 = [
  //   Trip(
  //     id: "1",
  //     planId: "1",
  //     day: 1,
  //     type: TripType.dest,
  //     placeId: "1",
  //     placeName: "Pattaya walking street",
  //     placeDescription:
  //         "a vibrant entertainment area in Pattaya that has gained notoriety for its go-go bars and adult shows, as well as karaoke bars and nightclubs",
  //     placeImageUrl:
  //         "https://i.pinimg.com/736x/0b/8b/44/0b8b44749794c89156391daf1e607f95.jpg",
  //     arrivalTime: "10:00 AM",
  //     routeMode: null,
  //     routeTotalTime: null,
  //     routeTotalCost: null,
  //     routeTotalDistance: null,
  //     routeDistance: null,
  //     routeNote: null,
  //     note: "Teemy's fav",
  //   ),
    
  //   Trip(
  //     id: "1",
  //     planId: "1",
  //     day: 1,
  //     type: TripType.dest,
  //     placeId: "2",
  //     placeName: "Jomtien Beach",
  //     placeDescription:
  //         "a popular tourist destination located in Pattaya, Thailand, known for its long stretch of sand, vibrant atmosphere, and variety of activities.",
  //     placeImageUrl:
  //         "https://i.pinimg.com/736x/5e/75/2e/5e752e76c0b3846cb24f7c0ebbeaabd4.jpg",
  //     arrivalTime: "11:00 AM",
  //     routeMode: null,
  //     routeTotalTime: null,
  //     routeTotalCost: null,
  //     routeTotalDistance: null,
  //     routeDistance: null,
  //     routeNote: null,
  //     note: "Teemy's fav",
  //   ),
   
  //   Trip(
  //     id: "1",
  //     planId: "1",
  //     day: 1,
  //     type: TripType.dest,
  //     placeId: "3",
  //     placeName: "Sanctuary of Truth",
  //     placeDescription:
  //         "an unfinished museum in Pattaya, Thailand designed by Thai businessman Lek Viriyaphan. The museum structure is a hybrid of a temple and a castle that is themed on the Ayutthaya Kingdom and of Buddhist and Hindu beliefs.",
  //     placeImageUrl:
  //         "https://i.pinimg.com/736x/29/75/4a/29754a69b3706015f0cc4b4815a6a159.jpg",
  //     arrivalTime: "12:00 PM",
  //     routeMode: null,
  //     routeTotalTime: null,
  //     routeTotalCost: null,
  //     routeTotalDistance: null,
  //     routeDistance: null,
  //     routeNote: null,
  //     note: "Teemy's fav",
  //   ),
  //   Trip(
  //     id: "1",
  //     planId: "1",
  //     day: 2,
  //     type: TripType.dest,
  //     placeId: "4",
  //     placeName: "Ripley's Believe It or Not! Pattaya ",
  //     placeDescription:
  //         "Family entertainment venue with haunted houses, a theater with moving seats & an oddities museum.",
  //     placeImageUrl:
  //         "https://i.pinimg.com/736x/c5/89/3e/c5893eb920affd31a202fdc9f4a100a5.jpg",
  //     arrivalTime: "10:00 PM",
  //     routeMode: null,
  //     routeTotalTime: null,
  //     routeTotalCost: null,
  //     routeTotalDistance: null,
  //     routeDistance: null,
  //     routeNote: null,
  //     note: "Teemy's fav",
  //   ),
  // ];

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
    places2 = trips.where((trip) => trip.type == TripType.dest).toList();
    logPlaces(); // Log places when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    if (places2.isEmpty && trips.isNotEmpty) {
      places2 = trips.where((trip) => trip.type == TripType.dest).toList();
      print("Initializing places2 in build method: ${places2.length} items");
    }

    List<Trip> dayPlaces = places2.where((trip) => trip.day == widget.day).toList();
    
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

                      onReorder: (int oldIndex, int newIndex) {
                        setState(() {
                          if (oldIndex < newIndex) {
                            newIndex -= 1;
                          }
                          final Trip item = places2.removeAt(oldIndex);
                          places2.insert(newIndex, item);
                        });
                      },

                      // onReorder: _handleReorder,
                      itemBuilder: (context, index) {
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
