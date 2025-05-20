import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:triptery/presentation/widgets/trip_page/components/day.dart';
import 'package:triptery/data/mock/mock_trips.dart';
import 'package:triptery/domain/entities/trip/trip.dart';

class DayList extends StatefulWidget {
  const DayList({super.key});

  @override
  State<DayList> createState() => _DayListState();
}

class _DayListState extends State<DayList> {
  List<Trip> trips = mockTrips;
  List<int> get days {
    return trips
        .where((trip) => trip.day > 0)
        .map((trip) => trip.day)
        .toSet()
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 900,
      width: double.infinity,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: days.length,
        itemBuilder: (context, index) {
          return Day(
            day: days[index],
          );
        },
      ),
    );
  }
}
