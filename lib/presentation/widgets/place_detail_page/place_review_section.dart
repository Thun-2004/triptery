import 'package:flutter/material.dart';
import '../../../domain/entities/place/place_review_group.dart';
import '../../../domain/entities/place/place_review.dart';
import '../../../domain/usecases/get_reviews_by_review_group_id.dart';
import '../../../domain/repositories/place_repository_impl.dart';

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

    final repo = PlaceRepositoryImpl();
    final reviews = await GetReviewsByReviewGroupId(repo).execute(groupId);

    setState(() {
      _reviewsByGroup[groupId] = reviews;
      _isLoading[groupId] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.reviewGroups.map((group) {
        final reviews = _reviewsByGroup[group.id] ?? [];
        final isLoading = _isLoading[group.id] ?? true;

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: [
              // 🔹 Logo
              Image.asset(group.companyLogo, width: 32, height: 32),
              const SizedBox(width: 12),

              // 🔸 Platform name
              Expanded(
                child: Text(
                  group.companyName,
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
              ),

              // ⭐ Rating & count & link icon
              if (isLoading)
                const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              else
                Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: Colors.orange),
                    const SizedBox(width: 4),
                    Text(
                      _calculateAverageRating(reviews).toStringAsFixed(1),
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '(${reviews.length})',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.open_in_new, size: 16, color: Colors.grey),
                  ],
                ),
            ],
          ),
        );
      }).toList(),
    );
  }

  double _calculateAverageRating(List<PlaceReview> reviews) {
    if (reviews.isEmpty) return 0;
    final total = reviews.fold<double>(0, (sum, r) => sum + r.rating);
    return total / reviews.length;
  }
}
