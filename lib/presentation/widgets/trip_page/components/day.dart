// import 'package:flutter/material.dart';
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
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final List<int> _items = List<int>.generate(20, (int index) => index);
//     final ColorScheme colorScheme = Theme.of(context).colorScheme;
//     final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
//     final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _isSelected = !_isSelected;
//         });
//       },
//       child: Container(
//         width: double.infinity, // Ensure the container takes full width
//         color: Colors.amberAccent,
//         padding: const EdgeInsets.all(16),
//         child: AnimatedSize(
//           duration: widget.duration,
//           curve: widget.curve,
//           child: AnimatedContainer(
//             // height: _isSelected ? 250.0 : 100.0,
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
//                     ? ReorderableListView(
//                       shrinkWrap: true,
//                       physics: AlwaysScrollableScrollPhysics(),
//                       padding: const EdgeInsets.symmetric(horizontal: 40),
//                       children: <Widget>[
//                         for (int index = 0; index < _items.length; index += 1)
//                           ListTile(
//                             key: Key('$index'),
//                             tileColor:
//                                 _items[index].isOdd
//                                     ? oddItemColor
//                                     : evenItemColor,
//                             title: Text('Item ${_items[index]}'),
//                           ),
//                       ],
//                       onReorder: (int oldIndex, int newIndex) {
//                         setState(() {
//                           if (oldIndex < newIndex) {
//                             newIndex -= 1;
//                           }
//                           final int item = _items.removeAt(oldIndex);
//                           _items.insert(newIndex, item);
//                         });
//                       },
//                     )
//                     // ReorderableListView.builder(
//                     //   shrinkWrap: true,
//                     //   physics: const NeverScrollableScrollPhysics(),
//                     //   itemCount: places.length,
//                     //   onReorder: (oldIndex, newIndex){
//                     //     setState(() {
//                     //       if (oldIndex < newIndex) {
//                     //         newIndex--;
//                     //       }
//                     //       final item = places.removeAt(oldIndex);
//                     //       places.insert(newIndex, item);
//                     //     });
//                     //   },
//                     //   itemBuilder: (context, index) {
//                     //     final item = places[index];
//                     //     return PlaceCard(
//                     //       key: ValueKey(item),
//                     //       placeName: places[index]["name"]!,
//                     //       placeDescription: "Description of ${places[index]["description"]}",
//                     //       placeImage: places[index]["image"]!,
//                     //     );
//                     //   }
//                     // )
//                     // SingleChildScrollView(
//                     //   child: Column(
//                     //     children: [
//                     //       PlaceCard(
//                     //         placeName: "Place 1",
//                     //         placeDescription: "Description 1",
//                     //         placeImage: "https://via.placeholder.com/150",
//                     //       ),
//                     //       PlaceCard(
//                     //         placeName: "Place 2",
//                     //         placeDescription: "Description 2",
//                     //         placeImage: "https://via.placeholder.com/150",
//                     //       ),
//                     //       PlaceCard(
//                     //         placeName: "Place 3",
//                     //         placeDescription: "Description 3",
//                     //         placeImage: "https://via.placeholder.com/150",
//                     //       ),
//                     //     ]
//                     //   ),
//                     // )
//                     : Container(),
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
      "image": "https://via.placeholder.com/150",
    },
    {
      "name": "Place 2",
      "description": "Description 2",
      "image": "https://via.placeholder.com/150",
    },
    {
      "name": "Place 3",
      "description": "Description 3",
      "image": "https://via.placeholder.com/150",
    },
    {
      "name": "Place 4",
      "description": "Description 4",
      "image": "https://via.placeholder.com/150",
    },
    {
      "name": "Place 5",
      "description": "Description 5",
      "image": "https://via.placeholder.com/150",
    },
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
            height: _isExpanded ? 300 : 0,
            child: _isExpanded 
              ? ReorderableListView.builder(
                  buildDefaultDragHandles: true,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
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
                          ReorderableDragStartListener(
                            index: index,
                            child: const Icon(Icons.drag_handle),
                          ), 
                          const SizedBox(width: 8.0), 
                          // const Icon(Icons.drag_handle),
                          Expanded(
                            child: PlaceCard(
                              placeName: places[index]["name"]!,
                              placeDescription: places[index]["description"]!,
                              placeImage: places[index]["image"]!,
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

