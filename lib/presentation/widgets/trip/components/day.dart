// import 'dart:developer';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:triptery/constant/colors.dart';
// import 'package:triptery/presentation/controllers/transport_mode_controller.dart';
// import 'package:triptery/presentation/widgets/base_ui/text.dart';
// import 'package:triptery/presentation/widgets/time_picker.dart';
// import 'package:triptery/presentation/widgets/trip/components/place_card.dart';
// import 'package:triptery/presentation/widgets/trip/components/route_dropdown.dart';
// import 'package:triptery/domain/entities/trip/trip.dart';
// import 'package:triptery/presentation/controllers/trip_controller.dart';
// import 'package:lucide_icons_flutter/lucide_icons.dart';
// import 'package:triptery/utils/datetime.dart';

// class Day extends StatefulWidget {
//   const Day({super.key, required this.day, required this.date});
//   final int day;
//   final DateTime date;

//   @override
//   State<Day> createState() => _DayState();
// }

// class _DayState extends State<Day> {
//   final tripController = Get.find<TripController>();
//   bool isExpanded = false;
//   bool _isExpanded = false;
//   int _selectedIndex = 0;
//   var selectedTime = Duration(hours: 9, minutes: 41);
//   //NOTE :getter type = dynamic type
//   List<Trip> get _places => tripController.getPlaces;
//   List<Trip> get _routes => tripController.getRoutes;

//   late List<Map<String, dynamic>> _places_temp;

//   void _onCardSelected(int index) {
//     setState(() {
//       if (_selectedIndex == index) {
//         _selectedIndex = -1;
//       } else {
//         _selectedIndex = index;
//       }
//     });
//   }

//   void handleReorder(int oldIndex, int newIndex) {
//     setState(() {
//       tripController.handleReorder(oldIndex, newIndex, _selectedIndex);
//     });
//   }

//   void recalculateAllRoutes() {
//     tripController.recalculateAllRoutes();
//     // setState(() {});
//   }

//   // void setTimePicker()

//   void showTimePicker(String initialTime, Function(TimeOfDay) setTimeOnChange) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       showDragHandle: true,
//       backgroundColor: AppColors.white,
//       builder: (context) {
//         return FractionallySizedBox(
//           heightFactor: 0.3,
//           child: TimePickerCupertino(
//             initialTime: initialTime,
//             setTimeOnChange: setTimeOnChange,
//           ),
//         );
//       },
//     );
//   }

//   isExtended() {
//     setState(() {
//       isExpanded = !isExpanded;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _places_temp = tripController.places_temp;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         // Header section (always visible)
//         Container(
//           decoration: BoxDecoration(
//             color: _isExpanded ? AppColors.orange_950 : AppColors.white,
//             borderRadius:
//                 _isExpanded
//                     ? const BorderRadius.only(
//                       topLeft: Radius.circular(16),
//                       topRight: Radius.circular(16),
//                     )
//                     : BorderRadius.all(Radius.circular(16)),
//           ),
//           margin: const EdgeInsets.all(0),

