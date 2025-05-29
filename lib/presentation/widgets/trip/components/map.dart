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
      height: 200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      // padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
      ),
      child: const Center(
        child: Text(
          'Map Placeholder',
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ),
    );
  }
}