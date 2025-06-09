import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/data/mock/mock_trips.dart';
import 'package:triptery/domain/entities/trip/trip.dart';
import 'package:triptery/presentation/widgets/add_button.dart';
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

  List<Trip> trips = mockTrips;
  List<int> get days {
    return trips
        .where((trip) => trip.day > 0)
        .map((trip) => trip.day)
        .toSet()
        .toList();
  }

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
                spreadRadius: 0
              )
             ]
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
                    Text('Create Route'),
                    IconButton(
                      icon: const Icon(LucideIcons.x, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                SizedBox(
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
              ],
            ),
          ),

          //scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Text("Day info")
              //FIX ME: add day info 
              
            ),
          ),
        ],
      ),
    );
  }
}
