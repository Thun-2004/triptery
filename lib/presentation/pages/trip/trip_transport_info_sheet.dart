import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/presentation/widgets/base_ui/text.dart';

class TransportationInfoWindow extends StatefulWidget{
  
  @override
  TransportationInfoWindowState createState() => TransportationInfoWindowState();
}

class TransportationInfoWindowState extends State<TransportationInfoWindow> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 24),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(LucideIcons.minus, color: AppColors.black, size: 24), 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children : [
              Text(""),
              CustomText(
                text: 'Transport Details',
                type: TextType.heading,
                color: AppColors.black
              ),
              Icon(LucideIcons.x, color: AppColors.black, size: 20)
            ]
          ),
          
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children : [
              Icon(LucideIcons.carFront, color: AppColors.black, size: 24),
              Icon(LucideIcons.chevronRight, color: AppColors.black, size: 20),
              Icon(LucideIcons.busFront, color: AppColors.black, size: 24),
              CustomText(
                text: 'Elephant Tower',
                type: TextType.body,
                color: AppColors.black
              ), 
              Icon(LucideIcons.chevronRight, color: AppColors.black, size: 20),
              Icon(LucideIcons.trainFront, color: AppColors.black, size: 24),
              CustomText(
                text: 'MRT Huai Khwang',
                type: TextType.body,
                color: AppColors.black
              ), 
            ]
          )
          // Add your transportation info widgets here
        ],
      ),
    );
  }
}
