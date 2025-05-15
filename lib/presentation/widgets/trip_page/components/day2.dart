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

class Day extends StatefulWidget {
  const Day({super.key});

  @override
  State<Day> createState() => _DayState();
}

class _DayState extends State<Day> {
  bool _isExpanded = false;
  final List<Map<String, String>> places = [
    {
      "name": "Place 1",
      "description": "Description 1",
      "image": "",
    },
    {
      "name": "Place 2",
      "description": "Description 2",
      "image": "",
    },
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

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
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
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text("Thursday, 12th October 2023"),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _isExpanded ? "Tap to collapse" : "Tap to expand",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
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
            child: _isExpanded 
              ? ReorderableListView.builder(
                  buildDefaultDragHandles: true,
                  scrollDirection: Axis.vertical,
                  // shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: places.length,
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      final item = places.removeAt(oldIndex);
                      places.insert(newIndex, item);
                    });
                  },
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
                            child: Column (
                              children : [
                                PlaceCard(
                                  placeName: places[index]["name"]!,
                                  placeDescription: places[index]["description"]!,
                                  placeImage: places[index]["image"]!,
                                ),
                                RouteDropdown()
                              ]
                            )
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