//           child: InkWell(
//             onTap: () {
//               setState(() {
//                 _isExpanded = !_isExpanded;
//               });
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       const Icon(
//                         LucideIcons.gripVertical,
//                         size: 24,
//                         color: AppColors.gray,
//                       ),
//                       const SizedBox(width: 12),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CustomText(
//                             text: "Day ${widget.day}",
//                             type: TextType.subHeading,
//                             color:
//                                 _isExpanded ? AppColors.white : AppColors.black,
//                           ),
//                           CustomText(
//                             text: formatDateWithOrdinal(widget.date),
//                             type: TextType.body,
//                             color:
//                                 _isExpanded
//                                     ? AppColors.white
//                                     : AppColors.darkGray,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),

//                   Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
//                 ],
//               ),
//             ),
//           ),
//         ),

//         AnimatedContainer(
//           duration: const Duration(milliseconds: 300),
//           height: _isExpanded ? 600 : 0,
//           color: AppColors.white,
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           child:
//               _isExpanded
//                   ? Obx(
//                     () => ReorderableListView.builder(
//                       buildDefaultDragHandles: true,
//                       scrollDirection: Axis.vertical,
//                       // shrinkWrap: true,
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       itemCount: _places.length,

//                       onReorder: handleReorder,
//                       itemBuilder: (context, index) {
//                         String? initialTime = _places[index].arrivalTime!;
//                         List<Map<String, String>> routeOptions =
//                             index < _places.length - 1 &&
//                                     _places[index].placeId != null &&
//                                     _places[index + 1].placeId != null
//                                 ? tripController.findRouteOptions(
//                                   _places[index].placeId!,
//                                   _places[index + 1].placeId!,
//                                 )
//                                 : [];
//                         void setTimeOnChange(TimeOfDay selectedTime) {
//                           setState(() {
//                             var _initialTime = _places[index].arrivalTime;
//                             var _changedTime = selectedTime.format(context);
//                             _places[index].arrivalTime =
//                                 convertTo12HourWithMeridian(_changedTime);
//                             log("${_places[index].arrivalTime}");
//                             tripController.sortPlacebyTimes(
//                               index,
//                               _initialTime!,
//                               _changedTime,
//                             );
//                           });
//                         }

//                         return Padding(
//                           key: ValueKey('place-$index'),
//                           padding: const EdgeInsets.only(bottom: 0.0),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: Column(
//                                   children: [
//                                     Container(
//                                       margin: EdgeInsets.all(0),
//                                       child: Column(
//                                         children: [
//                                           const SizedBox(height: 4),
//                                           if (_places[index].day ==
//                                                   widget.day &&
//                                               index <= _places.length - 1 &&
//                                               _places[index].placeId != null)
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.end,
//                                               children: [
//                                                 Icon(
//                                                   LucideIcons.clock,
//                                                   color: AppColors.orange_950,
//                                                   size: 16,
//                                                 ),
//                                                 TextButton(
//                                                   style: TextButton.styleFrom(
//                                                     padding: EdgeInsets.zero,
//                                                     tapTargetSize:
//                                                         MaterialTapTargetSize
//                                                             .shrinkWrap,
//                                                     minimumSize: Size(0, 0),
//                                                   ),
//                                                   onPressed: (() {
//                                                     showTimePicker(
//                                                       initialTime,
//                                                       setTimeOnChange,
//                                                     );
//                                                   }),
//                                                   child: Text(
//                                                     _places[index].arrivalTime!,
//                                                     style: TextStyle(
//                                                       color:
//                                                           AppColors.orange_950,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),

//                                           if (_places[index].day ==
//                                                   widget.day &&
//                                               index <= _places.length - 1 &&
//                                               _places[index].placeId != null)
//                                             GestureDetector(
//                                               onTap:
//                                                   () => _onCardSelected(index),
//                                               child: Container(
//                                                 decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                     color:
//                                                         _selectedIndex == index
//                                                             ? Colors.blue
//                                                             : Colors
//                                                                 .transparent,
//                                                     width: 2,
//                                                   ),
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                 ),
//                                                 child: PlaceCard(
//                                                   index: index,
//                                                   placeId:
//                                                       _places[index].placeId!,
//                                                   placeName:
//                                                       _places[index].placeName!,
//                                                   placeDescription:
//                                                       _places[index]
//                                                           .placeDescription!,
//                                                   placeImage:
//                                                       _places[index]
//                                                           .placeImageUrl!,
//                                                   arrivalTime:
//                                                       _places[index]
//                                                           .arrivalTime!,
//                                                 ),
//                                               ),
//                                             ),

//                                           if (index == _places.length - 1)
//                                             const SizedBox(height: 10)
//                                           else ...[
//                                             Builder(
//                                               builder: (context) {
//                                                 Trip? matchingRoute = _routes
//                                                     .firstWhereOrNull(
//                                                       (r) =>
//                                                           r.routeFrom ==
//                                                               _places[index]
//                                                                   .placeId &&
//                                                           r.routeTo ==
//                                                               _places[index + 1]
//                                                                   .placeId,
//                                                     );

//                                                 if (matchingRoute != null &&
//                                                     _routes[index].day ==
//                                                         widget.day) {
//                                                   return RouteDropdown(
//                                                     key: ValueKey(
//                                                       'route-${_places[index].placeId}-${_places[index + 1].placeId}',
//                                                     ),
//                                                     choices: routeOptions,
//                                                     pastChoice:
//                                                         _selectedIndex == index
//                                                             ? "Select route mode"
//                                                             : matchingRoute
//                                                                 .routeMode
//                                                                 .toString(),
//                                                   );
//                                                 } else {
//                                                   return SizedBox.shrink(); // fallback
//                                                 }
//                                               },
//                                             ),
//                                           ],

