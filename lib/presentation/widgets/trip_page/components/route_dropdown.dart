import 'package:flutter/material.dart';
import 'package:triptery/presentation/widgets/drop_down_area.dart';

class RouteDropdown extends StatefulWidget {
  const RouteDropdown({super.key});

  @override
  State<RouteDropdown> createState() => _RouteDropdownState();
}

class _RouteDropdownState extends State<RouteDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropDownArea(
      header: RouteDropdownHeader(),
      body: RouteDropdownBody(),
    );
  }
}

class RouteDropdownHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              const Icon(Icons.arrow_back),
              // const SizedBox(width: 8),
              Text('Transportation mode'),
            ],
          ),
        ],
      ),
    );
  }
}

class RouteDropdownBody extends StatefulWidget {
  const RouteDropdownBody({super.key});

  @override
  State<RouteDropdownBody> createState() => _RouteDropdownBodyState();
}

class _RouteDropdownBodyState extends State<RouteDropdownBody> {
  var selected = 0;

  final List<Map<String, String>> routes = [
    {"mode": "Car -> Train -> Bus", "time": "21mins", "price": "100THB"},
    {"mode": "Bus -> Train", "time": "16mins", "price": "140THB"},
    {"mode": "Train -> Walk", "time": "22mins", "price": "130THB"},
  ];

  @override
  Widget build(BuildContext context) {
    return DropDownArea(
      header: RouteDropdownHeader(),
      body: Column(
        children: List.generate(routes.length, (i) {
          return ListTile(
            title: Text('$routes[i]["mode"]'),
            leading: Radio<int>(
              value: i,
              groupValue: selected,
              onChanged: (int? value) {
                setState(() {
                  selected = i;
                });
              },
            ),
          );
        }),
      ),
    );
  }
}
