class Trip {
  final int id;
  final String planId;               // FK
  final int day;
  final String type;                // Enum: 'route' or 'dest'
  final String placeId;             // FK
  final String placeName;
  final String placeDescription;
  final String placeImageUrl;
  final String arrivalTime;
  final String routeMode;           // Enum: 'car', 'motorcycle', 'public transit'
  final int routeTotalTime;
  final int routeTotalCost;
  final int routeTotalDistance;
  final String routeDistance;
  final String routeNote;
  final String note;

  Trip({
    required this.id,
    required this.planId,
    required this.day,
    required this.type,
    required this.placeId,
    required this.placeName,
    required this.placeDescription,
    required this.placeImageUrl,
    required this.arrivalTime,
    required this.routeMode,
    required this.routeTotalTime,
    required this.routeTotalCost,
    required this.routeTotalDistance,
    required this.routeDistance,
    required this.routeNote,
    required this.note,
  });
}