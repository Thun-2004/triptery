import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triptery/presentation/controllers/trip_controller.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({
    super.key,
    required this.placeId,
    required this.placeName,
    required this.placeDescription,
    required this.placeImage,
    required this.onClick,
    required this.isEdit,
  });

  final String placeId;
  final String placeName;
  final String placeDescription;
  final String placeImage;
  final VoidCallback onClick;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: const EdgeInsets.all(20),
      elevation: 0,
      margin: EdgeInsets.symmetric(vertical: 0),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(placeImage),
                  radius: 25,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              // Wrap in Expanded to prevent overflow
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        placeName,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow:
                            TextOverflow.ellipsis, // Add ellipsis for long text
                        maxLines: 1, // Limit to one line
                      ),

                      if (isEdit)
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.remove, color: Colors.white),
                            padding: EdgeInsets.all(0),
                            constraints: BoxConstraints(
                              minWidth: 24,
                              minHeight: 24,
                            ),
                            iconSize: 18,
                            onPressed: onClick,
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 5),
                  Text(
                    placeDescription,
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                    overflow:
                        TextOverflow.ellipsis, // Add ellipsis for long text
                    maxLines: 2, // Limit to two lines
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
