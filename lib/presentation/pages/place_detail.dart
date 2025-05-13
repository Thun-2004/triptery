import 'package:flutter/material.dart';
import '../../domain/entities/place/place.dart';
import '../widgets/place_detail_page/place_review_section.dart';
import '../widgets/dash_divider.dart';

class PlaceDetailPage extends StatelessWidget {
  final Place place;

  const PlaceDetailPage({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔺 Top image with overlay
            Stack(
              children: [
                Image.network(
                  place.imageUrl ?? '',
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.5),
                        Colors.black.withOpacity(0.3),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${place.address}, ${place.city}',
                        style: const TextStyle(
                          color: Color(0xffffa000),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // 🔽 Scrollable content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber[700], size: 20),
                      const SizedBox(width: 4),
                      Text(
                        '${place.rating}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '(${place.totalUserRatings} Reviews)',
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    place.description,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 2,
                      fontFamily: 'Roboto',
                      color: Color(0xff848997),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Review',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),

                  const SizedBox(height: 16),
                  DashedDivider(),

                  // 🔄 Multiple review groups
                  PlaceReviewSection(reviewGroups: place.reviewGroups),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
