
import 'package:flutter/material.dart'; 

class TripTag extends StatelessWidget {
  final String tag;

  const TripTag({
    super.key,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: IntrinsicWidth( 
        child: Row(
          children: [
            Text(tag),
            const SizedBox(width: 5),
          ]
      ),
      )
    );
  }
}