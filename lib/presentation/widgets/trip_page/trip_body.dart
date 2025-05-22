
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:triptery/presentation/widgets/trip_page/components/day.dart';
import 'package:triptery/presentation/widgets/trip_page/components/day_list.dart';
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

  void _selectDay(int day){
    setState((){
      if (day == 0){
        dayMode = DayList();
      }else{
        dayMode = Day(day: day);
      }
    });
  }

  @override
  void initState(){
    super.initState();
    dayMode = DayList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              DayButton(text: 'All' , onPressed: () => _selectDay(0)),
              const SizedBox(width: 10), 
              for(int i = 0; i < days.length; i++) ...[
                DayButton(
                  text: 'Day ${days[i]}',
                  onPressed: () => _selectDay(days[i])
                ), 
                if(i < days.length - 1) const SizedBox(width: 10)
              ]
            ],
          ),
          dayMode,
          const SizedBox(height: 16),
          // Add your trip details here
          
        ],
      ),
    );
  }
}

class DayButton extends StatelessWidget{
  DayButton({
    super.key, 
    required this.text, 
    required this.onPressed,
    this.isSelected = false, 
  });

  final String text; 
  final VoidCallback onPressed; 
  bool isSelected;


  @override
  Widget build(BuildContext context){
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Color(0xFFFE8257) : Colors.white, 
        // foregroundColor: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: Color(0xFFCDCCD2), width: 1)
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}