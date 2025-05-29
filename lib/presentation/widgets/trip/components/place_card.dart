import 'package:flutter/material.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';
import 'package:triptery/presentation/widgets/tag.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class PlaceCard extends StatelessWidget {
  PlaceCard({
    super.key,
    required this.placeId,
    required this.placeName,
    required this.placeDescription,
    required this.placeImage,
    required this.arrivalTime, 
    required this.onClick,
    required this.isEdit,
  });

  final String placeId;
  final String placeName;
  final String placeDescription;
  final String placeImage;
  String arrivalTime; // Assuming this is a string for simplicity
  final VoidCallback onClick;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
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
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
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
                      image: NetworkImage(placeImage),
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
                          CustomText(
                            text: placeName,
                            textSize: 13,
                            type: TextType.subHeading,
                            color: AppColors.black,
                          ),

                          if (isEdit)
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.remove, color: Colors.white),
                                padding: EdgeInsets.all(0),
                                constraints: BoxConstraints(
                                  minWidth: 24,
                                  minHeight: 24,
                                ),
                                iconSize: 18,
                                onPressed: onClick,
                              ),
                            ),
                        ],
                      ),

                      const SizedBox(height: 3),
                      Tag(
                        text: "hotel",
                        textSize: 10,
                        textColor: AppColors.black,
                        tagColor: AppColors.gray,
                        height: 18, 
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Icon(LucideIcons.clockFading, size: 16),
                          const SizedBox(width: 5),
                          CustomText(
                            text: "2 hours",
                            textSize: 12,
                            type: TextType.body,
                            color: AppColors.black,
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(LucideIcons.circleDollarSign, size: 16),
                          const SizedBox(width: 5),
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
                ),
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
