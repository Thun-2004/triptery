class Playlist {
  final String id;
  final String playlistName;
  final String coverImageUrl;
  final String ownerId;
  final DateTime createdAt;
  final String visibility;

  Playlist({
    required this.id,
    required this.playlistName,
    required this.coverImageUrl,
    required this.ownerId,
    required this.createdAt,
    required this.visibility,
  });
}