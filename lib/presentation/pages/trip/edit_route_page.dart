import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/data/mock/mock_trips.dart';
import 'package:triptery/domain/entities/trip/trip.dart';
import 'package:triptery/presentation/controllers/trip_controller.dart';
import 'package:triptery/presentation/widgets/add_button.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';
import 'package:triptery/presentation/widgets/trip/components/day.dart';
import 'package:triptery/presentation/widgets/trip/components/day_list.dart';
import 'package:triptery/presentation/widgets/trip/components/place_card.dart';
import 'package:triptery/presentation/widgets/trip/components/route_dropdown.dart';
import 'package:triptery/presentation/widgets/trip/trip_body.dart';
import 'package:triptery/services/core/trip/trip_service.dart';

class EditRoutePage extends StatefulWidget {
  const EditRoutePage({super.key, required this.day});
  final int day;

  @override
  State<EditRoutePage> createState() => _EditRoutePageState();
}

class _EditRoutePageState extends State<EditRoutePage> {
  final tripController = Get.find<TripController>();
  bool isExpanded = false;
  bool _isExpanded = false;
  int _selectedIndex = 0;
  late TripService tripService;
  late bool _isEditing;
  int selectedDay = 0;
  List<Trip> trips = mockTrips;
  late Widget dayMode;
  //NOTE :getter type = dynamic type
  List<Trip> get _places => tripService.getPlaces();
  List<Trip> get _routes => tripService.getRoutes();

  List<int> get days {
    return trips
        .where((trip) => trip.day > 0)
        .map((trip) => trip.day)
        .toSet()
        .toList();
  }

  void _selectDay(int day) {
    setState(() {
      if (day == 0) {
        dayMode = DayList();
      } else {
        dayMode = Day(day: day);
      }
      selectedDay = day;
    });
  }

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
      tripService.handleReorder(oldIndex, newIndex, _selectedIndex);
    });
  }

  void recalculateAllRoutes() {
    tripService.recalculateAllRoutes();
  }

  void addPlace(index) {
    tripService.addPlace(index);
    setState(() {});
  }

  void deleteCard(index) {
    setState(() {
      tripService.deleteCard(index);
    });
  }

  isExtended() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  void initState() {
    super.initState();
    tripService = TripService(widget.day);
    tripService.init();
    _isEditing = tripController.isEditingPlaceOrder;
  }

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
                    IconButton(
                      icon: const Icon(LucideIcons.x, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SizedBox(
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        DayButton(
                          text: 'All',
                          onPressed: () => (),
                          index: 0,
                          selectedDay: 1,
                        ),
                        const SizedBox(width: 10),
                        ...days.map(
                          (day) => Row(
                            children: [
                              DayButton(
                                text: 'Day $day',
                                onPressed: () => _selectDay(day),
                                index: day,
                                selectedDay: selectedDay,
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
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
                    ),
                  ),
                ),
              ],
            ),
          ),

          //selected deletion
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            alignment: Alignment.bottomCenter,
            height: 50,
            // height: isExpanded ? 50 : 0,
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
                  text: "2 Selected",
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
                        // Your delete logic here
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        LucideIcons.x,
                        color: AppColors.darkBlue,
                      ),
                      onPressed: () {
                        // Your confirm logic here
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          //scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                height: 900, 
                child: ReorderableListView.builder(
                buildDefaultDragHandles: true,
                scrollDirection: Axis.vertical,
                // shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _places.length,

                onReorder: handleReorder,
                itemBuilder: (context, index) {
                  List<Map<String, String>> routeOptions =
                      index < _places.length - 1 &&
                              _places[index].placeId != null &&
                              _places[index + 1].placeId != null
                          ? tripService.findRouteOptions(
                            _places[index].placeId!,
                            _places[index + 1].placeId!,
                          )
                          : [];
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
                                    if (_places[index].day == widget.day &&
                                        index <= _places.length - 1 &&
                                        _places[index].placeId != null)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            LucideIcons.clock,
                                            color: AppColors.orange_950,
                                            size: 16,
                                          ),
                                          CustomText(
                                            text: _places[index].arrivalTime!,
                                            type: TextType.body,
                                            color: AppColors.orange_950,
                                          ),
                                        ],
                                      ),

                                    if (_places[index].day == widget.day &&
                                        index <= _places.length - 1 &&
                                        _places[index].placeId != null)
                                      GestureDetector(
                                        onTap: () => _onCardSelected(index),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color:
                                                  _selectedIndex == index
                                                      ? Colors.blue
                                                      : Colors.transparent,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: PlaceCard(
                                            placeId: _places[index].placeId!,
                                            placeName:
                                                _places[index].placeName!,
                                            placeDescription:
                                                _places[index]
                                                    .placeDescription!,
                                            placeImage:
                                                _places[index].placeImageUrl!,
                                            arrivalTime:
                                                _places[index].arrivalTime!,
                                            onClick: () => deleteCard(index),
                                            isEdit: _isEditing,
                                          ),
                                        ),
                                      ),

                                    if (index == _places.length - 1)
                                      const SizedBox(height: 10)
                                    else if (index < _places.length - 1 &&
                                        index < _routes.length &&
                                        _routes[index].day == widget.day &&
                                        _places[index].placeId != null &&
                                        _places[index + 1].placeId != null &&
                                        routeOptions.isNotEmpty)
                                      RouteDropdown(
                                        key: ValueKey(
                                          'route-${_places[index].placeId}-${_places[index + 1].placeId}-$index',
                                        ),

                                        choices: routeOptions,
                                        pastChoice:
                                            _selectedIndex == index
                                                ? "Select route mode"
                                                : _routes[index].routeMode
                                                    .toString(),
                                      ),

                                    if (_isEditing &&
                                        index < _places.length - 1)
                                      AddButton(
                                        text: "+ Add Place",
                                        textSize: 14,
                                        textColor: AppColors.orange_950,
                                        width: double.infinity,
                                        height: 30,
                                        onPressed: () => addPlace(index),
                                      ),
                                    // ElevatedButton(
                                    //   onPressed:
                                    //       () => addPlace(index),
                                    //   style: ElevatedButton.styleFrom(
                                    //     backgroundColor:
                                    //         Color.fromARGB(
                                    //           255,
                                    //           250,
                                    //           98,
                                    //           47,
                                    //         ),
                                    //     shape: RoundedRectangleBorder(
                                    //       borderRadius:
                                    //           BorderRadius.circular(
                                    //             15,
                                    //           ),
                                    //     ),
                                    //     padding:
                                    //         const EdgeInsets.symmetric(
                                    //           vertical: 10,
                                    //           horizontal: 10,
                                    //         ),
                                    //   ),
                                    //   child: Text(
                                    //     "Add Place",
                                    //     style: TextStyle(
                                    //       color: AppColors.white,
                                    //       fontSize: 14,
                                    //       fontWeight: FontWeight.bold,
                                    //     ),
                                    //   ),
                                    // ),
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
              )),
              //FIX ME: add day info
            ),
          ),
        ],
      ),
    );
  }
}
