// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lucide_icons_flutter/lucide_icons.dart';
// import 'package:triptery/constant/colors.dart';
// import 'package:triptery/domain/entities/trip/trip.dart';
// import 'package:triptery/presentation/controllers/plan_controller.dart';
// import 'package:triptery/presentation/controllers/trip_controller.dart';
// import 'package:triptery/presentation/pages/trip/add_place_sheet.dart';
// import 'package:triptery/presentation/widgets/add_button.dart';
// import 'package:triptery/presentation/widgets/base_ui/text.dart';
// import 'package:triptery/presentation/widgets/time_picker.dart';
// import 'package:triptery/presentation/widgets/trip/components/place_card.dart';
// import 'package:triptery/presentation/widgets/trip/components/route_dropdown.dart';
// import 'package:triptery/presentation/widgets/trip/trip_body.dart';
// import 'package:triptery/utils/datetime.dart';

// //FIXME: change reorderable to widget
// class EditRoutePage extends StatefulWidget {
//   const EditRoutePage({super.key});
//   // final int day;

//   @override
//   State<EditRoutePage> createState() => _EditRoutePageState();
// }

// class _EditRoutePageState extends State<EditRoutePage> {
//   final tripController = Get.find<TripController>();
//   bool isExpanded = false;
//   int _selectedIndex = 0;
//   // late bool _isEditing;
//   int selectedDay = 1;

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
//   }

//   void addPlace(index) {
//     // tripService.addPlace(index);
//     // setState(() {});
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       showDragHandle: true,
//       backgroundColor: AppColors.white,
//       builder: (context) {
//         return FractionallySizedBox(
//           heightFactor: 0.7,
//           child: AddPlaceSheet(prevPlaceId: index),
//         );
//       },
//     );
//   }

//   void addDeletedPlaceCards(int index) {
//     setState(() {
//       tripController.addDeletedPlaceCards(index);
//     });
//   }

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

//   void _selectDay(int day) {
//     setState(() {
//       selectedDay = day;
//       tripController.day.value = day;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//   }
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Text("hello");
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: AppColors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: AppColors.black.withOpacity(0.1),
//                   offset: const Offset(0, 4),
//                   blurRadius: 4,
//                   spreadRadius: 0,
//                 ),
//               ],
//             ),
//             padding: const EdgeInsets.only(
//               top: 50,
//               left: 16,
//               right: 16,
//               bottom: 8,
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.arrow_back, color: Colors.black),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                     CustomText(
//                       text: "Edit Route",
//                       type: TextType.heading,
//                       color: AppColors.black,
//                     ),
//                     TextButton(
//                       style: TextButton.styleFrom(
//                         overlayColor: AppColors.lightGray,
//                       ),
//                       onPressed: () => Navigator.pop(context),
//                       child: const CustomText(
//                         text: 'Done',
//                         type: TextType.subHeading,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8),
//                   child: SizedBox(
//                     height: 40,
//                     child: Obx(() {
//                       PlanController planController =
//                           Get.find<PlanController>();

//                       if (planController.plan.value == null) {
//                         return const Center(child: CircularProgressIndicator());
//                       }
//                       return ListView(
//                         scrollDirection: Axis.horizontal,
//                         children: [
//                           ...List.generate(
//                             planController.plan.value!.dayCount ?? 0,
//                             (index) {
//                               int day = index + 1;
//                               return Row(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(right: 10),
//                                     child: DayButton(
//                                       text: 'Day $day',
//                                       onPressed: () {
//                                         _selectDay(day);
//                                       },
//                                       index: day,
//                                       selectedDay: selectedDay,
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             },
//                           ),

//                           AddButton(
//                             onPressed: () {
//                               // Your logic here
//                             },
//                             text: '+',
//                             textSize: 16,
//                             textColor: AppColors.orange_950,
//                             width: 50,
//                             height: 28,
//                           ),
//                         ],
//                       );
//                     }),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           //selected deletion
//           Obx(() {
//             if (tripController.deletedItemsObs.isEmpty)
//               return const SizedBox.shrink();
//             return AnimatedContainer(
//               duration: const Duration(milliseconds: 300),
//               alignment: Alignment.bottomCenter,
//               height: 50,
//               // height: isExpanded ? 50 : 0,
//               padding: const EdgeInsets.only(right: 16, left: 30),
//               decoration: BoxDecoration(color: AppColors.red),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   CustomText(
//                     text: "Select All",
//                     type: TextType.subHeading,
//                     color: AppColors.darkBlue,
//                   ),
//                   CustomText(
//                     text: "${tripController.deletedItemsObs.length} Selected",
//                     type: TextType.subHeading,
//                     color: AppColors.white,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       IconButton(
//                         icon: const Icon(
//                           LucideIcons.trash2,
//                           color: AppColors.darkBlue,
//                         ),
//                         onPressed: () {
//                           tripController.deleteAllPlaceCards();
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           }),
//           //scrollable content
//           Expanded(
//             child: Obx(() {
//               List<Trip> _places = tripController.getPlaces;
//               List<Trip> _routes = tripController.getRoutes;