//                                           //else if (index < _routes.length && _routes[index].day == widget.day)
//                                           // RouteDropdown(
//                                           //   key: ValueKey(
//                                           //     'route-${_places[index].placeId}-${_places[index + 1].placeId}-$index',
//                                           //   ),

//                                           //   choices: routeOptions,
//                                           //   pastChoice:
//                                           //       _selectedIndex == index
//                                           //           ? "Select route mode"
//                                           //           : _routes[index].routeMode
//                                           //               .toString(),
//                                           // ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   )
//                   : const SizedBox.shrink(),
//         ),
//       ],
//     );
//   }
// }

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/presentation/controllers/transport_mode_controller.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';
import 'package:triptery/presentation/widgets/time_picker.dart';
import 'package:triptery/presentation/widgets/trip/components/place_card.dart';
import 'package:triptery/presentation/widgets/trip/components/route_dropdown.dart';
import 'package:triptery/domain/entities/trip/trip.dart';
import 'package:triptery/presentation/controllers/trip_controller.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:triptery/utils/datetime.dart';

class Day extends StatefulWidget {
  const Day({super.key, required this.day, required this.date});
  final int day;
  final DateTime date;

  @override
  State<Day> createState() => _DayState();
}

class _DayState extends State<Day> {
  final tripController = Get.find<TripController>();
  bool isExpanded = false;
  bool _isExpanded = false;
  int _selectedIndex = 0;
  var selectedTime = Duration(hours: 9, minutes: 41);
  //NOTE :getter type = dynamic type
  List<Trip> get _places => tripController.getPlaces;
  List<Trip> get _routes => tripController.getRoutes;

  //TEST
  List<Map<String, dynamic>> get _trips_temp => tripController.trips_temp;
  List<Map<String, dynamic>> get _places_temp => tripController.places_temp;
  List<Map<String, dynamic>> get _routes_temp => tripController.routes_temp;
  List<Map<String, dynamic>> get _routeOptions_temp =>
      tripController.routeOptions_temp;

  void _onCardSelected(int index) {
    setState(() {
      if (_selectedIndex == index) {
        _selectedIndex = -1;
      } else {
        _selectedIndex = index;
      }
    });
  }

  void handleReorder(int oldIndex, int newIndex) {
    setState(() {
      tripController.handleReorder(oldIndex, newIndex, _selectedIndex);
    });
  }

  void recalculateAllRoutes() {
    tripController.recalculateAllRoutes();
    // setState(() {});
  }

  // void setTimePicker()

