import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';
import 'package:triptery/presentation/widgets/trip/components/day.dart';
import 'package:triptery/presentation/widgets/trip/components/day_list.dart';
import 'package:triptery/data/mock/mock_trips.dart';
import 'package:triptery/domain/entities/trip/trip.dart';

class TripBody extends StatefulWidget {
  const TripBody({super.key});

  @override
  State<TripBody> createState() => _TripBodyState();
}

class _TripBodyState extends State<TripBody> {
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
  void initState() {
    super.initState();
    dayMode = DayList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
     
      decoration: BoxDecoration(
        color: AppColors.grayBg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 21),
              decoration: BoxDecoration(
                color: AppColors.white,
              ),
              child: Row(
                children: [
                  DayButton(text: 'All', onPressed: () => _selectDay(0), index: 0, selectedDay: selectedDay),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      // padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder:
                            (context, index) => Row(
                              children: [
                                DayButton(
                                  text: 'Day ${days[index]}',
                                  onPressed: () => _selectDay(days[index]),
                                  index: days[index], 
                                  selectedDay: selectedDay
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                        itemCount: days.length,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          dayMode,
          const SizedBox(height: 16),

          // Add your trip details here
        ],
      ),
    );
  }
}

class DayButton extends StatefulWidget {
  const DayButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.index, 
    required this.selectedDay,
  });

  final String text;
  final VoidCallback onPressed;
  final int index;
  final int selectedDay; 

  @override
  State<DayButton> createState() => DayButtonState();
}

class DayButtonState extends State<DayButton>{

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
      onPressed: (){
        widget.onPressed(); 
      }, 
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.index == widget.selectedDay ? AppColors.orange_900 : AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: widget.index == widget.selectedDay ? Colors.transparent : AppColors.gray, width: 1),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      ),
      child: CustomText(
        text: widget.text,
        type: TextType.body,
        color: widget.index == widget.selectedDay ? AppColors.white : AppColors.black
      )
      // )Text(
      //   widget.text,
      //   style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: widget.index == widget.selectedDay ? Colors.white : Colors.black),
      // ),
    );
  }
}
