import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/presentation/pages/trip/route_create_sheet.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';
import 'package:triptery/presentation/widgets/drop_down_area.dart';
import 'package:triptery/presentation/widgets/tag.dart';

//TODO : Fix overflow issue with long text in dropdown
//TODO : Add currency converter for price
//TODO : AnimatedContainer, DropDown2, use contentPadding, Textformfield

class RouteDropdown extends StatefulWidget {
  RouteDropdown({
    super.key,
    required this.choices,
    this.pastChoice = "Transportation mode",
  });

  final List<Map<String, String>> choices;
  String pastChoice;

  @override
  State<RouteDropdown> createState() => _RouteDropdownState();
}

class _RouteDropdownState extends State<RouteDropdown> {
  var selected = 0;
  bool isSelected = false;
  late String currentChoice;
  late final List<Map<String, String>> routes;

  void toggleExpand() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  void _openCreateTransportModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      showDragHandle: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.7,
          child: CreateTransportWindow(),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    routes = widget.choices;
    currentChoice = widget.pastChoice;
  }

  @override
  Widget build(BuildContext context) {
    final routesToDisplay = routes.isNotEmpty ? routes : [];

    return DropDownArea(
      elevation: 2,
      verticalMargin: 10,
      isExpanded: isSelected,
      toggleExpand: toggleExpand,
      header: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppColors.orange_900
                  : const Color.fromARGB(255, 252, 252, 252),
          borderRadius:
              isSelected
                  ? BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  )
                  : BorderRadius.circular(16),
        ),
        width: double.infinity,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  currentChoice,
                  style: TextStyle(
                    color: isSelected ? AppColors.white : AppColors.black,
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomText(
                      text: "21 mins",
                      type: TextType.body,
                      color: isSelected ? AppColors.white : AppColors.black,
                    ),
                    Text(
                      "11.5 km - 180฿",
                      style: TextStyle(
                        color: isSelected ? AppColors.white : AppColors.black,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 4),
                Icon(
                  isSelected
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up,
                  color: isSelected ? AppColors.white : AppColors.black,
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 15.0),
        decoration: BoxDecoration(
          color: AppColors.white,

          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          // decoration: BoxDecoration(
          //   color: AppColors.white,
          // ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (routesToDisplay.isEmpty)
                const Text("No routes available")
              else
                ...List.generate(routesToDisplay.length, (i) {
                  return Column(
                    children: [
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              routesToDisplay[i]["mode"] ?? 'Unknown mode',
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CustomText(
                                      text: "21 mins",
                                      type: TextType.heading,
                                      textSize: 12,
                                      color: AppColors.black,
                                    ),
                                    Text(
                                      "11.5 km - 180฿",
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 4),
                              ],
                            ),
                          ],
                        ),
                        // subtitle: Text(
                        //   "${routesToDisplay[i]["time"] ?? 'Unknown time'} · ${routesToDisplay[i]["price"] ?? 'Unknown price'}",
                        // ),
                        leading: Radio<int>(
                          value: i,
                          groupValue: selected,
                          onChanged: (int? value) {
                            setState(() {
                              selected = value!;
                              currentChoice =
                                  routesToDisplay[i]["mode"] ?? 'Unknown mode';
                              widget.pastChoice = currentChoice;
                            });
                          },
                        ),
                      ),

                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Column(
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
                                      "Ratchada Market - Subway Station BTS Silom",
                                  type: TextType.subHeading,
                                  textSize: 10,
                                  color: AppColors.black,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Google Maps",
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      LucideIcons.squareArrowOutUpRight,
                      size: 16,
                      color: AppColors.black,
                    ),
                  ],
                ),
                // subtitle: Text(
                //   "${routesToDisplay[i]["time"] ?? 'Unknown time'} · ${routesToDisplay[i]["price"] ?? 'Unknown price'}",
                // ),
                leading: Radio<int>(
                  value: routesToDisplay.length + 1,
                  groupValue: selected,
                  onChanged: (int? value) {
                    setState(() {
                      selected = value!;
                      currentChoice =
                          "Google Maps"; // Update current choice to Google Maps
                      widget.pastChoice = currentChoice;
                    });
                  },
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   
                    Expanded(
                      child: TextFormField(
                        showCursor: true,
                        decoration: const InputDecoration(
                          hintText: 'Add Note..',
                          border: OutlineInputBorder(
                            // borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.all(8),
                        ),
                      ),
                    ),
                  ],
                ),
               
                leading: Radio<int>(
                  value: routesToDisplay.length + 2,
                  groupValue: selected,
                  onChanged: (int? value) {
                    setState(() {
                      selected = value!;
                      currentChoice =
                          "Add Note"; // Update current choice to Google Maps
                      widget.pastChoice = currentChoice;
                    });
                  },
                ),
              ),

              const Divider(
                height: 3,
                color: AppColors.gray,
                indent: 25,
                endIndent: 25,
              ),

              //self-created route
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "         Create your own route",
                    type: TextType.body,
                    textSize: 14,
                    color: AppColors.black,
                  ),
                  IconButton(
                    onPressed: () {
                      _openCreateTransportModal();
                    },
                    icon: Icon(
                      LucideIcons.chevronRight,
                      color: AppColors.black,
                      size: 16,
                    ),
                  ),
                ],
              ),

              //FIXME: wrap by expanded to avoid overflow
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
              //   child: TextField(
              //     decoration: InputDecoration(
              //       prefixIcon: Icon(
              //         LucideIcons.notepadText,
              //         color: AppColors.darkGray,
              //         size: 16,
              //       ),
              //       prefixIconConstraints: BoxConstraints(
              //         minWidth: 30,
              //         minHeight: 30,
              //       ),

              //       hintText: "Add note",
              //       filled: true,
              //       fillColor: AppColors.lightGray,
              //       isDense: true,
              //       contentPadding: EdgeInsets.symmetric(
              //         vertical: 5,
              //         horizontal: 8,
              //       ),

              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(8),
              //         borderSide: BorderSide.none,
              //       ),
              //     ),
              //     style: TextStyle(color: AppColors.black, fontSize: 12),
              //   ),
              // ),
              //note
            ],
          ),
        ),
      ),
    );
  }
}
