import 'package:flutter/material.dart';

class TripTag extends StatefulWidget {
  final String tagId;
  final String tagName;
  final Function(String)? onClick;
  bool? isSelected;
  
  TripTag({
    super.key,
    required this.tagId,
    required this.tagName,
    this.isSelected = false,
    this.onClick
  });

  @override
  State<TripTag> createState() => TripTagState();
}

class TripTagState extends State<TripTag> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isSelected = !widget.isSelected!;
        });
        if (widget.onClick != null)
          widget.onClick!(widget.tagId); // Pass an integer or any other value as needed
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
          color: widget.isSelected! ? Colors.orange : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: widget.isSelected! ? Colors.orange : Colors.grey,
            width: 1,
          ),
        ),
        child: IntrinsicWidth(
          child: Row(
            children: [
              Text(
                widget.tagName,
                style: TextStyle(
                  color: widget.isSelected! ? Colors.white : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 5),
            ],
          ),
        ),
      ),
    );
  }
}
