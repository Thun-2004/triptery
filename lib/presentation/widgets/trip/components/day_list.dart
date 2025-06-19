
import 'package:flutter/material.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/presentation/widgets/trip/components/day.dart';
import 'package:triptery/data/mock/mock_plan.dart';
import 'package:triptery/domain/entities/trip/trip.dart';

class DayList extends StatefulWidget {
  const DayList({super.key, required this.dateFrom, required this.dayCount});
  final DateTime dateFrom;
  final int dayCount;

  @override
  State<DayList> createState() => _DayListState();
}

class _DayListState extends State<DayList> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.grayBg,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16)),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 0),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.dayCount,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Day(
              day: index + 1,
              date: widget.dateFrom.add(Duration(days: index))
            )
          ); 
        },
      ),
    );
  }
}
