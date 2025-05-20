

import 'package:flutter/material.dart';
import 'package:triptery/presentation/widgets/drop_down_area.dart';

class RouteDropdown extends StatefulWidget {
  RouteDropdown({
    super.key,
    required this.choices,
    this.pastChoice = "Transportation mode",
  });
  final List<Map<String, String>> choices;
  String pastChoice;

  @override
  State<RouteDropdown> createState() => _RouteDropdownState();
}

class _RouteDropdownState extends State<RouteDropdown> {
  var selected = 0;
  late String currentChoice; 

  // final List<Map<String, String>> routes = [
  //   {"mode": "Car -> Train -> Bus", "time": "21mins", "price": "100THB"},
  //   {"mode": "Bus -> Train", "time": "16mins", "price": "140THB"},
  //   {"mode": "Train -> Walk", "time": "22mins", "price": "130THB"},
  //   {"mode": "Train -> Walk", "time": "22mins", "price": "130THB"},
  // ];
  late final List<Map<String, String>> routes;

  @override
  void initState() {
    super.initState();
    routes = widget.choices;
    currentChoice = widget.pastChoice;
  }

  @override
  Widget build(BuildContext context) {
    // Make sure routes is not empty before generating items
    final routesToDisplay = routes.isNotEmpty ? routes : [];
    

    return DropDownArea(
      elevation: 0,
      verticalMargin: 0,
      header: Container(
        padding: const EdgeInsets.all(0),
        width: double.infinity,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(currentChoice),
            const Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children:
            routesToDisplay.isEmpty
                ? [const Text("No routes available")]
                : List.generate(routesToDisplay.length, (i) {
                  return ListTile(
                    title: Text(routesToDisplay[i]["mode"] ?? 'Unknown mode'),
                    subtitle: Text(
                      "${routesToDisplay[i]["time"] ?? 'Unknown time'} · ${routesToDisplay[i]["price"] ?? 'Unknown price'}",
                    ),
                    leading: Radio<int>(
                      value: i,
                      groupValue: selected,
                      onChanged: (int? value) {
                        setState(() {
                          selected = value!;
                          currentChoice = routesToDisplay[i]["mode"] ?? 'Unknown mode';
                          widget.pastChoice = currentChoice;
                        });
                      },
                    ),
                  );
                }),
      ),
    );
  }
}
