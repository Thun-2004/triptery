import 'package:flutter/material.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/presentation/pages/trip/trip_summary_sheet.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';
import 'package:triptery/presentation/widgets/tag.dart';

class HeaderSection extends StatefulWidget {
  final VoidCallback toggleMap;

  HeaderSection({
    super.key, 
    required this.toggleMap
  });

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {

  void _openBottomModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TripSummaryWindow(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      decoration: BoxDecoration(
        color: AppColors.grayBg,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                color: AppColors.white,
                image: DecorationImage(
                  image: NetworkImage(
                    'https://i.pinimg.com/736x/09/cc/81/09cc8103a174d70e7b7cdb96d4bc30d2.jpg', // Replace with your image path
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Gradient overlay
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.7),
                    AppColors.grayBg.withOpacity(1),
                  ],
                  stops: const [0.5, 0.6, 0.7, 1.0],
                ),
              ),
            )
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding (
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back, color: AppColors.white),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          LucideIcons.pencil,
                          color: AppColors.white,
                        ),
                        onPressed: () {
                          // widget.tripController.toggleEditTripInfo();
                          _openBottomModal();
                        },
                      ),

                      SizedBox(width: 8),
                      IconButton(
                        icon: Icon(LucideIcons.map), 
                        color: AppColors.black,
                        onPressed: widget.toggleMap
                      ),
                      SizedBox(width: 8),
                      Icon(
                        LucideIcons.ellipsisVertical,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                ],
              )
              ), 
              
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomText(
                              text: 'Chilling Beach at Samui',
                              type: TextType.heading,
                              color: AppColors.black,
                            ),

                            const SizedBox(height:2),

                            Row(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      LucideIcons.calendar,
                                      size: 16,
                                      color: AppColors.black,
                                    ),
                                    const SizedBox(width: 4),
                                    CustomText(
                                      text: '4 days',
                                      type: TextType.body,
                                      color: AppColors.black,
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 8),
                                Row(
                                  children: [
                                    Icon(
                                      LucideIcons.mapPin,
                                      size: 16,
                                      color: AppColors.black,
                                    ),
                                    CustomText(
                                      text: 'Ko Samui, Surat',
                                      type: TextType.body,
                                      color: AppColors.black,
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height:3),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Tag(
                                      text: '5.0 (986)',
                                      textSize: 12,
                                      textColor: AppColors.black,
                                      tagColor: AppColors.white,
                                      height: 22,
                                      borderRadius: 4, 
                                      borderColor: AppColors.gray,
                                      icon: LucideIcons.star, 
                                      iconColor: AppColors.black,
                                    ),
                                    const SizedBox(width: 5),
                                    Tag(
                                      text: '1.2k',
                                      textSize: 12,
                                      textColor: AppColors.black,
                                      tagColor: AppColors.white,
                                      height: 22,
                                      borderRadius: 4, 
                                      borderColor: AppColors.gray,
                                      icon: LucideIcons.eye, 
                                      iconColor: AppColors.black,
                                    ),
                                    const SizedBox(width: 5),
                                    Tag(
                                      text: '300',
                                      textSize: 12,
                                      textColor: AppColors.black,
                                      tagColor: AppColors.white,
                                      height: 22,
                                      borderRadius: 4, 
                                      borderColor: AppColors.gray,
                                      icon: LucideIcons.clipboardList, 
                                      iconColor: AppColors.black,
                                    ),
 
                                    const SizedBox(width: 8),
                                  ],
                                ),

                                CustomText(
                                  text: 'Salmon',
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
                  
                  const SizedBox(height: 5),

                ],
              ),
            ],
          ),
          
        ],
      ),
    );
  }
}
