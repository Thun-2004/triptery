
import 'package:triptery/domain/entities/trip/trip.dart';

class TripModel {
  final String id;
  final String planId;
  final int day;
  final TripType type;
  final String? placeId;
  final String? placeName;
  final String? placeDescription;
  final String? placeImageUrl;
  String? arrivalTime;
  final RouteMode? routeMode;
  final String? routeFrom; 
  final String? routeTo; 
  final int? routeTotalTime;
  final int? routeTotalCost;
  final int? routeTotalDistance;
  final String? routeDistance;
  final String? routeNote;

  final String? note; //NOTE: allow null

  TripModel({
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

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'],
      planId: json['planId'],
      day: json['day'],
      type: TripType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
        orElse: () => TripType.route,
      ),
      placeId: json['placeId'],
      placeName: json['placeName'],
      placeDescription: json['placeDescription'],
      placeImageUrl: json['placeImageUrl'],
      arrivalTime: json['arrivalTime'],
      routeMode: RouteMode.values.firstWhere(
        (e) => e.toString().split('.').last == json['routeMode'],
        orElse: () => RouteMode.unselected,
      ),
      routeFrom: json['routeFrom'],
      routeTo: json['routeTo'],
      routeTotalTime: json['routeTotalTime'],
      routeTotalCost: json['routeTotalCost'],
      routeTotalDistance: json['routeTotalDistance'],
      routeDistance: json['routeDistance'],
      routeNote: json['routeNote'],
      note: json['note'],
    );
  }

  Trip toEntity() {
    return Trip(
      id: id,
      planId: planId,
      day: day,
      type: type,
      placeId: placeId,
      placeName: placeName,
      placeDescription: placeDescription,
      placeImageUrl: placeImageUrl,
      arrivalTime: arrivalTime,
      routeMode: routeMode,
      routeFrom: routeFrom,
      routeTo: routeTo,
      routeTotalTime: routeTotalTime,
      routeTotalCost: routeTotalCost,
      routeTotalDistance: routeTotalDistance,
      routeDistance: routeDistance,
      routeNote: routeNote,
      note: note,
    );
  }
}
