import 'package:flutter/material.dart';

class ProfileTabButtons extends StatelessWidget {
  final String selectedTab;
  final Function(String) onTabSelected;
  final VoidCallback onEditProfile;

  const ProfileTabButtons({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
    required this.onEditProfile,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = ['About me', 'Trip plans', 'Bookmark'];

    return Column(
      children: [
        // Edit Profile Button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: OutlinedButton(
            onPressed: onEditProfile,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.deepOrange,
              side: const BorderSide(color: Colors.deepOrange),
              minimumSize: const Size(double.infinity, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text('Edit Profile'),
          ),
        ),

        // Tab buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: tabs.map((tab) {
            final isSelected = selectedTab == tab;
            return GestureDetector(
              onTap: () => onTabSelected(tab),
              child: Column(
                children: [
                  Text(
                    tab,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.deepOrange : Colors.grey[700],
                    ),
                  ),
                  if (isSelected)
                    const SizedBox(height: 4),
                  if (isSelected)
                    Container(
                      width: 40,
                      height: 2,
                      color: Colors.deepOrange,
                    ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
