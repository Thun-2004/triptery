import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/domain/entities/place/place.dart';
import 'package:triptery/presentation/controllers/place_controller.dart';
import 'package:triptery/presentation/pages/place_detail.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';

class AddPlaceCard extends StatefulWidget {
  const AddPlaceCard({
    super.key,
    required this.placeId,
    required this.placeName,
    required this.placeImage,
  });

  final int placeId;
  final String placeName;
  final String placeImage;

  @override
  AddPlaceCardState createState() => AddPlaceCardState();
}

class AddPlaceCardState extends State<AddPlaceCard> {
  bool isAdded = false;
  final placeController = Get.find<PlaceController>();
  late int currentOrder;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      isAdded = placeController.selectedPlaces.any(
        (place) => int.parse(place.id) == widget.placeId,
      );

      currentOrder =
          placeController.selectedPlaces.indexWhere(
            (place) => int.parse(place.id) == widget.placeId,
          ) + 1;

      return GestureDetector(
        onTap: ((){
          Place place = placeController.allPlaces.firstWhere(
            (place) => int.parse(place.id) == widget.placeId,
          );
          
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => PlaceDetailPage(place: place) )
          );
        }), 
        child: Container(
          width: 300,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.lightGray,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(widget.placeImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  if (isAdded)
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
                          currentOrder.toString(),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // CustomText(
                      //   text: 'Samui Elephant Sanctuary',
                      //   type: TextType.subHeading,
                      //   color: AppColors.black,
                      // ),
                      Expanded(
                        child: Text(
                          widget.placeName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
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
                            onTap: () {
                              setState(() {
                                isAdded = !isAdded;
                                if (isAdded) {
                                  placeController.addPlace(widget.placeId);
                                } else {
                                  placeController.removePlace(widget.placeId);
                                }
                              });
                            },
                            child: Icon(
                              isAdded
                                  ? Icons.remove_circle
                                  : LucideIcons.circlePlus,
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
        ),
      );
    });
  }
}
