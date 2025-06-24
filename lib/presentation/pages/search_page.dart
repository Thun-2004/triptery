import 'package:flutter/material.dart';
import '../../domain/repositories/place_repository_impl.dart';
import '../widgets/home_page/search_bar.dart';

class SearchPage extends StatefulWidget {
  final PlaceRepositoryImpl repository;
  final String? initialQuery;

  const SearchPage({super.key, required this.repository, this.initialQuery});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialQuery != null) {
      _searchController.text = widget.initialQuery!;
      _handleSearch(widget.initialQuery!);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _handleSearch(String input) async {
    if (input.trim().isEmpty) {
      debugPrint('🔍 Empty search input.');
      return;
    }

    debugPrint('🔍 Searching for "$input"...');

    try {
      final results = await widget.repository.searchPlaces(input);

      if (results.isNotEmpty) {
        debugPrint('✅ Found ${results.length} result(s) from Supabase:');
        for (var place in results) {
          debugPrint('➡️ ${place.name}');
        }
      } else {
        debugPrint('❌ Not found in Supabase, trying Google API...');
        try {
          final place = await widget.repository.fetchAndCachePlaceFromGoogle(input);
          debugPrint('🌍 Google result: ${place.name}');
        } catch (e) {
          debugPrint('🚫 Error fetching from Google API: $e');
        }
      }
    } catch (e, stack) {
      debugPrint('💥 Error during search: $e\n$stack');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Debug Mode'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomSearchBar(
          repository: widget.repository,
          onSearch: _handleSearch,
        ),
      ),
    );
  }
}
