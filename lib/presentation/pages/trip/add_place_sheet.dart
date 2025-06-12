import 'package:flutter/material.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';
import 'package:triptery/presentation/widgets/trip/components/add_place_card.dart';

class AddPlaceSheet extends StatefulWidget {
  const AddPlaceSheet({super.key});

  @override
  AddPlaceSheetState createState() => AddPlaceSheetState();
}

class AddPlaceSheetState extends State<AddPlaceSheet> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          // Header: not scrollable
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'Clear',
                  type: TextType.body,
                  color: Colors.black,
                ),
                CustomText(
                  text: 'Select a place',
                  type: TextType.heading,
                  color: Colors.black,
                ),
                CustomText(
                  text: 'Done',
                  type: TextType.body,
                  color: Colors.black,
                ),
              ],
            ),
          ),

          // Scrollable body
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBar(),
              const SizedBox(height: 20),
              //selected
              CustomText(
                text: '1 Selected',
                type: TextType.heading,
                color: Colors.black,
              ),
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [AddPlaceCard(), AddPlaceCard()],
                ),
              ),

              //recommended
              CustomText(
                text: 'Recommended places',
                type: TextType.heading,
                color: Colors.black,
              ),
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [AddPlaceCard(), AddPlaceCard()],
                ),
              ),

              //bookmarked
              CustomText(
                text: 'Bookmarked places',
                type: TextType.heading,
                color: Colors.black,
              ),
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [AddPlaceCard(), AddPlaceCard()],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
