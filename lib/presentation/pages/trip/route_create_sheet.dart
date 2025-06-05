import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';
import 'package:triptery/presentation/widgets/tag.dart';
import 'package:triptery/presentation/widgets/trip/components/transport_card.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CreateTransportWindow extends StatefulWidget {
  const CreateTransportWindow({super.key});

  @override
  State<CreateTransportWindow> createState() => _CreateTransportWindowState();
}

class _CreateTransportWindowState extends State<CreateTransportWindow> {

  @override
  Widget build(BuildContext context) {

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height.toInt() * 0.7,
        padding: const EdgeInsets.symmetric(vertical: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(""),
                      CustomText(
                        text: 'Create transport',
                        type: TextType.heading,
                        color: Colors.black,
                      ),
                      Icon(LucideIcons.x),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomText(
                    text: 'Preview',
                    type: TextType.body,
                    color: Colors.black,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
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
                                  text:
                                      "Ratchada Market - Subway Station",
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
                    children: [ TimelineTile(
                      alignment: TimelineAlign.start,
                      lineXY: 0.1,
                      isFirst: true,
                      beforeLineStyle: LineStyle(
                          color: AppColors.orange_800,
                          thickness: 2,
                      ),
                      afterLineStyle: LineStyle(
                          color: AppColors.orange_800,
                          thickness: 2,
                      ),
                      indicatorStyle: IndicatorStyle(
                        width: 20,
                        color: AppColors.orange_800,
                        iconStyle: IconStyle(
                          iconData: Icons.remove,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      endChild: TransportCard()
                    ),
                    ]
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
