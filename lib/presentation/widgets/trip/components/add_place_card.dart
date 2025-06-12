import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';

class AddPlaceCard extends StatefulWidget {
  const AddPlaceCard({super.key});
  //index, toggleDelete

  @override
  AddPlaceCardState createState() => AddPlaceCardState();
}

class AddPlaceCardState extends State<AddPlaceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.gray,
        borderRadius: BorderRadius.circular(8),
        // boxShadow: [
        //   BoxShadow(
        //     color: AppColors.black,
        //     blurRadius: 4,
        //     offset: const Offset(0, 2),
        //   ),
        // ],
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: AppColors.orange_950,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              Container(
                width: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/pattaya.jpg',
                    ), // Replace with your image
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Positioned(
                top: 5,
                left: 5,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '1',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            //NOTE: take all available space
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // CustomText(
                  //   text: 'Samui Elephant Sanctuary',
                  //   type: TextType.subHeading,
                  //   color: AppColors.black,
                  // ),
                  Expanded(
                    child: Text(
                      'Samui Elephant Sanctuary',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: AppColors.orange_950,
                            size: 20,
                          ),
                          CustomText(
                            text: '200 m',
                            type: TextType.body,
                            color: AppColors.black,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          LucideIcons.circlePlus,
                          color: AppColors.orange_950,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
