

import 'package:flutter/material.dart';
import 'package:triptery/presentation/widgets/trip_page/components/day2.dart';

class DayList extends StatefulWidget {
  const DayList({super.key});

  @override
  State<DayList> createState() => _DayListState();
}

class _DayListState extends State<DayList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 900,
      width: double.infinity,
      child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            Day(),
            Day(),
          ],
        ),
    );
  }
} 

