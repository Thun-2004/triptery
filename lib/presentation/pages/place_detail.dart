import 'package:flutter/material.dart';
import '../../domain/entities/place.dart';

class PlaceDetailPage extends StatelessWidget {
  final Place place;

  const PlaceDetailPage({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                      Text('${place.rating}', style: const TextStyle(fontSize: 14, fontFamily: 'Roboto')),
                      const SizedBox(width: 8),
                      Text('(${place.totalUserRatings} Reviews)', style: const TextStyle(fontSize: 14, fontFamily: 'Roboto')),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    place.description,
                    style: const TextStyle(fontSize: 14, height: 2, fontFamily: 'Roboto', color: Color(0xff848997)),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Review',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
                  ),
                  const Divider(),

                  // 🌐 Google Reviews section
                  Row(
                    children: [
                      Image.asset('assets/images/google_icon.png', width: 30),
                      const SizedBox(width: 8),
                      const Text(
                        'Google Reviews',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Render each review
                  ...place.reviews.map(
                    (review) => ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          review.profilePhotoUrl ?? 'https://via.placeholder.com/100',
                        ),
                      ),
                      title: Text(review.authorName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber[700], size: 16),
                              const SizedBox(width: 4),
                              Text('${review.rating}'),
                              const SizedBox(width: 6),
                              Text('• ${review.relativeTime}'),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(review.text),
                        ],
                      ),
                      isThreeLine: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
