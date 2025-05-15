

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



