import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/entities/place/place.dart';
import 'dart:developer';

Place mapJsonToPlace(Map<String, dynamic> json) {
  return Place(
    id: json['id'] as String? ?? '',
    googlePlaceId: json['google_place_id'] as String? ?? '',
    name: json['name'] as String? ?? '',
    description: json['description'] as String? ?? '',
    openingTime: json['opening_time'] as String? ?? '',
    closingTime: json['closing_time'] as String? ?? '',
    latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
    longtitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
    rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    totalUserRatings: json['total_user_ratings'] as int? ?? 0,
    address: json['address'] as String? ?? '',
    city: json['city'] as String? ?? '',
    countryCode: json['country_code'] as String? ?? '',
    createdAt:
        json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : DateTime.now(),
    createdBy: json['created_by'] as String? ?? '',
    updatedAt:
        json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : DateTime.now(),
    updatedBy: json['updated_by'] as String? ?? '',
    deleted: json['deleted'] as bool? ?? false,
    deletedAt:
        json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
    deletedBy: json['deleted_by'] as String?,
    imageUrl: json['image_url'] as String? ?? '',
  );
}

Future<List<Place>> searchPlacesService(String query) async {
  final supabase = Supabase.instance.client;
  final lowerQuery = query.toLowerCase();

  try {
    final response = await supabase
        .from('places')
        .select()
        .eq('deleted', false)
        .range(0, 9999); // Ensure we get enough data for search

    if (response.isEmpty) {
      log('📭 No Supabase data found');
      return [];
    }

    // Manual Ctrl+F-style filter by name
    final results = response
        .where((place) {
          final name = (place['name'] ?? '').toString().toLowerCase();
          return name.contains(lowerQuery);
        })
        .map(mapJsonToPlace)
        .toList();

    log('✅ Ctrl+F match count: ${results.length}');
    for (final r in results) {
      log('🔹 ${r.name}');
    }

    return results;
  } catch (e, stack) {
    log('🚨 Supabase fetch error: $e\n$stack');
    return [];
  }
}

