import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    const double avatarRadius = 48;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 1. Header image (background)
        Image.asset(
          'assets/images/salmonjuseyo.png',
          width: double.infinity,
          height: 220,
          fit: BoxFit.cover,
        ),

        // 2. White rounded section that overlaps image
        Padding(
          padding: const EdgeInsets.only(top: 200), // overlaps nicely
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
            child: Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: const [
                  SizedBox(height: 32), // space for avatar
                  Text(
                    'Salmon Aroimak',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text('@salmonjuseyo', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 4),
                      Text('4.8 (283)', style: TextStyle(color: Colors.orange)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        // 3. Avatar (placed last = on top)
        // 3. Avatar with white background border
        Positioned(
          top: 152,
          left:
              MediaQuery.of(context).size.width / 2 -
              avatarRadius -
              4, // shift left to match increased size
          child: Container(
            width: (avatarRadius + 4) * 2,
            height: (avatarRadius + 4) * 2,
            decoration: const BoxDecoration(
              color: Colors.white, // white border
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(6), // optional: control inner padding
            child: const CircleAvatar(
              radius: 48,
              backgroundImage: AssetImage('assets/images/goldenspoon.png'),
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
