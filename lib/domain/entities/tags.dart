class Tag {
  final String tagId;            // Primary Key
  final String name;
  final DateTime createdAt;
  final String createdBy;        // FK to user_id or admin_id
  final DateTime? updatedAt;
  final String? updatedBy;       // FK to admin_id
  final bool deleted;
  final DateTime? deletedAt;
  final String? deletedBy;       // FK to admin_id

  Tag({
    required this.tagId,
    required this.name,
    required this.createdAt,
    required this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.deleted = false,
    this.deletedAt,
    this.deletedBy,
  });
}