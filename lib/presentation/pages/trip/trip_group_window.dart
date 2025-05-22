import 'package:flutter/material.dart';
import 'package:triptery/presentation/widgets/Item/custom_text.dart';
import 'package:triptery/presentation/widgets/trip_page/components/trip_tag.dart';
import 'package:triptery/presentation/widgets/Item/custom_text.dart';

class TripGroupWindow extends StatefulWidget {
  @override
  TripGroupWindowState createState() => TripGroupWindowState();
}

class TripGroupWindowState extends State<TripGroupWindow> {
  int _isSelectedIndex = 0;
  final List<Map<String, String>> modes = [
    {"mode": "Only Me 🚶", "detail": "Traveling solo, just you."},
    {"mode": "A Couple 🩷", "detail": "A romantic gataway for two."},
    {"mode": "Family", "detail": "Quality time with your loved ones."},
    {"mode": "Friends 🌟", "detail": "Adventure with your closest pals."},
    {"mode": "Work 💼", "detail": "Bussiness or corporate travel."},
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
                    text: 'Who is going? 🧳',
                    type: TextType.heading,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 20),
                  CustomText(
                    text:
                        'Let’s get started by selecting who you’re traveling with.',
                    type: TextType.body,
                    color: Colors.black,
                  ),
                ],
              ),
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
                            _isSelectedIndex = _isSelectedIndex == index ? -1 : index; 
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
                                  _isSelectedIndex == index ? 
                                       const Color.fromARGB(255, 223, 107, 12)
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
