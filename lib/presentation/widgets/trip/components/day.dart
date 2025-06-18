import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';
import 'package:triptery/presentation/widgets/time_picker.dart';
import 'package:triptery/presentation/widgets/trip/components/place_card.dart';
import 'package:triptery/presentation/widgets/trip/components/route_dropdown.dart';
import 'package:triptery/domain/entities/trip/trip.dart';
import 'package:triptery/presentation/controllers/trip_controller.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:triptery/services/core/trip/trip_service2.dart';

//FIXME : change to DraggableScrollableSheet class
class Day extends StatefulWidget {
  const Day({super.key, required this.day});
  final int day;

  @override
  State<Day> createState() => _DayState();
}

class _DayState extends State<Day> {
  final tripController = Get.find<TripController>();
  bool isExpanded = false;
  bool _isExpanded = false;
  int _selectedIndex = 0;
  late TripService tripService;
  var selectedTime = Duration(hours: 9, minutes: 41);
  //NOTE :getter type = dynamic type
  List<Trip> get temp_routes => tripService.getEntireRoutes(); 
  // List<Trip> get _places => tripService.getPlaces();
  // List<Trip> get _routes => tripService.getRoutes();

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

  void addPlace(int index) {
    tripService.addPlace(index);
    setState(() {});
  }

  void showTimePicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: AppColors.white,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.3,
          child: TimePickerCupertino(),
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
    tripService = TripService(widget.day);
    tripService.init();
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
                            text: "Day 1",
                            type: TextType.subHeading,
                            color:
                                _isExpanded ? AppColors.white : AppColors.black,
                          ),
                          CustomText(
                            text: "Thursday, 12th October 2023",
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
                  ? ReorderableListView.builder(
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
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                  padding: EdgeInsets.zero,
                                                  tapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  minimumSize: Size(0, 0),
                                                ),
                                                onPressed: (() {
                                                  showTimePicker();
                                                }),
                                                child: Text(
                                                  _places[index].arrivalTime!,
                                                  style: TextStyle(
                                                    color: AppColors.orange_950,
                                                  ),
                                                ),
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
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: PlaceCard(
                                                index: index,
                                                placeId:
                                                    _places[index].placeId!,
                                                placeName:
                                                    _places[index].placeName!,
                                                placeDescription:
                                                    _places[index]
                                                        .placeDescription!,
                                                placeImage:
                                                    _places[index]
                                                        .placeImageUrl!,
                                                arrivalTime:
                                                    _places[index].arrivalTime!,
                                              ),
                                            ),
                                          ),

                                        if (index == _places.length - 1)
                                          const SizedBox(height: 10)
                                        else if (index < _places.length - 1 &&
                                            index < _routes.length &&
                                            _routes[index].day == widget.day &&
                                            _places[index].placeId != null &&
                                            _places[index + 1].placeId !=
                                                null &&
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
                  )
                  : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
