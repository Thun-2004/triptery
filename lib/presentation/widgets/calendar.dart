import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  DateTime? _selectedDay;
  bool isRangeSelectionMode = false;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
    _firstDay = DateTime.now().subtract(Duration(days: 365));
    _lastDay = DateTime.now().add(Duration(days: 365));
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: TableCalendar(
        headerStyle: HeaderStyle(
          formatButtonVisible: false, // Hides the "2 weeks" button
          titleCentered: true,
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
        rangeStartDay: _rangeStart, // Your state variable
        rangeEndDay: _rangeEnd, // Your state variable
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
            _focusedDay = focusedDay;
          });
        },
      ),
    );
  }
}
