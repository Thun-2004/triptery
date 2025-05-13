
class Badges {
  final String id;
  final String name;
  final String description;
  final String logoUrl;
  final DateTime createdAt;
  final String createdBy;
  final bool deleted;
  final DateTime? deletedAt;
  final String? deletedBy;

  Badges({
    required this.id,
    required this.name,
    required this.description,
    required this.logoUrl,
    required this.createdAt,
    required this.createdBy,
    required this.deleted,
    this.deletedAt,
    this.deletedBy,
  });

}