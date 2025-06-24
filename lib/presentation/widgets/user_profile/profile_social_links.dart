import 'package:flutter/material.dart';

class ProfileSocialLinks extends StatelessWidget {
  const ProfileSocialLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          _SocialLinkRow(
            icon: Icons.camera_alt,
            label: 'salmonjuseyo',
            platform: 'Instagram',
          ),
          const SizedBox(height: 8),
          _SocialLinkRow(
            icon: Icons.facebook,
            label: 'salmonjuseyo',
            platform: 'Facebook',
          ),
        ],
      ),
    );
  }
}

class _SocialLinkRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String platform;
  const _SocialLinkRow({
    required this.icon,
    required this.label,
    required this.platform,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
