import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/constant/transport_modes.dart';
import 'package:triptery/presentation/controllers/transport_mode_controller.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';
import 'package:triptery/presentation/widgets/trip/components/note.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

//FIXME: replace fixed height with Expanded for responsiveness
class TransportCard extends StatefulWidget {
  final TransportMode mode;
  final VoidCallback? onChangeIcon;
  final int index;

  const TransportCard({
    super.key,
    required this.index,
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
  final TransportModeController transportModeController =
      Get.find<TransportModeController>();

  List<String> get distanceValues => ['A', 'B', 'C'];
  List<String> get transitModes => ['N5', 'N6', 'N7'];
  List<String> get transportModes => [
    'Car',
    'Bus',
    'Train',
    'Car Rent',
    'Taxi',
    'Sky Train',
    'Subway',
    'Boat',
    'Airplane',
    'Walk',
  ];

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

  TransportMode getTransportModeFromName(String name) {
    switch (name) {
      case 'Bus':
        return TransportMode.bus;
      case 'Train':
        return TransportMode.train;
      case 'Car':
        return TransportMode.car;
      case 'Car Rent':
        return TransportMode.carRent;
      case 'Taxi':
        return TransportMode.taxi;
      case 'Sky Train':
        return TransportMode.skyTrain;
      case 'Subway':
        return TransportMode.subway;
      case 'Boat':
        return TransportMode.boat;
      case 'Airplane':
        return TransportMode.airplane;
      case 'Walk':
        return TransportMode.walk;
      default:
        return TransportMode.subway;
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

  void _setModeDuration(String duration) {
    transportModeController.setModeDuration(widget.index, duration);
  }

  void _setDistance(String distance) {
    transportModeController.setDistance(
      widget.index,
      int.tryParse(distance) ?? 0,
    );
  }

  void _setDistanceUnit(String distanceUnit) {
    transportModeController.setDistanceUnit(widget.index, distanceUnit);
  }

  void _setCost(String cost) {
    transportModeController.setCost(widget.index, int.tryParse(cost) ?? 0);
  }

  void _setCostUnit(String costUnit) {
    transportModeController.setCostUnit(widget.index, costUnit);
  }

  void _editNote(String note) {
    transportModeController.addNote(widget.index, note);
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
                mainAxisAlignment: MainAxisAlignment.start,
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
                            final mode = getTransportModeFromName(newValue);
                            setTransportModeValue(mode);
                            transportModeController.setTransportMode(
                              widget.index,
                              mode,
                            );
                          }
                        },
                        customButton: Center(
                          child: Icon(
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
                                    children: [
                                      Icon(
                                        _getIconForMode(
                                          TransportMode.values.firstWhere(
                                            (m) =>
                                                m.name.toLowerCase() ==
                                                value.toLowerCase(),
                                            orElse:
                                                () => TransportMode.unSelected,
                                          ),
                                        ),
                                        size: 20,
                                        color: AppColors.orange_950,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(value),
                                    ],
                                  ),
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

              if (TransportMode.subway == transportMode ||
                  TransportMode.bus == transportMode ||
                  TransportMode.train == transportMode ||
                  TransportMode.skyTrain == transportMode ||
                  TransportMode.boat == transportMode ||
                  TransportMode.airplane == transportMode)
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: 170,
                  height: 32,
                  child: TextFormField(
                    initialValue:
                        transportModeController.tempModes[widget
                            .index]["note"] ??
                        '',
                    showCursor: true,
                    decoration: const InputDecoration(
                      hintText: 'station...',
                      border: UnderlineInputBorder(),
                      contentPadding: EdgeInsets.all(8),
                    ),
                    onChanged:
                        ((text) => transportModeController.editTag(
                          widget.index,
                          text,
                        )),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          //NOTE: wrap = alternative of row but takes up the entire space
          Row(
            spacing: 8,
            // runSpacing: 4,
            // direction: Axis.horizontal,
            children: [
              Flexible(
                child: EditableTimeBox(
                  width: 75,
                  initialValue:
                      transportModeController.tempModes[widget
                          .index]["time_taken"],
                  onChange: _setModeDuration,
                ),
              ),
              Flexible(
                child: TextDropDown(
                  width: 75,
                  // height: 32,
                  values: ['km', 'm'],
                  initialValue:
                      transportModeController.tempModes[widget
                          .index]["distance"], //NOTE: initial value must match one of the values in dropdown
                  initialUnit:
                      transportModeController.tempModes[widget
                          .index]["distance_unit"],
                  setValue: setDistanceValue,
                  textOnChange: _setDistance,
                  dropDownOnChange: _setDistanceUnit,
                ),
              ),
              Flexible(
                child: TextDropDown(
                  width: 75,
                  // height: 32,
                  values: ['THB', 'USD', 'EUR'],
                  initialValue:
                      transportModeController.tempModes[widget.index]["cost"],
                  initialUnit:
                      transportModeController.tempModes[widget
                          .index]["cost_unit"],
                  setValue: setDistanceValue,
                  textOnChange: _setCost,
                  dropDownOnChange: _setCostUnit,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          Note(
            initialValue:
                transportModeController.tempModes[widget.index]["note"] ??
                'Some note',
            placeholderText: "Note",
            onChanged: _editNote,
          ),
        ],
      ),
    );
  }
}

class TextDropDown extends StatefulWidget {
  final List<String> values;
  final void Function(String) setValue;
  final int initialValue;
  final String initialUnit;
  final int width;
  final void Function(String) textOnChange;
  final void Function(String) dropDownOnChange;

  const TextDropDown({
    required this.width,
    required this.values,
    required this.initialValue,
    required this.initialUnit,
    required this.setValue,
    required this.textOnChange,
    required this.dropDownOnChange,
    super.key,
  });

  @override
  State<TextDropDown> createState() => TextDropDownState();
}

class TextDropDownState extends State<TextDropDown> {
  late String _dropDownValue;

  @override
  void initState() {
    super.initState();
    _dropDownValue = widget.initialUnit;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.gray, width: 1.5),
      ),
      child: Wrap(
        children: [
          Container(
            height: 44,
            width: widget.width.toDouble() / 2,
            child: TextFormField(
              initialValue: widget.initialValue.toString(),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 2,
                  vertical: 11,
                ),
                hintText: 'Enter your text here',
                border: InputBorder.none,
              ),
              onChanged: (value) {
                widget.textOnChange(value);
              },
              // controller: TextEditingController(text: 0.toString()),
            ),
          ),
          const VerticalDivider(
            width: 0,
            thickness: 2,
            indent: 0,
            endIndent: 0,
            color: AppColors.gray,
          ),
            Container(
            child: Container(
              height: 44,
              width: widget.width.toDouble() - 20,
              // height: height.toDouble(),
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
                  ),
                ),

                child: DropdownButton2<String>(
                  value: _dropDownValue,
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      _dropDownValue = newValue!;
                    });
                    widget.dropDownOnChange(newValue!);
                  },
                  items:
                      widget.values.map<DropdownMenuItem<String>>((
                        String value,
                      ) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: CustomText(
                              text: value.toString(),
                              type: TextType.body,
                              color: AppColors.black,
                              // textSize: 12,
                            ),
                          ),
                        );
                      }).toList(),

