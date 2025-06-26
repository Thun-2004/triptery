import 'package:flutter/material.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/presentation/pages/trip/trip_budget_sheet.dart';
import 'package:triptery/presentation/pages/trip/trip_calendar_sheet.dart';
import 'package:triptery/presentation/pages/trip/trip_group_sheet.dart';
import 'package:triptery/presentation/pages/trip/trip_tag_sheet.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';
import 'package:triptery/presentation/widgets/switch.dart';
import 'package:triptery/presentation/widgets/trip/components/trip_tag.dart';

class TripSummaryWindow extends StatefulWidget {
  @override
  _TripSummaryWindowState createState() => _TripSummaryWindowState();
}

class _TripSummaryWindowState extends State<TripSummaryWindow> {
  bool _isPublic = true;
  bool _showCursor = false;
  final FocusNode _tripNameFocus = FocusNode();
  final PageController _pageController = PageController();

  void _openTagModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TripTagWindow(),
    );
  }

  void _openTripGroupModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TripGroupWindow(),
    );
  }

  void _openTripBudgetModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TripBudgetWindow(),
    );
  }

  void _openTripCalendarModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TripCalendarWindow(),
    );
  }

  @override
  void initState() {
    super.initState();
    _tripNameFocus.addListener(() {
      setState(() {
        _showCursor = _tripNameFocus.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _tripNameFocus.dispose();
    super.dispose();
  }

  //TODO : adjust alignment of bottom sheet so that drag handle is shown
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Form(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(""),
                        CustomText(
                          text: '       Trip Setting',
                          type: TextType.subHeading,
                          color: AppColors.black,
                          maxLines: 1,
                        ),
                        CustomText(
                          text: 'Done',
                          type: TextType.body,
                          color: AppColors.black,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            'https://i.pinimg.com/736x/b5/ea/78/b5ea78bc0bac20e8bda063b4f168aeda.jpg',
                            width: double.infinity,
                            height: 160,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black54,
                          ),
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.camera_alt, color: Colors.white),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5, top: 15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: 'Trip Name',
                                          type: TextType.subHeading,
                                          color: AppColors.darkGray,
                                          textSize: 14,
                                        ),
                                        TextFormField(
                                          initialValue: 'Trip name',
                                          autofocus: false,
                                          focusNode: _tripNameFocus,
                                          showCursor: _showCursor,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            // labelText: 'Enter trip username',
                                          ),
                                          onTap: () {
                                            setState(() {
                                              _showCursor = true;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'Trip Dates',
                                type: TextType.subHeading,
                                color: AppColors.darkGray,
                                textSize: 14,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: 'May 25 to May 27, 2025',
                                    type: TextType.subHeading,
                                    color: AppColors.black,
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      textDirection: TextDirection.rtl,
                                      size: 16,
                                    ),
                                    onPressed: () => _openTripCalendarModal(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'Party',
                                type: TextType.subHeading,
                                color: AppColors.darkGray,
                                textSize: 14,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: 'A couple',
                                    type: TextType.subHeading,
                                    color: AppColors.black,
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      textDirection: TextDirection.rtl,
                                      size: 16,
                                    ),
                                    onPressed: () => _openTripGroupModal(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'Budget',
                                type: TextType.subHeading,
                                color: AppColors.darkGray,
                                textSize: 14,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: 'Luxury',
                                    type: TextType.subHeading,
                                    color: AppColors.black,
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      textDirection: TextDirection.rtl,
                                      size: 16,
                                    ),
                                    onPressed: () => _openTripBudgetModal(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'Invited Friends',
                                type: TextType.subHeading,
                                color: AppColors.darkGray,
                                textSize: 14,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 32,
                                    width:
                                        60, // adjust width based on number of avatars
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          child: CircleAvatar(
                                            radius: 16,
                                            backgroundImage: NetworkImage(
                                              'https://i.pinimg.com/736x/cc/ef/e1/ccefe13166d611943acdaca183e2663c.jpg', // replace with real URL
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 20,
                                          child: CircleAvatar(
                                            radius: 16,
                                            backgroundImage: NetworkImage(
                                              'https://i.pinimg.com/736x/c7/11/a5/c711a50ef7ee499797e24cfe9b18898b.jpg',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'Visibility',
                                type: TextType.subHeading,
                                color: AppColors.darkGray,
                                textSize: 14,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: 'Private trip',
                                    type: TextType.subHeading,
                                    color: AppColors.black,
                                  ),
                                  // ToggleSwitch(),
                                  Transform.scale(
                                    scale: 0.8,
                                    child: Switch(
                                      value: _isPublic,
                                      onChanged: (bool value) {
                                        setState(() {
                                          _isPublic = value;
                                        });
                                      },
                                      activeColor: const Color.fromARGB(
                                        255,
                                        81,
                                        234,
                                        160,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'Tags',
                                type: TextType.subHeading,
                                color: AppColors.darkGray,
                                textSize: 14,
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TripTag(tag: 'Party'),
                                  TripTag(tag: 'Adventure'),
                                  TripTag(tag: 'Beach'),
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      textDirection: TextDirection.rtl,
                                      size: 16,
                                    ),
                                    onPressed: () => _openTagModal(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Add your trip summary details here
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
