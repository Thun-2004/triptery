import 'package:flutter/material.dart'; 

class CustomIcon extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final double? size;

  const CustomIcon({
    super.key,
    required this.icon,
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: color ?? Theme.of(context).iconTheme.color,
      size: size ?? Theme.of(context).iconTheme.size,
    );
  }
}