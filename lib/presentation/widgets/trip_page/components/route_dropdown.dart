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

  const RouteDropdownHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),

      width: double.infinity,
      height: 60,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text('Transportation mode'),
            ],
          ),
          const Icon(Icons.keyboard_arrow_down)
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
    {"mode": "Train -> Walk", "time": "22mins", "price": "130THB"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      // padding: const EdgeInsets.all(16),
      // width: double.infinity,
      // constraints: const BoxConstraints(maxHeight: 300),
      mainAxisSize: MainAxisSize.min,
      
      // child: Column(
      //   mainAxisSize : MainAxisSize.min,
      //   children: 
       children : List.generate(routes.length, (i) {
          return ListTile(
            title: Text(routes[i]['mode']!),
            subtitle: Text("${routes[i]["time"]!} · ${routes[i]["price"]!}"),
            leading: Radio<int>(
              value: i,
              groupValue: selected,
              onChanged: (int? value) {
                setState(() {
                  selected = value!;
                });
              },
          )
          );
        }),
      );
  }
}


