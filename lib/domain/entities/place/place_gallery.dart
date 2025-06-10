class PlaceGallery {
  final String id;
  final String placeId;
  final String type;
  final String url;
  final int ordered;
  final DateTime createdAt;
  final String createdBy;
  final DateTime updatedAt;
  final String updatedBy;
  final bool deleted;
  final DateTime? deletedAt;
  final String? deletedBy;

  PlaceGallery({
    required this.id,
    required this.placeId,
    required this.type,
    required this.url,
    required this.ordered,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    required this.updatedBy,
    required this.deleted,
    this.deletedAt,
    this.deletedBy,
  });
}