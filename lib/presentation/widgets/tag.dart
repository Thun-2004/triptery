import 'package:flutter/material.dart';
import 'package:triptery/constant/colors.dart'; 

class Tag extends StatelessWidget {
  final String text;
  final int textSize;
  final Color textColor;
  final Color tagColor;
  final int height;
  final int borderRadius;
  final Color? borderColor;
  final IconData? icon;
  final Color iconColor;
 
  const Tag({
    super.key,
    required this.text,
    required this.textColor,
    required this.tagColor,
    required this.textSize,
    required this.height,
    this.borderRadius = 12,
    this.borderColor,
    this.icon,
    this.iconColor = AppColors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.toDouble(),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      decoration: BoxDecoration(
        color: tagColor,
        borderRadius: BorderRadius.circular(borderRadius.toDouble()),
        border: borderColor != null 
          ? Border.all(color: borderColor!, width: 1) 
          : null,
      ),
      child: 
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children : [ 
            if (icon != null)
              Icon(
                icon,
                color: iconColor,
                size: textSize.toDouble(),
              ), 
            const SizedBox(width: 2),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: textSize.toDouble(),
              ),
            )
          ])
    );
  }
}