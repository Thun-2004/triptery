import 'package:flutter/material.dart';

class ProfileTripPlans extends StatelessWidget {
  const ProfileTripPlans({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder trip data
    final trips = [
      {
        'title': 'Our First Date',
        'location': 'Charoen Krung, Bangkok',
        'duration': '1 day',
        'people': 2,
        'price': 'asd',
        'image': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
      },
      {
        'title': 'Adventure Trip',
        'location': 'Phetchaburi, Thailand',
        'duration': '3 days 2 nights',
        'people': 2,
        'price': 'asd',
        'image': 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca',
      },
      {
        'title': 'Eat & Trip in Osaka',
        'location': 'Osaka, Japan',
        'duration': '3 days 2 nights',
        'people': 2,
        'price': 'asd',
        'image': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const Text(
            'My trip',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...trips.map((trip) => _TripCard(trip: trip)),
        ],
      ),
    );
  }
}

class _TripCard extends StatelessWidget {
  final Map<String, dynamic> trip;
  const _TripCard({required this.trip});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Trip image
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              trip['image'],
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),

          // Info & actions
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + more button
                // Title + more button
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        trip['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -4), // shift upward
                      child: PopupMenuButton<String>(
                        icon: const Icon(Icons.more_horiz, size: 20),
                        onSelected: (value) {
                          // TODO: handle actions like Edit, Delete
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Selected: $value')),
                          );
                        },
                        itemBuilder:
                            (context) => [
                              const PopupMenuItem(
                                value: 'edit',
                                child: Text('Edit'),
                              ),
                              const PopupMenuItem(
                                value: 'delete',
                                child: Text('Delete'),
                              ),
                            ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                // Location
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 16,
                      color: Colors.orange,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        trip['location'],
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Duration, people, price
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.orange,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      trip['duration'],
                      style: const TextStyle(fontSize: 13),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.person, size: 16, color: Colors.orange),
                    const SizedBox(width: 4),
                    Text(
                      '${trip['people']}',
                      style: const TextStyle(fontSize: 13),
                    ),
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.attach_money,
                      size: 16,
                      color: Colors.orange,
                    ),
                    const SizedBox(width: 2),
                    Text(trip['price'], style: const TextStyle(fontSize: 13)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
