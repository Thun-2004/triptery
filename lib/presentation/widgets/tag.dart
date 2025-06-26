import 'package:flutter/material.dart';
import 'package:triptery/constant/colors.dart';

class Tag extends StatelessWidget {
  final String text;
  final int textSize;
  final Color textColor;
  final Color tagColor;
  final int height;
  final int borderRadius;
  final int? width;
  final Color? borderColor;
  final IconData? icon;
  final Color iconColor;
  final Function? onTap;

  const Tag({
    super.key,
    required this.text,
    required this.textColor,
    required this.tagColor,
    required this.textSize,
    required this.height,
    this.width,
    this.borderRadius = 12,
    this.borderColor,
    this.icon,
    this.iconColor = AppColors.black,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null ? () => onTap!() : null,
      child: Container(
        width: width?.toDouble(),
        height: height.toDouble(),
        padding:
            (width != null && width! < 50)
                ? EdgeInsets.symmetric(horizontal: 0, vertical: 1)
                : const EdgeInsets.symmetric(horizontal: 8, vertical: 1),

        decoration: BoxDecoration(
          color: tagColor,
          borderRadius: BorderRadius.circular(borderRadius.toDouble()),
          border:
              borderColor != null
                  ? Border.all(color: borderColor!, width: 1)
                  : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(icon, color: iconColor, size: textSize.toDouble()),
            const SizedBox(width: 2),
            Text(
              text,
              style: TextStyle(color: textColor, fontSize: textSize.toDouble()),
            ),
          ],
        ),
      ),
    );
  }
}
