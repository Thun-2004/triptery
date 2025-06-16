import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimePickerCupertino extends StatefulWidget {
  const TimePickerCupertino({super.key});

  @override
  TimePickerCupertinoState createState() => TimePickerCupertinoState();
}

class TimePickerCupertinoState extends State<TimePickerCupertino> {
  TimeOfDay? selectedTime = TimeOfDay(hour: 9, minute: 41);

  @override
  Widget build(BuildContext context) {
    final timeText =
        selectedTime != null
            ? selectedTime!.format(context)
            : 'No time selected';

    DateTime tempTime = DateTime(
      0,
      0,
      0,
      selectedTime!.hour,
      selectedTime!.minute,
    );
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Top bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 60),
                Text(
                  'Select Time',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      selectedTime = TimeOfDay.fromDateTime(tempTime);
                    });
                  },
                  child: Text('Done', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
          Expanded(
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              initialDateTime: tempTime,
              use24hFormat: false,
              onDateTimeChanged: (DateTime newDateTime) {
                tempTime = newDateTime;
              },
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
