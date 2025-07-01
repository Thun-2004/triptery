import 'package:flutter/material.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';
import 'package:triptery/presentation/widgets/calendar.dart';

class TripCalendarWindow extends StatefulWidget {
  @override
  TripCalendarWindowState createState() => TripCalendarWindowState();
}

class TripCalendarWindowState extends State<TripCalendarWindow> {

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                CustomText(
                  text: 'When will your adventure begin and end? 🗓️',
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

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: SizedBox(height: 400, child: Calendar()),
            ),
          ],
        ),
      ),
    );
  }
}
