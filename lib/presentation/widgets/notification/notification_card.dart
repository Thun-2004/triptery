import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class NotificationCard extends StatelessWidget {
  final String userName;
  final String userProfilePictureUrl;
  final String tripName;
  final String tripImageUrl;
  final DateTime createdAt;
  final String timeAgo;
  final String type;
  final bool seen;

  const NotificationCard({
    super.key,
    required this.userName,
    required this.userProfilePictureUrl,
    required this.tripName,
    required this.tripImageUrl,
    required this.createdAt,
    required this.timeAgo,
    required this.type,
    required this.seen,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> typeIcons = {
      'liked': Icons.favorite,
      'saved': Icons.bookmark,
      'review': Icons.star,
      'post': LucideIcons.pencil, // Correct Lucide icon
      'copy': LucideIcons.files, // Correct Lucide icon
      'share': LucideIcons.share, // Will flip this icon later
    };

    final Map<String, String> typeTexts = {
      'liked': 'just liked your trip.',
      'saved': 'saved your trip.',
      'review': 'reviewed your trip.',
      'follow': 'started following you.',
      'reminder': 'You’ve got a trip coming up.',
      'post': 'posted a trip.',
      'copy': 'copied your trip.',
      'share': 'shared your trip.',
    };

    final bool isFollowType = type == 'follow';
    final bool isReminderType = type == 'reminder';
    final bool hideIcon = isFollowType || isReminderType;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: seen ? Colors.white : const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar or Bell Icon (for reminder)
          Stack(
            children: [
              isReminderType
                  ? Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFF0E8),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.notifications,
                      color: Color(0xFFFF7043),
                    ),
                  )
                  : CircleAvatar(
                    backgroundImage: AssetImage(
                      userProfilePictureUrl.isNotEmpty
                          ? userProfilePictureUrl
                          : 'assets/images/salmonjuseyo.png',
                    ),
                    radius: 22,
                  ),
              if (!hideIcon)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      typeIcons[type] ?? Icons.notifications,
                      size: 14,
                      color: const Color(0xFFFF7043),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          // Notification text and details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                    children: [
                      if (type != 'reminder')
                        TextSpan(
                          text: userName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF6B3D),
                          ),
                        ),
                      TextSpan(
                        text:
                            type != 'reminder'
                                ? ' ${typeTexts[type] ?? ''}' // Add leading space only if userName exists
                                : typeTexts[type] ?? '',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 4),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        tripName,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    Text(
                      timeAgo,
                      style: const TextStyle(
                        color: Colors.black38,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Trip image or Follow back button
          isFollowType
              ? ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFE7D57),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Follow back',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              )
              : ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  tripImageUrl,
                  width: 54,
                  height: 44,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/salmonjuseyo.png',
                      width: 54,
                      height: 44,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
        ],
      ),
    );
  }
}
