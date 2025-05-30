import 'package:flutter/material.dart'; 

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: double.infinity,
      height: 550,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.linear,
      // padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        image : DecorationImage(
          image: AssetImage('assets/images/map.png'), // Replace with your map image
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          '',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}