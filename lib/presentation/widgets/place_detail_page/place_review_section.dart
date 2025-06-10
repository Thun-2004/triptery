import 'package:flutter/material.dart';
import '../../../domain/entities/place/place_review_group.dart';
import '../../../domain/entities/place/place_review.dart';
import '../../../domain/usecases/get_reviews_by_review_group_id.dart';
import '../../../domain/repositories/place_repository_impl.dart';
import '../../../utils/time_formatter.dart';

class PlaceReviewSection extends StatefulWidget {
  final List<PlaceReviewGroup> reviewGroups;

  const PlaceReviewSection({super.key, required this.reviewGroups});

  @override
  State<PlaceReviewSection> createState() => _PlaceReviewSectionState();
}

class _PlaceReviewSectionState extends State<PlaceReviewSection> {
  final Map<String, List<PlaceReview>> _reviewsByGroup = {};
  final Map<String, bool> _isLoading = {};

  @override
  void initState() {
    super.initState();
    for (final group in widget.reviewGroups) {
      _loadReviews(group.id);
    }
  }

  Future<void> _loadReviews(String groupId) async {
    setState(() {
      _isLoading[groupId] = true;
    });

    final repo = PlaceRepositoryImpl(); // or use a shared instance
    final reviews = await GetReviewsByReviewGroupId(repo).execute(groupId);

    setState(() {
      _reviewsByGroup[groupId] = reviews;
      _isLoading[groupId] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.reviewGroups.map((group) {
        final reviews = _reviewsByGroup[group.id] ?? [];
        final isLoading = _isLoading[group.id] ?? true;

        return ExpansionTile(
          tilePadding: EdgeInsets.zero,
          initiallyExpanded: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(group.companyLogo, width: 24, height: 24),
                  const SizedBox(width: 8),
                  Text(group.companyName, style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              isLoading
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text('${reviews.length} Reviews'),
            ],
          ),
          children: isLoading
              ? [const Padding(padding: EdgeInsets.all(16), child: Text('Loading...'))]
              : reviews.map((review) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        review.userProfilePictureUrl.isNotEmpty
                            ? review.userProfilePictureUrl
                            : 'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png',
                      ),
                    ),
                    title: Text(review.username),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, size: 14, color: Colors.amber[700]),
                            const SizedBox(width: 4),
                            Text('${review.rating}', style: const TextStyle(fontSize: 12)),
                            const SizedBox(width: 6),
                            Text(formatRelativeTime(review.createdAt),
                                style: const TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(review.description),
                      ],
                    ),
                  );
                }).toList(),
        );
      }).toList(),
    );
  }
}
