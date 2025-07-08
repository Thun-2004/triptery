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
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';
import 'package:triptery/presentation/widgets/time_picker.dart';
import 'package:triptery/presentation/widgets/trip/components/place_card.dart';
import 'package:triptery/presentation/widgets/trip/components/route_dropdown.dart';
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
  bool _isExpanded = false;
  int _selectedIndex = -1;

  void _toggleCardSelected(int index) {
    setState(() {
      _selectedIndex = _selectedIndex == index ? -1 : index;
    });
  }

  void _handleReorder(int oldIndex, int newIndex) {
    setState(() {
      tripController.handleReorder(oldIndex, newIndex, _selectedIndex);
    });
  }

  void _showTimePicker(String initialTime, Function(TimeOfDay) onChange) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: AppColors.white,
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.3,
        child: TimePickerCupertino(
          initialTime: initialTime,
          setTimeOnChange: onChange,
        ),
      ),
    );
  }

  bool _shouldShowForDay(Map<String, dynamic> trip) =>
      trip["day"] == widget.day;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: _isExpanded ? AppColors.orange_950 : AppColors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
              bottom: Radius.circular(_isExpanded ? 0 : 16),
            ),
          ),
          child: InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(LucideIcons.gripVertical, size: 24, color: AppColors.gray),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Day ${widget.day}",
                            type: TextType.subHeading,
                            color: _isExpanded ? AppColors.white : AppColors.black,
                          ),
                          CustomText(
                            text: formatDateWithOrdinal(widget.date),
                            type: TextType.body,
                            color: _isExpanded ? AppColors.white : AppColors.darkGray,
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
          child: _isExpanded
              ? Obx(() {
                  final trips = tripController.trips_temp;
                  final places = tripController.places_temp;
                  final routes = tripController.routes_temp;

                  return ReorderableListView.builder(
                    buildDefaultDragHandles: true,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: trips.length,
                    onReorder: _handleReorder,
                    itemBuilder: (_, index) {
                      final trip = trips[index];
                      final place = places.firstWhereOrNull((p) => p["placeId"] == trip["placeId"]);
                      final initialTime = trip["arrivalTime"];

                      void setTimeOnChange(TimeOfDay selected) {
                        setState(() {
                          final formatted = convertTo12HourWithMeridian(selected.format(context));
                          trip["arrivalTime"] = formatted;
                          tripController.sortPlacebyTimes(index, initialTime!, formatted);
                        });
                      }

                      return Padding(
                        key: ValueKey('place-$index'),
                        padding: const EdgeInsets.only(bottom: 0),
                        child: Column(
                          children: [
                            if (_shouldShowForDay(trip) && place != null)
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(LucideIcons.clock, color: AppColors.orange_950, size: 16),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          minimumSize: Size.zero,
                                        ),
                                        onPressed: () => _showTimePicker(initialTime!, setTimeOnChange),
                                        child: Text(initialTime, style: TextStyle(color: AppColors.orange_950)),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () => _toggleCardSelected(index),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: _selectedIndex == index ? Colors.blue : Colors.transparent,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: PlaceCard(
                                        index: index,
                                        placeId: place["placeId"],
                                        placeName: place["placeName"] ?? "",
                                        placeDescription: place["placeDescription"] ?? "",
                                        placeImage: place["placeImageUrl"] ?? "",
                                        arrivalTime: trip["arrivalTime"] ?? "",
                                        timeSpent: trip["timeSpent"] ?? "",
                                        moneySpent: trip["moneySpent"] ?? 0,
                                        activities: place["activities"] ?? [],
                                        note: trip["note"] ?? "",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            if (index < trips.length - 1)
                              Builder(builder: (_) {
                                final nextTrip = trips[index + 1];
                                final route = routes.firstWhereOrNull((r) =>
                                    r["fromPlaceId"] == trip["placeId"] &&
                                    r["toPlaceId"] == nextTrip["placeId"]);
                                if (route != null && route["day"] == widget.day) {
                                  final routeOptions = tripController.findRouteOptions(route["id"]);
                                  return RouteDropdown(
                                    key: ValueKey('route-${trip["placeId"]}-${nextTrip["placeId"]}'),
                                    choices: routeOptions,
                                  );
                                }
                                return SizedBox.shrink();
                              }),
                          ],
                        ),
                      );
                    },
                  );
                })
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
