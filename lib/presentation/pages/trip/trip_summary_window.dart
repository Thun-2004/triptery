import 'package:flutter/material.dart';
import 'package:triptery/presentation/pages/trip/trip_budget_window.dart';
import 'package:triptery/presentation/pages/trip/trip_calendar_window.dart';
import 'package:triptery/presentation/pages/trip/trip_group_window.dart';
import 'package:triptery/presentation/pages/trip/trip_tag_window.dart';
import 'package:triptery/presentation/widgets/trip_page/components/trip_tag.dart';

class TripSummaryWindow extends StatefulWidget {
  @override
  _TripSummaryWindowState createState() => _TripSummaryWindowState();
}

class _TripSummaryWindowState extends State<TripSummaryWindow> {
  bool _isPublic = true;
  bool _showCursor = false; 
  final FocusNode _tripNameFocus = FocusNode();

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector (
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
            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                Text('Review Summary'),

                const SizedBox(height: 30),
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded (
                                child: Row(
                                children: [
                                  Icon(Icons.location_on),

                                  Expanded(
                                    child: TextFormField(
                                      initialValue: 'Trip name',
                                      autofocus: false,
                                      focusNode: _tripNameFocus,
                                      showCursor: _showCursor,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        floatingLabelBehavior: FloatingLabelBehavior.never,
                                        // labelText: 'Enter trip username',
                                      ),
                                      onTap: (){
                                        setState(() {
                                          _showCursor = true;
                                        });
                                      }
                                    ),
                                  ),
                                ],
                              )
                              ), 

                              // IconButton(
                              //   icon: Icon(Icons.arrow_back_ios,
                              //     textDirection: TextDirection.rtl,
                              //     size: 16),
                              //   onPressed: () => _openTagModal(),
                              // )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 100,
                            width: 200,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 225, 225, 225),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.location_on),
                                  Text('Party'),
                                ],
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
                          const SizedBox(height: 10),

                          Row(
                            children: [
                              const SizedBox(width: 10),
                              Text("A couple"),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.location_on),
                                  Text('Trip Dates'),
                                ],
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
                          const SizedBox(height: 10),

                          Row(
                            children: [
                              const SizedBox(width: 10),
                              Text("May 25 to May 27, 2025"),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.tag_rounded),
                                  Text('Tags'),
                                ],
                              ),

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
                          const SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(width: 10),
                              TripTag(tag: 'Party'),
                              TripTag(tag: 'Adventure'),
                              TripTag(tag: 'Beach'),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.location_on),
                                  Text('Budget'),
                                ],
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
                          const SizedBox(height: 10),

                          Row(
                            children: [
                              const SizedBox(width: 10),
                              Text("Luxury"),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.location_on),
                                  Text('Set visibility public'),
                                ],
                              ),

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
                  ],
                ),
                // Add your trip summary details here
              ],
            ),
          ),
        ),
      ),
    )
    ); 
  }
}
