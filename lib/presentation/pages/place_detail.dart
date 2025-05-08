import 'package:flutter/material.dart';
import '../../domain/entities/place.dart';

class PlaceDetailPage extends StatelessWidget {
  final Place place;

  const PlaceDetailPage({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              // Background image
              Image.network(
                place.imageUrl ?? '',
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              // Back button
              Positioned(
                top: 40,
                left: 16,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              // Place name and info
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
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber[700], size: 20),
                    const SizedBox(width: 4),
                    Text('${place.rating}', style: const TextStyle(fontSize: 14)),
                    const SizedBox(width: 8),
                    Text('(${place.totalUserRatings} Reviews)', style: const TextStyle(fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  place.description,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Review',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                ListTile(
                  leading: Image.network('https://upload.wikimedia.org/wikipedia/commons/5/56/Tripadvisor_Icon.svg', width: 30),
                  title: const Text('Tripadvisor'),
                  trailing: const Text('12 Reviews'),
                ),
                ListTile(
                  leading: Image.network('https://upload.wikimedia.org/wikipedia/commons/5/5e/Pantip_Logo.png', width: 30),
                  title: const Text('Pantip'),
                  trailing: const Text('50 Reviews'),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Facebook',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('https://via.placeholder.com/100'),
                  ),
                  title: const Text('PALAPILII THAILAND'),
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('https://via.placeholder.com/100'),
                  ),
                  title: const Text('THE WALKING BACKPACK'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
