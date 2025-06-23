import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/constant/transport_modes.dart';
import 'package:triptery/presentation/widgets/add_button.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';
import 'package:triptery/presentation/widgets/tag.dart';
import 'package:triptery/presentation/widgets/trip/components/transport_card.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:triptery/utils/datetime.dart';
import 'package:triptery/utils/icon.dart';

//NOTE: save to cache when user not focus then to db

class CreateTransportWindow extends StatefulWidget {
  const CreateTransportWindow({super.key});

  @override
  State<CreateTransportWindow> createState() => _CreateTransportWindowState();
}

class _CreateTransportWindowState extends State<CreateTransportWindow> {
  List<TransportMode> modes = [TransportMode.unSelected];
  bool displayTransport = false;
  // List<Map<String, dynamic>> tempModes = [
  //   {
  //     "planId": 1,
  //     "day": 1,
  //     "total_time": 21,
  //     "total_cost": 47,
  //     "total_distance": 21,
  //     "fromPlaceId": "placeId1",
  //     "toPlaceId": "placeId2",
  //     "tripDetail" : [
  //       {
  //         "name": TransportMode.unSelected,
  //         "station": "Ratchada Market",
  //         "time_taken": "00:21",
  //         "distance": 21,
  //         "distance_unit": "km",
  //         "cost": 47,
  //         "cost_unit" : "THB",
  //         "note": "Walk to MRT Huai Kwang",
  //       }
  //     ],
  //     "createdAt": DateTime.now().toIso8601String(),
  //     "approved": false,
  //   },
  // ];
  List<Map<String, dynamic>> tempModes = [
    {
      "mode": TransportMode.unSelected,
      "station": null,
      "time_taken": "00:21",
      "distance": 21,
      "distance_unit": "km",
      "cost": 47,
      "cost_unit": "THB",
      "note": "Walk to MRT Huai Kwang",
    },
    {
      "mode": TransportMode.car,
      "station": null,
      "time_taken": "00:21",
      "distance": 21,
      "distance_unit": "km",
      "cost": 47,
      "cost_unit": "THB",
      "note": "Walk to MRT Huai Kwang",
    },
    {
      "mode": TransportMode.car,
      "station": null,
      "time_taken": "00:21",
      "distance": 21,
      "distance_unit": "km",
      "cost": 47,
      "cost_unit": "THB",
      "note": "Walk to MRT Huai Kwang",
    },
  ];

  void addMode(TransportMode mode) {
    setState(() {
      modes.add(mode);
    });
  }

  void onChangeIcon() {
    setState(() {
      displayTransport = !displayTransport;
    });
  }

  int calcTotalTime() {
    int totalTime = 0;
    for (var mode in tempModes) {
      if (mode["time_taken"] != null) {
        totalTime += convertToMinutes(mode["time_taken"]);
      }
    }
    return totalTime;
  }

  //NOTE: num = both int/float
  num calcTotalDistance() {
    num totalDistance = 0;
    for (var mode in tempModes) {
      if (mode["distance"] != null) {
        if (mode["distance_unit"] == "km") {
          totalDistance += mode["distance"];
        } else if (mode["distance_unit"] == "meters") {
          totalDistance += mode["distance"] / 1000; // Convert meters to km
        } 
      }
    }
    return totalDistance;
  }

  num calcTotalCost() {
    num totalCost = 0;
    for (var mode in tempModes) {
      if (mode["cost"] != null) {
        totalCost += mode["cost"];
      }
    }
    return totalCost;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          overlayColor: AppColors.lightGray,
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const CustomText(
                          text: 'Clear',
                          type: TextType.subHeading,
                          color: Colors.black,
                        ),
                      ),
                      CustomText(
                        text: 'Create transport',
                        type: TextType.heading,
                        color: Colors.black,
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
                  const SizedBox(height: 20),
                  CustomText(
                    text: 'Preview',
                    type: TextType.body,
                    color: Colors.black,
                  ),

                Container(                    
                    margin: const EdgeInsets.only(bottom: 16, top: 4),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.lightGray,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //transport mode
                            SizedBox(
                              width: 300,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: tempModes.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        getIconForMode(
                                          tempModes[index]["mode"],
                                        ),
                                        // LucideIcons.footprints,
                                        color: AppColors.black,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 2),
                                      Tag(
                                        text:
                                            tempModes[index]["station"] ??
                                            getTransportModeName(
                                              tempModes[index]["mode"],
                                            ),
                                        textColor: AppColors.white,
                                        tagColor: AppColors.orange_950,
                                        textSize: 10,
                                        height: 16,
                                        borderRadius: 5,
                                        // width: 20,
                                      ),
                                      const SizedBox(width: 4),
                                      CustomText(
                                        text: tempModes[index]["note"],
                                        type: TextType.subHeading,
                                        textSize: 10,
                                        color: AppColors.black,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomText(
                              text: "${calcTotalTime().toString()} min",
                              type: TextType.body,
                              color: AppColors.black,
                            ),
                            CustomText(
                              text: "${calcTotalDistance()} km - ${calcTotalCost()} THB",
                              type: TextType.body,
                              color: AppColors.black,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: modes.length,
                        itemBuilder: (context, index) {
                          return TimelineTile(
                            alignment: TimelineAlign.start,
                            lineXY: 0.1,
                            isFirst: index == 0 ? true : false,
                            isLast: index == modes.length - 1 ? true : false,
                            beforeLineStyle: LineStyle(
                              color: AppColors.orange_800,
                              thickness: 2,
                            ),
                            afterLineStyle: LineStyle(
                              color: AppColors.orange_800,
                              thickness: 2,
                            ),
                            indicatorStyle: IndicatorStyle(
                              indicator: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    modes.removeAt(index);
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.orange_800,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    LucideIcons.minus,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                            endChild: Padding(
                              padding:
                                  index == modes.length - 1
                                      ? EdgeInsets.only(bottom: 0)
                                      : EdgeInsets.only(bottom: 16),
                              child: TransportCard(
                                mode: modes[index],
                                onChangeIcon: onChangeIcon,
                              ),
                            ),
                          );
                        },
                      ),

                      //add element here
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: AddButton(
                          onPressed: () {
                            addMode(TransportMode.unSelected);
                          },
                          text: "Add transport",
                          textColor: AppColors.orange_950,
                          borderColor: AppColors.orange_950,
                          // borderRadius: 8,
                          width: double.infinity,
                          height: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
