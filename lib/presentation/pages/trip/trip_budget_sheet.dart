import 'package:flutter/material.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';
import 'package:triptery/presentation/widgets/trip/components/trip_tag.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';

class TripBudgetWindow extends StatefulWidget {
  @override
  TripBudgetWindowState createState() => TripBudgetWindowState();
}

class TripBudgetWindowState extends State<TripBudgetWindow> {
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
                  text: 'Set your trip budget 💰',
                  type: TextType.heading,
                  color: Colors.black,
                ),
                const SizedBox(height: 20),
                CustomText(
                  text: 'Select your estimated budget',
                  type: TextType.body,
                  color: Colors.black,
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children:
                    modes.asMap().entries.map((entry) {
                      final int index = entry.key;
                      final Map<String, String> mode = entry.value;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _isSelectedIndex =
                                _isSelectedIndex == index ? -1 : index;
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          margin: const EdgeInsets.only(bottom: 10),
                          // margin: EdgeInsets.only(bottom: (value),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  _isSelectedIndex == index
                                      ? const Color.fromARGB(255, 223, 107, 12)
                                      : Colors.white,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: mode['mode'] ?? 'Mode',
                                type: TextType.subHeading,
                                color: Colors.black,
                              ),
                              const SizedBox(height: 10),
                              CustomText(
                                text: mode['detail'] ?? 'Detail',
                                type: TextType.body,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
