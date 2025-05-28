import 'package:flutter/material.dart';
import 'dart:developer';
import '../../domain/repositories/place_repository_impl.dart';
import '../../domain/entities/place/place.dart';
import '../widgets/home_page/search_bar.dart';
import '../widgets/destination_card.dart';

class SearchPage extends StatefulWidget {
  final PlaceRepositoryImpl repository;
  final String? initialQuery;

  const SearchPage({super.key, required this.repository, this.initialQuery});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Place> searchResults = [];
  bool isLoading = false;
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
      setState(() {
        searchResults = [];
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // First, try to search in Supabase
      final results = await widget.repository.searchPlaces(input);
      if (results.isNotEmpty) {
        log('✅ Found "$input" in Supabase, displaying results.');
        setState(() {
          searchResults = results;
          isLoading = false;
        });
      } else {
        log('❌ Not found in Supabase, fetching from Google: "$input"');
        // If no results in Supabase, fetch from Google and save
        try {
          final place = await widget.repository.fetchAndCachePlaceFromGoogle(
            input,
          );
          log('🌍 Displaying Google result for "$input"');
          setState(() {
            searchResults = [place];
            isLoading = false;
          });
        } catch (e) {
          if (mounted) {
            log('🚨 Error fetching from Google for "$input": $e');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('❌ Error fetching from Google: $e')),
            );
          }
          setState(() {
            searchResults = [];
            isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        log('🚨 Error searching in Supabase for "$input": $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ Error searching in Supabase: $e')),
        );
      }
      setState(() {
        searchResults = [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Destinations'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomSearchBar(
              repository: widget.repository,
              onSearch: _handleSearch,
            ),
          ),
          Expanded(
            child:
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : searchResults.isEmpty
                    ? const Center(
                      child: Text(
                        'Search for destinations...',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                    : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: DestinationCard(place: searchResults[index]),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