  void showTimePicker(String initialTime, Function(TimeOfDay) setTimeOnChange) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: AppColors.white,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.3,
          child: TimePickerCupertino(
            initialTime: initialTime,
            setTimeOnChange: setTimeOnChange,
          ),
        );
      },
    );
  }

  isExtended() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header section (always visible)
        Container(
          decoration: BoxDecoration(
            color: _isExpanded ? AppColors.orange_950 : AppColors.white,
            borderRadius:
                _isExpanded
                    ? const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    )
                    : BorderRadius.all(Radius.circular(16)),
          ),
          margin: const EdgeInsets.all(0),

          child: InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        LucideIcons.gripVertical,
                        size: 24,
                        color: AppColors.gray,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Day ${widget.day}",
                            type: TextType.subHeading,
                            color:
                                _isExpanded ? AppColors.white : AppColors.black,
                          ),
                          CustomText(
                            text: formatDateWithOrdinal(widget.date),
                            type: TextType.body,
                            color:
                                _isExpanded
                                    ? AppColors.white
                                    : AppColors.darkGray,
                          ),
                        ],
                      ),
                    ],
                  ),

                  Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                ],
              ),
            ),
          ),
        ),

        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _isExpanded ? 600 : 0,
          color: AppColors.white,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child:
              _isExpanded
                  ? Obx(
                    () => ReorderableListView.builder(
                      buildDefaultDragHandles: true,
                      scrollDirection: Axis.vertical,
                      // shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _trips_temp.length,

                      onReorder: handleReorder,
                      itemBuilder: (context, index) {
                        int placeIdFromTrip = _trips_temp[index]["placeId"];
                        // Use firstWhereOrNull for safe lookup
                        // Map<String, dynamic>? currPlace = _places_temp
                        //     .firstWhereOrNull(
                        //       (place) => place["id"] == placeIdFromTrip,
                        //     );
                        Map<String, dynamic>? currPlace = _places_temp
                            .firstWhereOrNull(
                              (place) => place["placeId"] == placeIdFromTrip,
                            );
                        if (currPlace == null) {
                          log("No place found for placeId: $placeIdFromTrip");
                        } else {
                          log("Current Place: ${currPlace["placeName"]}");
                        }
                        String? initialTime =
                            _trips_temp[index]["arrivalTime"]!;

                        void setTimeOnChange(TimeOfDay selectedTime) {
                          setState(() {
                            var _initialTime =
                                _trips_temp[index]["arrivalTime"];
                            var _changedTime = selectedTime.format(context);
                            _trips_temp[index]["arrivalTime"] =
                                convertTo12HourWithMeridian(_changedTime);
                            log("${_trips_temp[index]["arrivalTime"]}");
                            tripController.sortPlacebyTimes(
                              index,
                              _initialTime!,
                              _changedTime,
                            );
                          });
                        }

                        return Padding(
                          key: ValueKey('place-$index'),
                          padding: const EdgeInsets.only(bottom: 0.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(0),
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 4),
                                          if (_trips_temp[index]["day"] ==
                                                  widget.day &&
                                              index <= _trips_temp.length - 1 &&
                                              placeIdFromTrip != null)
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Icon(
                                                  LucideIcons.clock,
                                                  color: AppColors.orange_950,
                                                  size: 16,
                                                ),
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    padding: EdgeInsets.zero,
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    minimumSize: Size(0, 0),
                                                  ),
                                                  onPressed: (() {
                                                    showTimePicker(
                                                      initialTime!,
                                                      setTimeOnChange,
                                                    );
                                                  }),
                                                  child: Text(
                                                    _trips_temp[index]["arrivalTime"]!,
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.orange_950,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),

                                          if (_trips_temp[index]["day"] ==
                                                  widget.day &&
                                              index <= _trips_temp.length - 1 &&
                                              placeIdFromTrip != null)
                                            GestureDetector(
                                              onTap:
                                                  () => _onCardSelected(index),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color:
                                                        _selectedIndex == index
                                                            ? Colors.blue
                                                            : Colors
                                                                .transparent,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: PlaceCard(
                                                  index: index,
                                                  placeId: placeIdFromTrip!,
                                                  placeName:
                                                      currPlace?["placeName"] ??
                                                      "",
                                                  placeDescription:
                                                      currPlace?["placeDescription"] ??
                                                      "",
                                                  placeImage:
                                                      currPlace?["placeImageUrl"] ??
                                                      "",
                                                  arrivalTime:
                                                      currPlace?["arrivalTime"] ??
                                                      "",
                                                  timeSpent:
                                                      _trips_temp[index]["timeSpent"] ??
                                                      "",
                                                  moneySpent:
                                                      _trips_temp[index]["moneySpent"] ??
                                                      0,
                                                  activities:
                                                      currPlace?["activities"] ??
                                                      [],
                                                  note:
                                                      _trips_temp[index]["note"] ??
                                                      "",
                                                ),
                                              ),
                                            ),

                                          if (index == _trips_temp.length - 1)
                                            const SizedBox(height: 10)
                                          else ...[
                                            Builder(
                                              builder: (context) {
                                                Map<String, dynamic>?
                                                matchingRoute = _routes_temp
                                                    .firstWhereOrNull(
                                                      (r) =>
                                                          r["fromPlaceId"]
                                                                  .toString() ==
                                                              placeIdFromTrip
                                                                  .toString() &&
                                                          r["toPlaceId"]
                                                                  .toString() ==
                                                              _trips_temp[index +
                                                                      1]["placeId"]
                                                                  .toString(),
                                                    );
                                                // List<Map<String, String>> routeOptions = index < _trips_temp.length - 1 && placeIdFromTrip != null && _trips_temp[index + 1]["placeId"] != null

                                                if (matchingRoute != null &&
                                                    _routes_temp[index]["day"] ==
                                                        widget.day) {
                                                  List<Map<String, dynamic>>
                                                  routeOptions =
                                                      index <
                                                              _trips_temp
                                                                      .length -
                                                                  1
                                                          ? tripController
                                                              .findRouteOptions(
                                                                matchingRoute["id"],
                                                              )
                                                          : [];
                                                  return RouteDropdown(
                                                    key: ValueKey(
                                                      'route-${_trips_temp[index]["placeId"]}-${_trips_temp[index + 1]["placeId"]}',
                                                    ),
                                                    choices: routeOptions,
                                                  );
                                                } else {
                                                  return SizedBox.shrink(); // fallback
                                                }
                                              },
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                  : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