//               log(
//                 "Visible places: ${_places.map((e) => '${e.placeName} (Day ${e.day})').toList()}",
//               );

//               return ReorderableListView.builder(
//                 //NOTE reorderable list view is scrollable on its own
//                 buildDefaultDragHandles: true,
//                 scrollDirection: Axis.vertical,
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 itemCount: _places.length,

//                 onReorder: handleReorder,
//                 itemBuilder: (context, index) {
//                   String? initialTime = _places[index].arrivalTime!;
//                   final routeOptions = tripController.findRouteOptions(route["id"]);


//                   void setTimeOnChange(TimeOfDay selectedTime) {
//                     setState(() {
//                       var _initialTime = _places[index].arrivalTime;
//                       var _changedTime = convertTo12HourWithMeridian(
//                         selectedTime.format(context),
//                       );
//                       _places[index].arrivalTime = _changedTime;
//                       log("${_places[index].arrivalTime}");
//                       tripController.sortPlacebyTimes(
//                         index,
//                         _initialTime!,
//                         _changedTime,
//                       );
//                     });
//                   }

//                   return Padding(
//                     key: ValueKey('place-${_places[index].placeId}-$index'),
//                     padding: const EdgeInsets.only(bottom: 0.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Column(
//                             children: [
//                               Container(
//                                 margin: EdgeInsets.all(0),
//                                 child: Column(
//                                   children: [
//                                     const SizedBox(height: 4),
//                                     if (_places[index].day == selectedDay &&
//                                         index <= _places.length - 1 &&
//                                         _places[index].placeId != null)
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.end,
//                                         children: [
//                                           Icon(
//                                             LucideIcons.clock,
//                                             color: AppColors.orange_950,
//                                             size: 16,
//                                           ),
//                                           TextButton(
//                                             style: TextButton.styleFrom(
//                                               padding: EdgeInsets.zero,
//                                               tapTargetSize:
//                                                   MaterialTapTargetSize
//                                                       .shrinkWrap,
//                                               minimumSize: Size(0, 0),
//                                             ),
//                                             onPressed: (() {
//                                               showTimePicker(
//                                                 initialTime,
//                                                 setTimeOnChange,
//                                               );
//                                             }),
//                                             child: Text(
//                                               _places[index].arrivalTime!,
//                                               style: TextStyle(
//                                                 color: AppColors.orange_950,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),

