import 'package:flutter/material.dart';
import '../../../domain/entities/place/place_review_group.dart';

class PlaceReviewSection extends StatelessWidget {
  final List<PlaceReviewGroup> reviewGroups;

  const PlaceReviewSection({super.key, required this.reviewGroups});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: reviewGroups.map((group) {
        return ExpansionTile(
          tilePadding: EdgeInsets.zero,
          initiallyExpanded: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(group.sourceLogo, width: 24, height: 24),
                  const SizedBox(width: 8),
                  Text(
                    '${group.sourceName} Reviews',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text('${group.reviews.length} Reviews'),
            ],
          ),
          children: group.reviews.map((review) {
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  review.profilePhotoUrl ??
                      'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png',
                ),
              ),
              title: Text(review.authorName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, size: 14, color: Colors.amber[700]),
                      const SizedBox(width: 4),
                      Text('${review.rating}', style: const TextStyle(fontSize: 12)),
                      const SizedBox(width: 6),
                      Text(review.relativeTime, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(review.text),
                ],
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}
