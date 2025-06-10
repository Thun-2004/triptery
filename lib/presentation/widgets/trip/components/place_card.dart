import 'package:flutter/material.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class PlaceCard extends StatefulWidget {
  const PlaceCard({
    super.key,
    required this.index,
    required this.placeId,
    required this.placeName,
    required this.placeDescription,
    required this.placeImage,
    required this.arrivalTime,
    this.addDeletedItem,
    this.isEdit,
  });

  final int index;
  final String placeId;
  final String placeName;
  final String placeDescription;
  final String placeImage;
  final String arrivalTime;
  final Function(int)? addDeletedItem;
  final bool? isEdit;

  @override
  State<PlaceCard> createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  bool isActivityExpanded = false;
  bool isChecked = false; 
  List<String> itemsToShow = [
    "Not Ping pong show",
    "Martini at the bar",
    "Try street food",
    "Visit the night market",
  ];

  @override
  Widget build(BuildContext context) {
    // final showMap = context.watch<TripState>().showMap;

    return Card(
      // margin: const EdgeInsets.all(20),
      elevation: 0,
      margin: EdgeInsets.symmetric(vertical: 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(widget.placeImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  // Wrap in Expanded to prevent overflow
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomText(
                                text: widget.placeName,
                                textSize: 13,
                                type: TextType.subHeading,
                                color: AppColors.black,
                              ),
                              
                              if (widget.isEdit == true) //NOTE : check if isEdit is true
                                Checkbox(
                                  isError: true,
                                  tristate: true,
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value ?? false;
                                      if(widget.addDeletedItem != null){
                                        widget.addDeletedItem!(widget.index);
                                      }
                                    });
                                   
                                  },
                                ),
                            ],
                          ),

                          // if (isEdit)
                          //   Container(
                          //     decoration: BoxDecoration(
                          //       color: Colors.red,
                          //       shape: BoxShape.circle,
                          //     ),
                          //     child: IconButton(
                          //       icon: Icon(Icons.remove, color: Colors.white),
                          //       padding: EdgeInsets.all(0),
                          //       constraints: BoxConstraints(
                          //         minWidth: 24,
                          //         minHeight: 24,
                          //       ),
                          //       iconSize: 18,
                          //       onPressed: onClick,
                          //     ),
                          //   ),
                        ],
                      ),

                      const SizedBox(height: 3),
                      // Tag(
                      //   text: "hotel",
                      //   textSize: 10,
                      //   textColor: AppColors.black,
                      //   tagColor: AppColors.gray,
                      //   height: 18,
                        
                      // ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Row(
                            children: [
                              Icon(LucideIcons.clockFading, size: 16),
                              const SizedBox(width: 3),
                              CustomText(
                                text: "2 hours",
                                textSize: 12,
                                type: TextType.body,
                                color: AppColors.black,
                              ),
                            ],
                          ),
                          const SizedBox(width: 5),
                          Row(
                            children: [
                              Icon(LucideIcons.circleDollarSign, size: 16),
                              const SizedBox(width: 3),
                              CustomText(
                                text: "2,000 Baht",
                                textSize: 12,
                                type: TextType.body,
                                color: AppColors.black,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                // const SizedBox(height: 3),
                Row(
                  children: [
                    CustomText(
                      text: "Don't Miss",
                      textSize: 13,
                      type: TextType.subHeading,
                      color: AppColors.black,
                    ),
                    IconButton(
                      icon: Icon(
                        isActivityExpanded
                            ? LucideIcons.chevronDown
                            : LucideIcons.chevronUp,
                      ),
                      onPressed: () {
                        setState(() {
                          isActivityExpanded = !isActivityExpanded;
                        });
                      },
                     
                      style: IconButton.styleFrom(
                        padding: EdgeInsets.zero,
                        iconSize: 14,
                        foregroundColor: AppColors.black,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 24,
                        minHeight: 24,
                      ),
                      visualDensity: VisualDensity.compact, // ↓ tighter layout

                    ),
                  ],
                ),

                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut, 
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: isActivityExpanded ? List.generate((itemsToShow.length / 2).ceil(), (
                      i,
                    ) {
                      final left = itemsToShow[i * 2];
                      final right =
                          (i * 2 + 1 < itemsToShow.length)
                              ? itemsToShow[i * 2 + 1]
                              : null;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "• $left",
                            style: const TextStyle(fontSize: 12),
                          ),

                          if (right != null) 
                            Text(
                              "• $right",
                              style: const TextStyle(fontSize: 12),
                            )
                          else 
                            const SizedBox(width: 20),
                          const SizedBox(width: 20),
                        ],
                      );
                    }) 
                    : [
                      if (itemsToShow.isEmpty) 
                        const SizedBox.shrink() 
                      else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "• ${itemsToShow[0]}",
                              style: const TextStyle(fontSize: 12),
                            ),
                            if (itemsToShow[1] != null) 
                              Text(
                                "• ${itemsToShow[1]}",
                                style: const TextStyle(fontSize: 12),
                              )
                            else 
                              const SizedBox(width: 20),
                            const SizedBox(width: 20),
                          ]
                        )
                    ],
                  ) 
                ), 
                const SizedBox(height: 3),
              ],
            ),
            const SizedBox(height: 5),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  LucideIcons.notepadText,
                  color: AppColors.darkGray,
                  size: 16,
                ),
                prefixIconConstraints: BoxConstraints(
                  minWidth: 30,
                  minHeight: 30,
                ),

                hintText: "Add note",
                filled: true,
                fillColor: AppColors.lightGray,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 8,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: AppColors.black, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
