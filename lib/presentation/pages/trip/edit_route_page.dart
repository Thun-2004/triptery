import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/data/mock/mock_trips.dart';
import 'package:triptery/domain/entities/trip/trip.dart';
import 'package:triptery/presentation/widgets/add_button.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';
import 'package:triptery/presentation/widgets/trip/components/day.dart';
import 'package:triptery/presentation/widgets/trip/components/day_list.dart';
import 'package:triptery/presentation/widgets/trip/trip_body.dart';

class EditRoutePage extends StatefulWidget {
  const EditRoutePage({super.key});

  @override
  State<EditRoutePage> createState() => _EditRoutePageState();
}

class _EditRoutePageState extends State<EditRoutePage> {
  int selectedDay = 0;
  late Widget dayMode;

  List<int> get days {
    return trips
        .where((trip) => trip.day > 0)
        .map((trip) => trip.day)
        .toSet()
        .toList();
  }

  bool _isExpanded = false;
  int _selectedIndex = 0;
  List<Trip> trips = mockTrips;
  List<Map<String, String>> routeChoices = [
    {
      // 1- 2
      //dest : placeId
      "Dest1": "1",
      "Dest2": "2",
      "mode": "Car -> Train -> Bus",
      "time": "21mins",
      "price": "100THB",
    },
    
    {
      //dest : placeId
      "Dest1": "1",
      "Dest2": "2",
      "mode": "Bus -> Train",
      "time": "16mins",
      "price": "140THB",
    },
    {
      //dest : placeId
      "Dest1": "1",
      "Dest2": "2",
      "mode": "Train -> Walk",
      "time": "22mins",
      "price": "130THB",
    },
    //2 -> 1
    {
      //dest : placeId
      "Dest1": "2",
      "Dest2": "1",
      "mode": "Bus -> Train",
      "time": "30mins",
      "price": "140THB",
    },
    {
      //dest : placeId
      "Dest1": "2",
      "Dest2": "1",
      "mode": "Train -> Walk",
      "time": "2mins",
      "price": "130THB",
    },

    // 2 - 3
    {
      //dest : placeId
      "Dest1": "2",
      "Dest2": "3",
      "mode": "Walk -> Train",
      "time": "40mins",
      "price": "130THB",
    },
    // 3 - 2
    {
      //dest : placeId
      "Dest1": "3",
      "Dest2": "2",
      "mode": "Train -> Walk",
      "time": "2mins",
      "price": "130THB",
    },
    // 3 - 1
    {
      //dest : placeId
      "Dest1": "3",
      "Dest2": "1",
      "mode": "Train -> Bus",
      "time": "25mins",
      "price": "130THB",
    },
    {
      //dest : placeId
      "Dest1": "1",
      "Dest2": "3",
      "mode": "Walk -> Bus",
      "time": "2mins",
      "price": "10THB",
    },
    {
      //dest : placeId
      "Dest1": "1",
      "Dest2": "5",
      "mode": "Walk -> Bus",
      "time": "2mins",
      "price": "10THB",
    },
    {
      //dest : placeId
      "Dest1": "5",
      "Dest2": "2",
      "mode": "Walk -> Bus",
      "time": "2mins",
      "price": "10THB",
    },
    {
      //dest : placeId
      "Dest1": "2",
      "Dest2": "5",
      "mode": "Walk -> Bus",
      "time": "2mins",
      "price": "10THB",
    },
    {
      //dest : placeId
      "Dest1": "5",
      "Dest2": "3",
      "mode": "Walk -> Bus",
      "time": "2mins",
      "price": "10THB",
    },
    {
      //dest : placeId
      "Dest1": "3",
      "Dest2": "5",
      "mode": "Walk -> Bus",
      "time": "2mins",
      "price": "10THB",
    },
  ];

  void _selectDay(int day) {
    setState(() {
      if (day == 0) {
        dayMode = DayList();
      } else {
        dayMode = Day(day: day);
      }
      selectedDay = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  offset: const Offset(0, 4),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ],
            ),
            padding: const EdgeInsets.only(
              top: 50,
              left: 16,
              right: 16,
              bottom: 8,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                    CustomText(
                      text: "Edit Route",
                      type: TextType.heading,
                      color: AppColors.black,
                    ),
                    IconButton(
                      icon: const Icon(LucideIcons.x, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SizedBox(
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        DayButton(
                          text: 'All',
                          onPressed: () => (),
                          index: 0,
                          selectedDay: 1,
                        ),
                        const SizedBox(width: 10),
                        ...days.map(
                          (day) => Row(
                            children: [
                              DayButton(
                                text: 'Day $day',
                                onPressed: () => _selectDay(day),
                                index: day,
                                selectedDay: selectedDay,
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ),

                        AddButton(
                          onPressed: () {
                            // Your logic here
                          },
                          text: '+',
                          textSize: 16,
                          textColor: AppColors.orange_950,
                          width: 50,
                          height: 28,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          //selected deletion
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            alignment: Alignment.bottomCenter,
            height: 50,
            // height: isExpanded ? 50 : 0,
            padding: const EdgeInsets.only(right: 16, left: 30 ),
            decoration: BoxDecoration(color: AppColors.red),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Select All",
                  type: TextType.subHeading,
                  color: AppColors.darkBlue,
                ),
                CustomText(
                  text: "2 Selected",
                  type: TextType.subHeading,
                  color: AppColors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(
                        LucideIcons.trash2,
                        color: AppColors.darkBlue,
                      ),
                      onPressed: () {
                        // Your delete logic here
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        LucideIcons.x,
                        color: AppColors.darkBlue,
                      ),
                      onPressed: () {
                        // Your confirm logic here
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          //scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Text("Day info"),

              //FIX ME: add day info
            ),
          ),
        ],
      ),
    );
  }
}
