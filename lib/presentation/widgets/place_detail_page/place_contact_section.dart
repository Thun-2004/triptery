import 'package:flutter/material.dart';

class PlaceContactSection extends StatelessWidget {
  const PlaceContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Contact",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _buildContactRow("Samui Elephant Sanctuary", Icons.link),
        _buildContactRow("Samui Elephant Sanctuary", Icons.facebook),
        _buildContactRow("samuelephantsanctuarythailand", Icons.email),
      ],
    );
  }

  Widget _buildContactRow(String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent, size: 20),
          const SizedBox(width: 10),
          Text(value),
        ],
      ),
    );
  }
}
