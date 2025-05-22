import 'package:flutter/material.dart';

enum TextType{
  heading, 
  subHeading, 
  body, 
  caption,
}

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final TextType type; 
  
  const CustomText({
    super.key,
    required this.text,
    required this.type, 
    required this.color, 
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: type == TextType.heading ? 21 : 
        type == TextType.subHeading ? 18 : 
        type == TextType.body ? 15 : 12,

        fontWeight: type == TextType.heading ? FontWeight.bold : 
        type == TextType.subHeading ? FontWeight.normal : 
        type == TextType.body ? FontWeight.normal : FontWeight.normal,

        color: color,
      )
    ); 
  }

}