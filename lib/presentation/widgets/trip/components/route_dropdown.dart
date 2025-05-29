

import 'package:flutter/material.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';
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
      verticalMargin: 7,
      header: Container(
        decoration: BoxDecoration(
          color: AppColors.grayRoute,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children : [
                Text(currentChoice)
              ]
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children : [
                CustomText(
                  text: "21 mins", 
                  type: TextType.body,
                  color: AppColors.black,
                ), 
                const Icon(Icons.keyboard_arrow_down),

              ]
            )
            
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
