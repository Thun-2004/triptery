
import 'package:flutter/material.dart';
import 'package:triptery/presentation/widgets/trip_page/components/day_list.dart';

class TripBody extends StatefulWidget {
  const TripBody({super.key});

  @override
  State<TripBody> createState() => _TripBodyState();
}

class _TripBodyState extends State<TripBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Horizontal Day List',
          ),
          DayList(), 
          const SizedBox(height: 16),
          // Add your trip details here
          
        ],
      ),
    );
  }
}