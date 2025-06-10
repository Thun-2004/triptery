class Route {
  final String id;
  final int totalTime;
  final int totalCost;
  final int totalDistance;
  final String routeMode;        // Enum: 'car', 'motorcycle', 'public transit'
  final String fromPlaceId;      // FK
  final String toPlaceId;        // FK
  final String suggestBy;        // Enum: 'Google', 'Tripadvisor', 'Local'
  final String description;
  final String note;
  final DateTime createdAt;

  Route({
    required this.id,
    required this.totalTime,
    required this.totalCost,
    required this.totalDistance,
    required this.routeMode,
    required this.fromPlaceId,
    required this.toPlaceId,
    required this.suggestBy,
    required this.description,
    required this.note,
    required this.createdAt,
  });
}