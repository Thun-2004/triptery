import 'package:flutter/material.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({
    super.key,
    required this.placeName,
    required this.placeDescription,
    required this.placeImage,
  });

  final String placeName;
  final String placeDescription;
  final String placeImage;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 0,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: CircleAvatar(
              backgroundImage: NetworkImage(placeImage),
              radius: 25,
            ),
          ),
          const SizedBox(width: 10),
          Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                placeName,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                placeDescription,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
