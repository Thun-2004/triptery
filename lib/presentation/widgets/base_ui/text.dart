import 'package:flutter/material.dart';

enum TextType{
  heading, 
  subHeading, 
  body, 
  caption,
}

class CustomText extends StatelessWidget {
  final String text;
  final int? textSize; 
  final Color color;
  final TextType type;
  final overflow = TextOverflow.ellipsis;
  final int? maxLines;
  
  const CustomText({
    super.key,
    required this.text,
    this.textSize,
    required this.type, 
    required this.color,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: textSize?.toDouble() ?? ( 
        type  == TextType.heading ? 18 : 
        type == TextType.subHeading ? 16 : 
        type == TextType.body ? 14 : 12 ),

        fontWeight: type == TextType.heading ? FontWeight.bold : 
        type == TextType.subHeading ? FontWeight.bold : 
        type == TextType.body ? FontWeight.normal : FontWeight.normal,

        color: color,
      ), 
      overflow: overflow, 
      maxLines: maxLines ?? 2, // Default to 1 line if not specified
    ); 
  }
}