import 'package:flutter/material.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/presentation/pages/trip/trip_budget_sheet.dart';
import 'package:triptery/presentation/pages/trip/trip_calendar_sheet.dart';
import 'package:triptery/presentation/pages/trip/trip_group_sheet.dart';
import 'package:triptery/presentation/pages/trip/trip_summary_sheet.dart';
import 'package:triptery/presentation/pages/trip/trip_tag_sheet.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';

class TripFlowControlSheet extends StatefulWidget {
  const TripFlowControlSheet({super.key});

  @override
  _TripFlowControlSheetState createState() => _TripFlowControlSheetState();
}

class _TripFlowControlSheetState extends State<TripFlowControlSheet> {
  int _currentPage = 0;
  final List<String> pageLabels = [
    'TripReview',
    'TripCalendar',
    'TripGroup',
    'TripBudget',
    'TripTag',
  ];

  Widget _buildTripReviewSection() {
    return TripSummaryWindow(
      onChangeGroup: () => _gotoPage('TripGroup'),
      onChangeBudget: () => _gotoPage('TripBudget'),
      onChangeCalendar: () => _gotoPage('TripCalendar'),
      onChangeTag: () => _gotoPage('TripTag'),
    );
  }

  //add padding to this
  Widget _buildTripTagSection() {
    return Center(child: TripTagWindow());
  }

  Widget _buildTripGroupSection() {
    return Center(child: TripGroupWindow());
  }

  Widget _buildTripBudgetSection() {
    return Center(child: TripBudgetWindow());
  }

  Widget _buildTripCalendarPage() {
    return Center(child: TripCalendarWindow());
  }

  Widget _buildCurrentPage(int index) {
    switch (index) {
      case 0:
        return KeyedSubtree(key: ValueKey(0), child: _buildTripReviewSection());
      case 1:
        return KeyedSubtree(key: ValueKey(1), child: _buildTripCalendarPage());
      case 2:
        return KeyedSubtree(key: ValueKey(2), child: _buildTripGroupSection());
      case 3:
        return KeyedSubtree(key: ValueKey(3), child: _buildTripBudgetSection());
      case 4:
        return KeyedSubtree(key: ValueKey(4), child: _buildTripTagSection());
      default:
        return SizedBox.shrink();
    }
  }

  void _gotoPage(String label) {
    final index = pageLabels.indexOf(label);
    if (index != -1) {
      setState(() {
        _currentPage = index;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
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
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _currentPage = 0; // Reset to the first page
                          });
                        },
                        icon: Icon(Icons.arrow_back, color: AppColors.black),
                      ),

                      CustomText(
                        text: 'Trip Setting',
                        type: TextType.subHeading,
                        color: AppColors.black,
                        maxLines: 1,
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
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 670,
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      transitionBuilder: (
                        Widget child,
                        Animation<double> animation,
                      ) {
                        final offsetAnimation = Tween<Offset>(
                          begin: const Offset(1.0, 0.0), // Slide in from right
                          end: Offset.zero,
                        ).animate(animation);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                      child: _buildCurrentPage(_currentPage),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
