class FavouriteUsersPlaces {
  final String userId;     // Foreign Key
  final String placeId;    // Foreign Key
  final DateTime createdAt;

  FavouriteUsersPlaces({
    required this.userId,
    required this.placeId,
    required this.createdAt,
  });
}