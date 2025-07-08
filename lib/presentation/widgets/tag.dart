import 'package:flutter/material.dart';
import 'package:triptery/constant/colors.dart';
import 'package:triptery/constant/transport_modes.dart';

class Tag extends StatelessWidget {
  final String text;
  final int textSize;
  final Color textColor;
  final Color tagColor;
  final int height;
  final int borderRadius;
  final int? width;
  final Color? borderColor;
  final TransportMode? transportMode;
  final IconData? icon;
  final Color iconColor;
  final Function? onTap;

  const Tag({
    super.key,
    required this.text,
    required this.textColor,
    this.tagColor = AppColors.orange_950,
    required this.textSize,
    this.height = 10,
    this.width,
    this.borderRadius = 12,
    this.borderColor,
    this.transportMode,
    this.icon,
    this.iconColor = AppColors.black,
    this.onTap,
  });

  Color getTransportModeName(TransportMode mode) {
    switch (mode) {
      case TransportMode.bus:
        return AppColors.darkBlue;
      case TransportMode.train:
        return AppColors.red;
      case TransportMode.car:
        return AppColors.orange_600;
      case TransportMode.carRent:
        return AppColors.orange_300;
      case TransportMode.taxi:
        return AppColors.taxiyellow;
      case TransportMode.skyTrain:
        return AppColors.btsgreen;
      case TransportMode.subway:
        return AppColors.mrtBlue;
      case TransportMode.boat:
        return AppColors.red;
      case TransportMode.airplane:
        return AppColors.planeblue;
      case TransportMode.walk:
        return AppColors.orange_900;
      default:
        return AppColors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null ? () => onTap!() : null,
      child: Container(
        // width: width?.toDouble(),
        // height: height.toDouble() ?? 0,
        padding:
            (width != null && width! < 50)
                ? EdgeInsets.symmetric(horizontal: 0, vertical: 1)
                : const EdgeInsets.symmetric(horizontal: 2, vertical: 1),

        decoration: BoxDecoration(
          color:
              transportMode != null
                  ? getTransportModeName(transportMode!)
                  : tagColor,
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