//                                     if (_places[index].day == selectedDay &&
//                                         index <= _places.length - 1 &&
//                                         _places[index].placeId != null)
//                                       GestureDetector(
//                                         onTap: () => _onCardSelected(index),
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             border: Border.all(
//                                               color:
//                                                   _selectedIndex == index
//                                                       ? Colors.blue
//                                                       : Colors.transparent,
//                                               width: 2,
//                                             ),
//                                             borderRadius: BorderRadius.circular(
//                                               8,
//                                             ),
//                                           ),
//                                           child: Obx(
//                                             () => PlaceCard(
//                                               index: index,
//                                               placeId: place["placeId"],
//                                               placeName: place["placeName"] ?? "",
//                                               placeDescription: place["placeDescription"] ?? "",
//                                               placeImage: place["placeImageUrl"] ?? "",
//                                               arrivalTime: trip["arrivalTime"] ?? "",
//                                               timeSpent: trip["timeSpent"] ?? "",
//                                               moneySpent: trip["moneySpent"] ?? 0,
//                                               activities: place["activities"] ?? [],
//                                               note: trip["note"] ?? "",
//                                               isEdit: tripController.isEditingPlaceOrderObs.value,
//                                             ),
//                                           ),
//                                         ),
//                                       ),

//                                     if (index == _places.length - 1)
//                                       const SizedBox(height: 10)
//                                     else ...[
//                                       Builder(
//                                         builder: (context) {
//                                           Trip? matchingRoute = _routes
//                                               .firstWhereOrNull(
//                                                 (r) =>
//                                                     r.routeFrom ==
//                                                         _places[index]
//                                                             .placeId &&
//                                                     r.routeTo ==
//                                                         _places[index + 1]
//                                                             .placeId,
//                                               );

//                                           if (matchingRoute != null &&
//                                               _places[index].day ==
//                                                   selectedDay) {
//                                             return RouteDropdown(
//                                               key: ValueKey(
//                                                 'route-${_places[index].placeId}-${_places[index + 1].placeId}',
//                                               ),
//                                               choices: routeOptions       
//                                             );
//                                           } else {
//                                             return SizedBox.shrink(); // fallback
//                                           }
//                                         },
//                                       ),
//                                     ],

//                                     Obx(() {
//                                       if (tripController
//                                               .isEditingPlaceOrderObs
//                                               .value &&
//                                           index < _places.length - 1 &&
//                                           _places[index].day == selectedDay) {
//                                         return AddButton(
//                                           text: "+ Add Place",
//                                           textSize: 14,
//                                           textColor: AppColors.orange_950,
//                                           width: double.infinity,
//                                           height: 30,
//                                           onPressed: () => addPlace(index),
//                                         );
//                                       } else {
//                                         return const SizedBox.shrink();
//                                       }
//                                     }),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             }),
//           ),

//           //FIXME: add day info
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: (() {
//           tripController.toggleEditPlaceOrder();
//           // setState(() {
//           //   _isEditing = tripController.isEditingPlaceOrder;
//           // });
//         }),

//         elevation: 4,
//         shape: const CircleBorder(),
//         child: Container(
//           width: 56,
//           height: 56,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 const Color(0xFFFEB755), // Light orange
//                 const Color(0xFFFE7D57), // Darker orange
//               ],
//             ),
//           ),
//           child: Icon(LucideIcons.pencilLine, color: Colors.white, size: 28),
//         ),
//       ),
//     );
//   }
// }



import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/presentation/controllers/plan_controller.dart';
import 'package:triptery/presentation/controllers/trip_controller.dart';
import 'package:triptery/presentation/pages/trip/add_place_sheet.dart';
import 'package:triptery/presentation/widgets/add_button.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';
import 'package:triptery/presentation/widgets/time_picker.dart';
import 'package:triptery/presentation/widgets/trip/components/place_card.dart';
import 'package:triptery/presentation/widgets/trip/components/route_dropdown.dart';
import 'package:triptery/presentation/widgets/trip/trip_body.dart';
import 'package:triptery/utils/datetime.dart';

//FIXME: change reorderable to widget
class EditRoutePage extends StatefulWidget {
  const EditRoutePage({super.key});

  @override
  State<EditRoutePage> createState() => _EditRoutePageState();
}

class _EditRoutePageState extends State<EditRoutePage> {
  final tripController = Get.find<TripController>();
  bool isExpanded = false;
  int _selectedIndex = 0;
  int selectedDay = 1;

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

  void addPlace(index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: AppColors.white,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.7,
          child: AddPlaceSheet(prevPlaceId: index),
        );
      },
    );
  }

  void addDeletedPlaceCards(int index) {
    setState(() {
      tripController.addDeletedPlaceCards(index);
    });
  }

  void showTimePicker(String initialTime, Function(TimeOfDay) setTimeOnChange) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: AppColors.white,
      builder: (_) {
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

  void _selectDay(int day) {
    setState(() {
      selectedDay = day;
      tripController.day.value = day;
    });
  }

  bool _shouldShowForDay(Map<String, dynamic> trip) =>
      trip["day"] == selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  offset: const Offset(0, 4),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ],
            ),
            padding: const EdgeInsets.only(
              top: 50,
              left: 16,
              right: 16,
              bottom: 8,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                    CustomText(
                      text: "Edit Route",
                      type: TextType.heading,
                      color: AppColors.black,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        overlayColor: AppColors.lightGray,
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const CustomText(
                        text: 'Done',
                        type: TextType.subHeading,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SizedBox(
                    height: 40,
                    child: Obx(() {
                      PlanController planController = Get.find<PlanController>();

                      if (planController.plan.value == null) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ...List.generate(
                            planController.plan.value!.dayCount ?? 0,
                            (index) {
                              int day = index + 1;
                              return Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        GestureDetector(
                                          onLongPress: (){
                                            tripController.toggleEditDay(); 
                                          },
                                          child: DayButton(
                                            text: 'Day $day',
                                            onPressed: () {
                                              _selectDay(day);
                                            },
                                            index: day,
                                            selectedDay: selectedDay,
                                          )
                                        ), 

                                        if (tripController.isEditingDay.value)
                                          Positioned(
                                            top: -10, 
                                            right: -5,
                                            child: CircleAvatar(
                                              radius: 10,
                                              backgroundColor: AppColors.red,
                                              foregroundColor: Colors.white,
                                              child: Icon(LucideIcons.minus, size: 14),
                                            ), 
                                          ),
                                        
                                    ]
                                    )
                                  ),
                                ],
                              );
                            },
                          ),

                          AddButton(
                            onPressed: () {
                              // Your logic here
                            },
                            text: '+',
                            textSize: 16,
                            textColor: AppColors.orange_950,
                            width: 50,
                            height: 28,
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),

          //selected deletion
          Obx(() {
            if (tripController.deletedItemsObs.isEmpty)
              return const SizedBox.shrink();
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              alignment: Alignment.bottomCenter,
              height: 50,
              padding: const EdgeInsets.only(right: 16, left: 30),
              decoration: BoxDecoration(color: AppColors.red),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Select All",
                    type: TextType.subHeading,
                    color: AppColors.darkBlue,
                  ),
                  CustomText(
                    text: "${tripController.deletedItemsObs.length} Selected",
                    type: TextType.subHeading,
                    color: AppColors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(
                          LucideIcons.trash2,
                          color: AppColors.darkBlue,
                        ),
                        onPressed: () {
                          tripController.deleteAllPlaceCards();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
          //scrollable content
          Expanded(
            child: Obx(() {
              final trips = tripController.trips_temp;
              final places = tripController.places_temp;
              final routes =  tripController.routes_temp;

              return ReorderableListView.builder(
                //NOTE reorderable list view is scrollable on its own
                buildDefaultDragHandles: true,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: trips.length,
                onReorder: handleReorder,

                itemBuilder: (context, index) {
                  final trip = trips[index];
                  final place = places.firstWhereOrNull((p) => p["placeId"] == trip["placeId"]);
                  final initialTime = trip["arrivalTime"];

                  void setTimeOnChange(TimeOfDay seleted) {
                    setState(() {
                      final formatted = convertTo12HourWithMeridian(seleted.format(context));
                      trip["arrivalTime"] = formatted;
                      tripController.sortPlacebyTimes(index, formatted);
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
                                        onPressed: () => showTimePicker(initialTime!, setTimeOnChange),
                                        child: Text(initialTime, style: TextStyle(color: AppColors.orange_950)),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () => _onCardSelected(index),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: _selectedIndex == index ? Colors.blue : Colors.transparent,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: PlaceCard(
                                        key: ValueKey('place-card-${trip["placeId"]}-$index'),
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
                                        addDeletedItem: addDeletedPlaceCards,
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

                                if (route != null && route["day"] == selectedDay) {
                                  List<Map<String, dynamic>> routeOptions = tripController.findRouteOptions(route["id"]);
                                  if (routeOptions.isEmpty) {
                                    WidgetsBinding.instance.addPostFrameCallback((_) {
                                      tripController.populateRouteOptionDefaultValues(route["id"]);
                                    });
                                    
                                    routeOptions = tripController.findRouteOptions(route["id"]);
                                  }
                                  return RouteDropdown(
                                    key: ValueKey('route-${trip["placeId"]}-${nextTrip["placeId"]}'),
                                    routeId: trip["routeId"],
                                    choices: routeOptions,
                                  );
                                }
                                return SizedBox.shrink();
                              }),
                              Obx(() {
                                if (tripController.isEditingPlaceOrderObs.value && index <= trips.length - 1 &&
                                    trips[index]["day"] == selectedDay) {
                                  return Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      margin: const EdgeInsets.symmetric(vertical: 8),
                                      child: AddButton(
                                        text: "+ Add Place",
                                        textSize: 14,
                                        textColor: AppColors.orange_950,
                                        width: double.infinity,
                                        height: 30,
                                        onPressed: () => addPlace(index),
                                      )
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              }),
                          ],
                        ),
                      );
                },
              );
            }),
          ),

          //FIXME: add day info
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          tripController.toggleEditPlaceOrder();
        }),

        elevation: 4,
        shape: const CircleBorder(),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFFFEB755), // Light orange
                const Color(0xFFFE7D57), // Darker orange
              ],
            ),
          ),
          child: Icon(LucideIcons.pencilLine, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}

//FIXME: delete from last not wotking
