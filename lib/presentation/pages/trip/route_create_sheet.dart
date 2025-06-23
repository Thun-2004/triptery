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

//NOTE: save to cache when user not focus then to db

class CreateTransportWindow extends StatefulWidget {
  const CreateTransportWindow({super.key});

  @override
  State<CreateTransportWindow> createState() => _CreateTransportWindowState();
}

class _CreateTransportWindowState extends State<CreateTransportWindow> {
  List<TransportMode> modes = [TransportMode.unSelected];
  bool displayTransport = false;
  List<Map<String, dynamic>> tempModes = [
    {
      "planId": 1, 
      "day": 1, 
      "total_time": 21,
      "total_cost": 47,
      "total_distance": 21,
      "fromPlaceId": "placeId1",
      "toPlaceId": "placeId2",
      "tripDetail" : [
        {
          "name": TransportMode.unSelected,
          "station": "Ratchada Market",
          "time_taken": "00:21",
          "distance": 21,
          "distance_unit": "km",
          "cost": 47,
          "cost_unit" : "THB", 
          "note": "Walk to MRT Huai Kwang",
        }
      ],
      "createdAt": DateTime.now().toIso8601String(),
      "approved": false,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //transport mode
                            Row(
                              children: [
                                Icon(
                                  LucideIcons.footprints,
                                  color: AppColors.black,
                                  size: 16,
                                ),
                                const SizedBox(width: 2),
                                Tag(
                                  text: "Walk",
                                  textColor: AppColors.white,
                                  tagColor: AppColors.orange_950,
                                  textSize: 6,
                                  height: 10,
                                  borderRadius: 2,
                                  width: 20,
                                ),
                                const SizedBox(width: 4),
                                CustomText(
                                  text: "Walk to MRT Huai Kwang",
                                  type: TextType.subHeading,
                                  textSize: 10,
                                  color: AppColors.black,
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            //transport mode
                            Row(
                              children: [
                                Icon(
                                  LucideIcons.trainFront,
                                  color: AppColors.black,
                                  size: 16,
                                ),
                                const SizedBox(width: 2),
                                Tag(
                                  text: "BL 18",
                                  textColor: AppColors.white,
                                  tagColor: AppColors.mrtBlue,
                                  textSize: 6,
                                  height: 10,
                                  borderRadius: 2,
                                  width: 22,
                                ),
                                const SizedBox(width: 4),
                                CustomText(
                                  text: "Ratchada Market - Subway Station",
                                  type: TextType.subHeading,
                                  textSize: 10,
                                  color: AppColors.black,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomText(
                              text: "21 mins",
                              type: TextType.body,
                              color: AppColors.black,
                            ),
                            Text(
                              "21 km - 47 THB",
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 10,
                              ),
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

