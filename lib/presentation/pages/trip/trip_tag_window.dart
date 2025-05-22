import 'package:flutter/material.dart';
import 'package:triptery/presentation/widgets/Item/custom_text.dart';
import 'package:triptery/presentation/widgets/trip_page/components/trip_tag.dart';
import 'package:triptery/presentation/widgets/Item/custom_text.dart';

class TripTagWindow extends StatefulWidget {
  @override
  TripTagWindowState createState() => TripTagWindowState();
}

class TripTagWindowState extends State<TripTagWindow> {
  //temp
  List<String> tags = [
    'Party',
    'Adventure',
    'Beach',
    'Culture',
    'Food',
    'Nature',
    'Relaxation',
    'Shopping',
    'Sports',
    'History',
    'Art',
    'Music',
    'Photography',
    'Wildlife',
    'Hiking',
    'Camping',
    'Swimming',
    'Sightseeing',
    'Museums',
    'Gardens',
    'Parks',
    'Zoos',
    'Aquariums',
    'Observatories',
  ];

  //temp
  List<String> selectedTags = [];

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Column(
                children: [
                  CustomText(
                    text: 'Tailor your adventure of your tastes 🌟', 
                    type: TextType.heading, 
                    color: Colors.black),
                  const SizedBox(height: 20),
                  CustomText(
                    text: 'Selected your travel preference to customize your trip plan.', 
                    type: TextType.body, 
                    color: Colors.black),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children:
                    tags.map((tag) {
                      return TripTag(tag: tag);
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
