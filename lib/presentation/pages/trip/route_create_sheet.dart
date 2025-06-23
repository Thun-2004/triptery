import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/constant/transport_modes.dart';
import 'package:triptery/presentation/controllers/transport_mode_controller.dart';
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
  // List<TransportMode> modes = [TransportMode.unSelected];
  bool displayTransport = false;
  TransportModeController transportModeController = Get.find<TransportModeController>();
  
  void onChangeIcon() {
    setState(() {
      displayTransport = !displayTransport;
    });
  }


  @override
  Widget build(BuildContext context) {
    return  Align(
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
                                itemCount: transportModeController.tempModes.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        getIconForMode(
                                          transportModeController.tempModes[index]["mode"],
                                        ),
                                        // LucideIcons.footprints,
                                        color: AppColors.black,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 2),
                                      Tag(
                                        text:
                                            transportModeController.tempModes[index]["station"] ??
                                            getTransportModeName(
                                              transportModeController.tempModes[index]["mode"],
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
                                        text: transportModeController.tempModes[index]["note"],
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
                              text: "${transportModeController.calcTotalTime().toString()} min",
                              type: TextType.body,
                              textSize: 12,
                              color: AppColors.black,
                            ),
                            CustomText(
                              text: "${transportModeController.calcTotalDistance()} km - ${transportModeController.calcTotalCost()} THB",
                              type: TextType.body,
                              textSize: 12,
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
                        itemCount: transportModeController.tempModes.length,
                        itemBuilder: (context, index) {
                          return TimelineTile(
                            alignment: TimelineAlign.start,
                            lineXY: 0.1,
                            isFirst: index == 0 ? true : false,
                            isLast: index == transportModeController.tempModes.length - 1 ? true : false,
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
                                    transportModeController.tempModes.removeAt(index);
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
                                  index == transportModeController.tempModes.length - 1
                                      ? EdgeInsets.only(bottom: 0)
                                      : EdgeInsets.only(bottom: 16),
                              child: TransportCard(
                                mode: transportModeController.tempModes[index]["mode"],
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
                          onPressed: (){
                            transportModeController.addMode(TransportMode.unSelected);
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
