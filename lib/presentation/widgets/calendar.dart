import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/presentation/controllers/plan_controller.dart';

class Calendar extends StatefulWidget {
  @override
  State<Calendar> createState() => _CalendarState();

  const Calendar({super.key});
}

//where to change color of range date
class _CalendarState extends State<Calendar> {
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  DateTime? _selectedDay;
  bool isRangeSelectionMode = false;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  final planController = Get.find<PlanController>();

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
    _firstDay = DateTime.now().subtract(Duration(days: 365));
    _lastDay = DateTime.now().add(Duration(days: 365));
    _rangeStart = planController.plan.value?.dayStart;
    _rangeEnd = planController.plan.value?.dayEnd;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TableCalendar(
        headerStyle: HeaderStyle(
          formatButtonVisible: false, // Hides the "2 weeks" button
          titleCentered: true,
        ),
        calendarStyle: CalendarStyle(
          rangeHighlightColor: AppColors.orange_50, // ✅ your desired color
          withinRangeTextStyle: TextStyle(
            color: Colors.white,
          ), // text color inside range
          rangeStartDecoration: BoxDecoration(
            color: AppColors.orange_800, // start date circle color
            shape: BoxShape.circle,
          ),
          rangeEndDecoration: BoxDecoration(
            color: AppColors.orange_800, // end date circle color
            shape: BoxShape.circle,
          ),
        ),

        focusedDay: _focusedDay,
        firstDay: _firstDay,
        lastDay: _lastDay,
        onPageChanged: (focusedDay) {
          setState(() {
            _focusedDay = focusedDay;
          });
        },

        rangeSelectionMode: RangeSelectionMode.enforced,
        rangeStartDay: _rangeStart, // Your state variable for range start
        rangeEndDay: _rangeEnd, // Your state variable for range end
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day), // optional

        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            if (!isRangeSelectionMode) {
              _selectedDay = selectedDay;
              _rangeStart = null; // clear range
              _rangeEnd = null;
            }
          });
        },
        onRangeSelected: (start, end, focusedDay) {
          setState(() {
            _selectedDay = null;
            _rangeStart = start;
            _rangeEnd = end;
            if (_rangeStart != null && _rangeEnd != null) {
              planController.updateTimeRange(_rangeStart!, _rangeEnd!);
            }
            _focusedDay = focusedDay;
          });
        },
      ),
    );
  }
}
