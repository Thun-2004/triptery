import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:triptery/constant/colors.dart';
import 'package:dotted_border/dotted_border.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final int textSize;
  final Color? textColor;
  final Color? color;
  final double? width;
  final double? height;
  final Color? borderColor;
  final int? borderRadius;

  const AddButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.color,
    this.width = 100,
    this.height = 20,
    this.textSize = 16,
    this.textColor = AppColors.black,
    this.borderColor,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        dashPattern: [10, 5],
        strokeWidth: 1,
        radius: Radius.circular(borderRadius!.toDouble()),
        color: borderColor ?? textColor!,
      ),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            // color: color ?? AppColors.white,
            borderRadius: BorderRadius.circular(borderRadius!.toDouble()),
          ),
          width: width,
          height: height,
          child: Center(
            child: Text(
            text,
            style: TextStyle(
              fontSize: textSize.toDouble(),
              color: textColor ?? AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          )
          )
        ),
      ),
    );
  }
}
