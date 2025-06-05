import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/presentation/widgets/trip/components/note.dart';

class TransportCard extends StatefulWidget {
  const TransportCard({super.key});

  @override
  State<TransportCard> createState() => _TransportCardState();
}

class _TransportCardState extends State<TransportCard> {
  int distance = 0;
  String transitMode = 'Subway';

  List<String> modes = []; 

  List<String> get distanceValues => ['A', 'B', 'C'];
  List<String> get transitModes => ['N5', 'N6', 'N7'];

  void setDistanceValue(String value) {
    distance = int.tryParse(value) ?? 0;
  }

  void setTransitValue(String value) {
    transitMode = value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.gray, width: 1.5),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32, 
                    height: 32,
                    margin: const EdgeInsets.only(right: 6), 
                    decoration: BoxDecoration(
                      color: AppColors.orange_500,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      LucideIcons.trainFront,
                      size: 20,
                      color: AppColors.white,
                    ),
                  ), 
                  const Text("Subway",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),

              Container(
                decoration: BoxDecoration(
                  color: AppColors.lightGray,
                  borderRadius: BorderRadius.circular(8),
                ),
                width: 100,
                height: 32,
                child: DropdownButton<String>(
                  value: transitModes.first,
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    if (newValue != null) setTransitValue(newValue);
                  },
                  items:
                      transitModes.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                  icon: const Padding(
                    padding: EdgeInsets.only(
                      right: 8,
                    ), // 👈 custom icon padding
                    child: Icon(Icons.arrow_drop_down),
                  ),
                  underline: SizedBox(), // removes underline
                ))
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Text("Distance:"),
              // const SizedBox(width: 8),
              TextEditable(
                width: 95,
                height: 32,
                values: ['A', 'B', 'C'],
                setValue: setDistanceValue,
              ),

              TextEditable(
                width: 73,
                height: 32,
                values: ['A', 'B', 'C'],
                setValue: setDistanceValue,
              ),
              TextEditable(
                width: 108,
                height: 32,
                values: ['A', 'B', 'C'],
                setValue: setDistanceValue,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Note(placeholderText: "Note", controller: TextEditingController(), onChanged: (value) {}),
        ],
      ),
    );
  }
}

class TimeEdit extends StatelessWidget {
  const TimeEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
        
      ],
    );
  }
}

class TextEditable extends StatelessWidget {
  final List<String> values;
  final void Function(String) setValue;
  final int width;
  final int height;

  const TextEditable({
    required this.width,
    required this.height,
    required this.values,
    required this.setValue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: AppColors.lightGray,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.gray, width: 1.5),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: width.toDouble() / 2,
              height: height.toDouble(),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: height / 4,
                    horizontal: 10,
                  ),
                  hintText: 'Enter your text here',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                controller: TextEditingController(text: 0.toString()),
              ),
            ),
            const VerticalDivider(
              width: 0,
              thickness: 1,
              indent: 0,
              endIndent: 0,
              color: AppColors.gray,
            ),
            Container(
              width: width.toDouble() / 2,
              height: height.toDouble(),
              decoration: BoxDecoration(
                // color: AppColors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  inputDecorationTheme: const InputDecorationTheme(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
                // child: DropdownMenu<String>(
                //   initialSelection: values.first,
                //   onSelected: (String? value) {
                //     if (value != null) setValue(value);
                //   },
                //   dropdownMenuEntries:
                //       values
                //           .map(
                //             (value) => DropdownMenuEntry<String>(
                //               value: value,
                //               label: value,
                //             ),
                //           )
                //           .toList(),
                // ),
                
                child: DropdownButton<String>(
                  value: values.first,
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    if (newValue != null) setValue(newValue);
                  },
                  items:
                      values.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                  icon: const Padding(
                    padding: EdgeInsets.only(
                      right: 8,
                    ), // 👈 custom icon padding
                    child: Icon(Icons.arrow_drop_down),
                  ),
                  underline: SizedBox(), // removes underline
                ),
                

              ),
            ),
          ],
        ),
      ),
    );
  }
}
