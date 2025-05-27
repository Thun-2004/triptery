
import 'package:flutter/material.dart'; 

class TripTag extends StatefulWidget {
  final String tag;

  TripTag({
    super.key,
    required this.tag,
  });

  @override
  State<TripTag> createState() => TripTagState();
}

class TripTagState extends State<TripTag> {
  bool isSelected = false;
  //need onClick fn 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            isSelected = !isSelected;
          }); 
          
        },
        child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? Colors.orange : Colors.grey, width: 1),
        ),
        child: IntrinsicWidth( 
          child: Row(
            children: [
              Text(widget.tag,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
              ),
              const SizedBox(width: 5),
            ]
        ),
        )
      )
    ); 
  }
}