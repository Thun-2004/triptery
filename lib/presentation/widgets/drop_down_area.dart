import 'package:flutter/material.dart';


// two param : head and body
class DropDownArea extends StatefulWidget {
  final Widget header; 
  final Widget body; 

  const DropDownArea({
    super.key, 
    required this.header,
    required this.body,
  });

  @override
  State<DropDownArea> createState() => _DropDownAreaState();
}

class _DropDownAreaState extends State<DropDownArea> {
  static const Duration duration = Duration(milliseconds: 300);
  static const Curve curve = Curves.easeIn;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Card(
        margin: const EdgeInsets.all(16),
        child: Center(
          child: AnimatedSizeExample(
            duration: duration, 
            curve: curve,
            header: widget.header,
            body: widget.body,
          ),
        ),
      ),
    );
  }
}

class AnimatedSizeExample extends StatefulWidget {
  const AnimatedSizeExample({
    required this.duration,
    required this.curve,
    required this.header,
    required this.body,
    super.key,
  });

  final Duration duration;
  final Curve curve;
  final Widget header;
  final Widget body;

  @override
  State<AnimatedSizeExample> createState() => _AnimatedSizeExampleState();
}

class _AnimatedSizeExampleState extends State<AnimatedSizeExample> {
  bool _isSelected = false;
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: Container(
        width: double.infinity, // Ensure the container takes full width
        padding: const EdgeInsets.all(16),
        child: AnimatedSize(
          duration: widget.duration,
          curve: widget.curve,
          child: AnimatedContainer(
            // height: _isSelected ? 250.0 : 100,
            duration: widget.duration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                widget.header,

                _isSelected
                    ? Expanded( 
                    child: widget.body) : Container()
              ]
            ),
          ),
        ),
      ),
    );
  }
}

