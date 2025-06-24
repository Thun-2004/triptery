import 'package:flutter/material.dart';
import '../../../domain/repositories/place_repository_impl.dart';

class CustomSearchBar extends StatelessWidget {
  final PlaceRepositoryImpl repository;
  final Function(String) onSearch;

  const CustomSearchBar({
    super.key,
    required this.repository,
    required this.onSearch,
  });

  Future<void> _handleSearch(String input, BuildContext context) async {
    if (input.trim().isEmpty) return;
    onSearch(input);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        onSubmitted: (value) => _handleSearch(value, context),
        decoration: const InputDecoration(
          hintText: 'Where would you like to go?',
          prefixIcon: Icon(Icons.menu, color: Colors.grey),
          suffixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}
