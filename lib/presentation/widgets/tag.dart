import 'package:flutter/material.dart'; 

class Tag extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color tagColor;


  const Tag({
    super.key,
    required this.text,
    required this.textColor,
    required this.tagColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      decoration: BoxDecoration(
        color: tagColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 10,
        ),
      ),
    );
  }
}