import 'package:flutter/material.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';
import 'package:triptery/presentation/widgets/trip/components/trip_tag.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';

class TripTagWindow extends StatefulWidget {
  @override
  TripTagWindowState createState() => TripTagWindowState();
}

class TripTagWindowState extends State<TripTagWindow> {
  //temp
  List<String> tags = [
    'Adventure Travel 🏞️',
    'City Breaks  🌇',
    'Cultural Exploration 🏛️',
    'Glamping ⛺️',
    'Beach Vacation 🏖️',
    'Nature Escape 🌿',
    'Relaxing Getaways 🏨',
    'Road Trips 🚙',
    'Food Tourism 🥗',
    'Backpacking 🎒',
    'Cruise Vacations 🚢',
    'Staycations 🏡',
    'Skiing/Snowboarding ⛷️',
    'Wine Tours 🍷',
    'Wildlife Safaris 🦁',
    'Art Galleries 🎨',
    'Historical Sites 🏰',
    'Eco-Tourism 🌿',
  ];

  //temp
  List<String> selectedTags = [];

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 800,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                CustomText(
                  text: 'Tailor your adventure of your tastes 🌟',
                  type: TextType.heading,
                  color: Colors.black,
                ),
                const SizedBox(height: 20),
                CustomText(
                  text:
                      'Selected your travel preference to customize your trip plan.',
                  type: TextType.body,
                  color: Colors.black,
                ),
              ],
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
