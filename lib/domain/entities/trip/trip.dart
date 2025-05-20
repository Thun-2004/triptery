enum TripType { route, dest }
enum RouteMode { car, motorcycle, publicTransit, unselected }

class Trip {
  final String id;
  final String planId;
  final int day;
  final TripType type;

  final String? placeId;
  final String? placeName;
  final String? placeDescription;
  final String? placeImageUrl;
  final String? arrivalTime;

  final RouteMode? routeMode;
  final String? routeFrom; 
  final String? routeTo; 
  final int? routeTotalTime;
  final int? routeTotalCost;
  final int? routeTotalDistance;
  final String? routeDistance;
  final String? routeNote;

  final String? note;

  Trip({
    required this.id,
    required this.planId,
    required this.day,
    required this.type,
    this.placeId,
    this.placeName,
    this.placeDescription,
    this.placeImageUrl,
    this.arrivalTime,
    this.routeMode,
    this.routeFrom, 
    this.routeTo, 
    this.routeTotalTime,
    this.routeTotalCost,
    this.routeTotalDistance,
    this.routeDistance,
    this.routeNote,
    this.note,
  });
}
