import 'package:flutter/material.dart';
import '../../../domain/repositories/place_repository_impl.dart'; // adjust the import path as needed
import '../../../domain/entities/place/place.dart';

class CustomSearchBar extends StatelessWidget {
  final PlaceRepositoryImpl repository;

  const CustomSearchBar({
    super.key,
    required this.repository,
  });

  Future<void> _handleSearch(String input, BuildContext context) async {
    if (input.trim().isEmpty) return;

    final messenger = ScaffoldMessenger.of(context);

    try {
      final Place place = await repository.fetchAndCachePlaceFromGoogle(input);
      messenger.showSnackBar(
        SnackBar(content: Text('✅ ${place.name} saved to Supabase!')),
      );
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('❌ Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        onSubmitted: (value) => _handleSearch(value, context),
        decoration: const InputDecoration(
          hintText: 'Enter destination (Country, Region, City)',
          prefixIcon: Icon(Icons.location_on_outlined, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}
