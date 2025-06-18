import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/presentation/controllers/plan_controller.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';
import 'package:triptery/presentation/widgets/trip/components/day.dart';
import 'package:triptery/presentation/widgets/trip/components/day_list.dart';
// import 'package:triptery/data/mock/mock_trips.dart';

class TripState extends ChangeNotifier {
  bool showDelete = false;

  void toggleDelete() {
    showDelete = !showDelete;
    notifyListeners();
  }
}

class TripBody extends StatefulWidget {
  const TripBody({super.key});

  @override
  State<TripBody> createState() => _TripBodyState();
}

class _TripBodyState extends State<TripBody> {
  int selectedDay = 0;
  late Widget dayMode;

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

  @override
  void initState() {
    super.initState();
    dayMode = DayList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(color: AppColors.grayBg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(color: AppColors.white),
              child: SizedBox(
                height: 40,
                child: Obx(() {
                  final plan = Get.find<PlanController>().plan.value;

                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      DayButton(
                        text: 'All',
                        onPressed: () => _selectDay(0),
                        index: 0,
                        selectedDay: selectedDay,
                      ),
                      const SizedBox(width: 10),

                      ...List.generate(plan!.dayCount ?? 0, (index) {
                        final day = index + 1;
                        return Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: DayButton(
                                text: 'Day $day',
                                onPressed: () => _selectDay(day),
                                index: day,
                                selectedDay: selectedDay,
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  );
                }),
              ),
            ),
          ),
          Container(
            height: 845,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: dayMode,
          ),
          //dayMode,
          const SizedBox(height: 16),

          //Add your trip details here
        ],
      ),
    );
  }
}

class DayButton extends StatefulWidget {
  const DayButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.index,
    required this.selectedDay,
  });

  final String text;
  final VoidCallback onPressed;
  final int index;
  final int selectedDay;

  @override
  State<DayButton> createState() => DayButtonState();
}

class DayButtonState extends State<DayButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.onPressed();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            widget.index == widget.selectedDay
                ? AppColors.orange_900
                : AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color:
                widget.index == widget.selectedDay
                    ? Colors.transparent
                    : AppColors.gray,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      ),
      child: CustomText(
        text: widget.text,
        type: TextType.body,
        color:
            widget.index == widget.selectedDay
                ? AppColors.white
                : AppColors.black,
      ),
    );
  }
}
