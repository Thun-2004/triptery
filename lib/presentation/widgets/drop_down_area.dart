import 'package:flutter/material.dart';


// two param : head and body
class DropDownArea extends StatefulWidget {
  final Widget header; 
  final Widget body; 
  final int elevation; 
  final int verticalMargin; 
  final int horizontalMargin; 
  final VoidCallback toggleExpand; 
  bool isExpanded; 

  DropDownArea({
    super.key, 
    required this.header,
    required this.body,
    required this.elevation,
    required this.toggleExpand,
    required this.isExpanded, 
    this.verticalMargin = 8,
    this.horizontalMargin = 8,
  });

  @override
  State<DropDownArea> createState() => _DropDownAreaState();
}

class _DropDownAreaState extends State<DropDownArea> {
  static const Duration duration = Duration(milliseconds: 300);
  static const Curve curve = Curves.easeIn;

  @override
  Widget build(BuildContext context) {
    return 
       Card(
        elevation: widget.elevation.toDouble(),
        margin: EdgeInsets.symmetric(horizontal: widget.horizontalMargin.toDouble(), vertical: widget.verticalMargin.toDouble()),
        // margin: const EdgeInsets.all(8),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min, 
          children : [
            InkWell(
              onTap: (){
                widget.toggleExpand();
              },
              child: widget.header,
            ), 
            AnimatedSize(
              duration: duration,
              curve: curve,
              child: widget.isExpanded ? widget.body : Container(), // Show body only when expanded
            )
          ]
        ),
      );
  }
}

