import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/constant/transport_modes.dart';
import 'package:triptery/presentation/widgets/trip/components/note.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

//FIXME: replace fixed height with Expanded for responsiveness
class TransportCard extends StatefulWidget {
  final TransportMode mode;
  final VoidCallback? onChangeIcon;

  const TransportCard({
    super.key,
    required this.mode,
    required this.onChangeIcon,
  });
  @override
  State<TransportCard> createState() => _TransportCardState();
}

class _TransportCardState extends State<TransportCard> {
  int distance = 0;
  String transitMode = 'Subway';
  bool displayTransport = false;
  TransportMode transportMode = TransportMode.unSelected;

  List<String> get distanceValues => ['A', 'B', 'C'];
  List<String> get transitModes => ['N5', 'N6', 'N7'];
  List<String> get transportModes => ['car', 'bus', 'bike', 'train', 'car rent', 'taxi', 'sky train', 'subway', 'boat', 'airplane'];

  IconData _getIconForMode(TransportMode mode) {
    switch (mode) {
      case TransportMode.bus:
        return LucideIcons.busFront;
      case TransportMode.train:
        return LucideIcons.tramFront;
      case TransportMode.car:
        return LucideIcons.carFront;
      case TransportMode.carRent:
        return LucideIcons.car;
      case TransportMode.taxi:
        return LucideIcons.carTaxiFront;
      case TransportMode.skyTrain:
        return LucideIcons.trainFront;
      case TransportMode.subway:
        return LucideIcons.trainFrontTunnel;
      case TransportMode.boat:
        return LucideIcons.ship;
      case TransportMode.airplane:
        return LucideIcons.plane;
      default:
        return LucideIcons.footprints;
    }
  }

  String getTransportModeName(TransportMode mode) {
    switch (mode) {
      case TransportMode.bus:
        return 'Bus';
      case TransportMode.train:
        return 'Train';
      case TransportMode.car:
        return 'Car';
      case TransportMode.carRent:
        return 'Car Rent';
      case TransportMode.taxi:
        return 'Taxi';
      case TransportMode.skyTrain:
        return 'Sky Train';
      case TransportMode.subway:
        return 'Subway';
      case TransportMode.boat:
        return 'Boat';
      case TransportMode.airplane:
        return 'Airplane';
      case TransportMode.walk:
        return 'Walk';
      default:
        return 'Select Transport';
    }
  }

  void setDistanceValue(String value) {
    distance = int.tryParse(value) ?? 0;
  }

  void setTransitValue(String value) {
    setState(() {
      transitMode = value;
    }); 
  }

  void setTransportModeValue(TransportMode value) {
    setState(() {
      transportMode = value;
    });
    
  }

  @override
  void initState() {
    super.initState();
    transportMode = widget.mode;
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
                      color:
                          transportMode == TransportMode.unSelected
                              ? AppColors.gray
                              : AppColors.orange_500,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: DropdownButton2<String>(
                        value: transportModes.first,
                        isExpanded: true,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            final mode = TransportMode.values.firstWhere(
                              (m) => m.name.toLowerCase() == newValue.toLowerCase(),
                              orElse: () => TransportMode.unSelected,
                            );
                            setTransportModeValue(mode);
                          }
                        },
                        customButton: Center(
                          child:
                            Icon(
                              _getIconForMode(transportMode),
                              size: 20,
                              color: AppColors.white,
                            ), // You can align or replace this
                        ),
                        items:
                            transportModes.map<DropdownMenuItem<String>>((
                              String value,
                            ) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Row(
                                    children : [
                                      Icon(
                                        _getIconForMode(
                                          TransportMode.values.firstWhere(
                                            (m) => m.name.toLowerCase() == value.toLowerCase(), 
                                            orElse: () => TransportMode.unSelected, 
                                          )
                                        ),
                                        size: 20,
                                        color: AppColors.orange_950,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(value),
                                    ]
                                  )
                                ),
                              );
                            }).toList(),

                        iconStyleData: const IconStyleData(
                          icon: Icon(LucideIcons.footprints),
                          iconSize: 20,
                          iconEnabledColor: AppColors.white,
                          iconDisabledColor: AppColors.white,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          width: 175,

                          // width: width.toDouble() / 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: AppColors.white,
                          ),
                          offset: const Offset(-0, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all<double>(6),
                            thumbVisibility: MaterialStateProperty.all<bool>(
                              true,
                            ),
                          ),
                        ),
                        underline: SizedBox(), // removes underline
                      ),
                    ),
                  ),
                  Text(
                    getTransportModeName(transportMode),

                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),

              Container(
                decoration: BoxDecoration(
                  color: TransportMode.subway == transportMode ? AppColors.lightGray :  Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                width: 100,
                height: 32,
                child:
                    TransportMode.subway == transportMode
                        ? TextFormField(
                          showCursor: true,
                          decoration: const InputDecoration(
                            hintText: 'station...',
                            border: UnderlineInputBorder(),
                            contentPadding: EdgeInsets.all(8),
                          ),
                        )
                        : const SizedBox(width: 0, height: 0),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
          Note(
            placeholderText: "Note",
            controller: TextEditingController(),
            onChanged: (value) {},
          ),
        ],
      ),
    );
    ;
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

                child: DropdownButton2<String>(
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

                  iconStyleData: const IconStyleData(
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 14,
                    iconEnabledColor: AppColors.black,
                    iconDisabledColor: AppColors.black,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    width: width.toDouble(),

                    // width: width.toDouble() / 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppColors.white,
                    ),
                    offset: const Offset(-0, 0),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(40),
                      thickness: MaterialStateProperty.all<double>(6),
                      thumbVisibility: MaterialStateProperty.all<bool>(true),
                    ),
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
