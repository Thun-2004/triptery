
class AdminProfiles {
  final String adminId;
  final String name;
  final String role;
  final bool verified;
  final String profilePictureUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String updatedBy;
  final String deleted;
  final DateTime? deletedAt;
  final String? deletedBy;

  AdminProfiles({
    required this.adminId,
    required this.name,
    required this.role,
    required this.verified,
    required this.profilePictureUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.updatedBy,
    required this.deleted,
    this.deletedAt,
    this.deletedBy,
  });
}