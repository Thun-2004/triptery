import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triptery/domain/entities/trip/plan.dart';
import 'package:triptery/presentation/controllers/plan_controller.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';
import 'package:triptery/presentation/widgets/trip/components/trip_tag.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';

class TripGroupWindow extends StatefulWidget {
  @override
  TripGroupWindowState createState() => TripGroupWindowState();
}

class TripGroupWindowState extends State<TripGroupWindow> {
  final PlanController planController = Get.find<PlanController>();
  int _isSelectedIndex = 0;
  final List<Map<String, String>> modes = [
    {"mode": "Only Me 🚶", "detail": "Traveling solo, just you."},
    {"mode": "A Couple 👫", "detail": "2 people"},
    {"mode": "Family 👨‍👩‍👦‍👦", "detail": "3-10 people"},
    {"mode": "Friends 🌟", "detail": "2-12 people"},
    {"mode": "Work 💼", "detail": "5-25 people"},
  ];

  int getBudgetIndex(Party party) {
    switch (party) {
      case Party.onlyMe:
        return 0;
      case Party.couple:
        return 1;
      case Party.family:
        return 2;
      case Party.friends:
        return 3;
      case Party.work:
        return 4;
      default:
        return -1; // Return -1 if budget is not recognized
    }
  }

  @override
  void initState() {
    super.initState();
    _isSelectedIndex = getBudgetIndex(
      planController.plan.value?.party ?? Party.onlyMe,
    );
  }

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
                          planController.updatePlanParty(Party.values[index]);
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
