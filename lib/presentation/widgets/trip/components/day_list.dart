import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:triptery/presentation/widgets/trip/components/day.dart';
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
    // return Container(
    //   height: 800,
    //   width: double.infinity,
    //   child: ListView.builder(
    //     physics: const BouncingScrollPhysics(),
    //     itemCount: days.length,
    //     itemBuilder: (context, index) {
    //       return Day(
    //         day: days[index],
    //       );
    //     },
    //   ),
    // );
    return Container(
      height: 845,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16), 
          bottomRight: Radius.circular(16)),
      ),
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
