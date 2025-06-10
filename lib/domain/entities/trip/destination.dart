class Destination {
  final String id;
  final DateTime arrivalTime;
  final String routeId;         // FK
  final String placeId;         // FK
  final String placeDescription; // Type field (assumed String)

  Destination({
    required this.id,
    required this.arrivalTime,
    required this.routeId,
    required this.placeId,
    required this.placeDescription,
  });
}