                  iconStyleData: const IconStyleData(
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 16,
                    iconEnabledColor: AppColors.black,
                    iconDisabledColor: AppColors.black,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    width: widget.width.toDouble(),

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
          ),
        ],
      ),
    );
  }
}

class EditableTimeBox extends StatefulWidget {
  final int width;
  final String initialValue;
  final void Function(String) onChange;
  const EditableTimeBox({
    super.key,
    required this.width,
    required this.initialValue,
    required this.onChange,
  });

  @override
  _EditableTimeBoxState createState() => _EditableTimeBoxState();
}

class _EditableTimeBoxState extends State<EditableTimeBox> {
  bool isHourEditing = false;
  bool isMinEditing = false;

  String hour = '00';
  String minute = '05';

  final hourController = TextEditingController();
  final minuteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    hour = widget.initialValue.split(':')[0].padLeft(2, '0');
    minute = widget.initialValue.split(':')[1].padLeft(2, '0');
    hourController.text = hour;
    minuteController.text = minute;
  }

  @override
  void dispose() {
    hourController.dispose();
    minuteController.dispose();
    super.dispose();
  }

  void setTime() {
    widget.onChange("${hour}:${minute}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      // width: widget.width.toDouble(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Hour
          GestureDetector(
            onTap: () {
              setState(() => isHourEditing = true);
            },
            child:
                isHourEditing
                    ? SizedBox(
                      width: 20,
                      child: TextField(
                        controller: hourController,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        onSubmitted: (value) {
                          setState(() {
                            hour = value.padLeft(2, '0');
                            isHourEditing = false;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            hour = value.padLeft(2, '0');
                          });
                          setTime();
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                        ),
                      ),
                    )
                    : CustomText(
                      text: hour,
                      type: TextType.body,
                      color: AppColors.black,
                    ),
          ),

          CustomText(
            text: ' : ',
            type: TextType.body,
            color: AppColors.black,
            // textSize: 12,
          ),

          // Minute
          GestureDetector(
            onTap: () {
              setState(() => isMinEditing = true);
            },
            child:
                isMinEditing
                    ? SizedBox(
                      width: 20,
                      child: TextField(
                        controller: minuteController,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        onSubmitted: (value) {
                          setState(() {
                            minute = value.padLeft(2, '0');
                            isMinEditing = false;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            minute = value.padLeft(2, '0');
                          });
                          setTime();
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                        ),
                      ),
                    )
                    : CustomText(
                      text: minute,
                      type: TextType.body,
                      color: AppColors.black,
                    ),
          ),

          SizedBox(width: 6),
          CustomText(
            text: 'hrs',
            type: TextType.body,
            color: AppColors.black,
            // textSize: 12,
          ),
          SizedBox(width: 2),
          Icon(Icons.access_time, color: Colors.black87, size: 16),
        ],
      ),
    );
  }
}
