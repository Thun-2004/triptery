
class Place {
  final String id;
  final String googlePlaceId;
  final String name;
  final String description;
  final String openingTime;
  final String closingTime;
  final double latitude;
  final double longitude;
  final double rating;
  final int totalUserRatings;
  final String address;
  final String city;
  final String countryCode;
  final DateTime createdAt;
  final String createdBy;
  final DateTime updatedAt;
  final String updatedBy;
  final bool deleted;
  final DateTime? deletedAt;
  final String? deletedBy;
  final String imageUrl;

  Place({
    required this.id,
    required this.googlePlaceId,
    required this.name,
    required this.description,
    required this.openingTime,
    required this.closingTime,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.totalUserRatings,
    required this.address,
    required this.city,
    required this.countryCode,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    required this.updatedBy,
    required this.deleted,
    this.deletedAt,
    this.deletedBy,
    required this.imageUrl,
  });
}
