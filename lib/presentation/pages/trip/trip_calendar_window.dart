import 'package:flutter/material.dart';
import 'package:triptery/presentation/widgets/Item/custom_text.dart';
import 'package:triptery/presentation/widgets/calendar.dart';
import 'package:triptery/presentation/widgets/trip_page/components/trip_tag.dart';
import 'package:triptery/presentation/widgets/Item/custom_text.dart';

class TripCalendarWindow extends StatefulWidget {
  @override
  TripCalendarWindowState createState() => TripCalendarWindowState();
}

class TripCalendarWindowState extends State<TripCalendarWindow> {
  int _isSelectedIndex = 0;
  final List<Map<String, String>> modes = [
    {"mode": "Cheap 💰", "detail": "Budget - friendly, economical travel."},
    {"mode": "Balanced 💼", "detail": "Moderate spending for a balanced trip."},
    {"mode": "Luxury 💎", "detail": "High-end, indulgent experiences."},
    {"mode": "Flexible 💫", "detail": "No budget restrictions."},
  ];

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
                    text: 'when will your adventure begin and end? 🗓️',
                    type: TextType.heading,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 20),
                  CustomText(
                    text: 'Choose the dates for your tips',
                    type: TextType.body,
                    color: Colors.black,
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: SizedBox(
                height: 400,
                child: Calendar()
              ), 
            ),
          ],
        ),
      ),
    );
  }
}