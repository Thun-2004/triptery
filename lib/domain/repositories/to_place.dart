import '../entities/place/place.dart';

Place mapGoogleJsonToPlace(Map<String, dynamic> result, String generatedId) {
  String extractFromAddress(List components, String targetType, {bool useShort = false}) {
    final match = components.firstWhere(
      (c) => (c['types'] as List).contains(targetType),
      orElse: () => null,
    );
    if (match == null) return '';
    return useShort ? match['short_name'] : match['long_name'];
  }

  List<String>? weekdayText = result['opening_hours']?['weekday_text']?.cast<String>();

  return Place(
    id: generatedId,
    googlePlaceId: result['place_id'],
    name: result['name'],
    description: '',
    openingTime: weekdayText != null && weekdayText.isNotEmpty
        ? weekdayText.first.split(": ").last.split("–").first.trim()
        : '',
    closingTime: weekdayText != null && weekdayText.isNotEmpty
        ? weekdayText.first.split("–").last.trim()
        : '',
    latitude: result['geometry']['location']['lat'],
    longitude: result['geometry']['location']['lng'],
    rating: (result['rating'] ?? 0).toDouble(),
    totalUserRatings: result['user_ratings_total'] ?? 0,
    address: result['formatted_address'],
    city: extractFromAddress(result['address_components'], 'locality'),
    countryCode: extractFromAddress(result['address_components'], 'country', useShort: true),
    createdAt: DateTime.now(),
    createdBy: 'admin',
    updatedAt: DateTime.now(),
    updatedBy: 'admin',
    deleted: false,
    deletedAt: null,
    deletedBy: null,
    imageUrl: '', // Optional: handle photos here if needed
  );
}
