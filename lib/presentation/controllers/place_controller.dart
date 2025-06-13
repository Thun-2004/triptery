import 'package:triptery/data/mock/mock_places.dart';
import 'package:triptery/data/mock/mock_trips.dart';
import 'package:triptery/domain/entities/place/place.dart';
import 'package:triptery/domain/entities/trip/trip.dart';
import 'package:get/get.dart';
import 'dart:developer';

//
class PlaceController extends GetxController {
  RxList<Place> selectedPlaces = <Place>[].obs;
  RxList<Place> recommendedPlaces = <Place>[].obs;
  RxList<Place> bookmarkedPlaces = <Place>[].obs;
  RxList<Place> allPlaces = mockPlaces.obs;
  RxList<Trip> allRoutes = mockTrips.obs;

  void init() {
    if (recommendedPlaces.isEmpty && allPlaces.isNotEmpty) {
      recommendedPlaces.value =
          allPlaces.where((place) => int.parse(place.id) < 8).toList();
      log("Recommended places initialized: ${recommendedPlaces.length}");
    }
    if (allPlaces.isNotEmpty) {
      bookmarkedPlaces.value =
          allPlaces.where((place) => int.parse(place.id) > 7).toList();
      log("Recommended places initialized: ${bookmarkedPlaces.length}");
    }
  }

  void addPlace(int placeId) {
    selectedPlaces.add(
      allPlaces.firstWhere((place) => int.parse(place.id) == placeId),
    );
  }

  void removePlace(int placeId) {
    selectedPlaces.removeWhere((place) => place.id == placeId.toString());
  }

  void clearSelectedPlaces() {
    selectedPlaces.clear();
  }

  void addPlaceToTripRoute(List<Place> selectedPlaces) {
    for(Place place in selectedPlaces) {
      Trip trip = Trip(
        id: (allRoutes.length + 1).toString(),
        planId: "1",
        day: 1,
        type: TripType.dest,
        placeId: place.id,
        placeName: place.name,
        placeDescription: place.description,
        placeImageUrl: place.imageUrl,
        arrivalTime: "10:00 AM",
        routeMode: null,
        routeTotalTime: null,
        routeTotalCost: null,
        routeTotalDistance: null,
        routeDistance: null,
        routeNote: null,
        note: "Added to trip",
      );
      Trip route = Trip(
        id: (allRoutes.length + 2).toString(),
        planId: "1",
        day: 1,
        type: TripType.route,
        placeId: null,
        placeName: null,
        placeDescription: null,
        placeImageUrl: null,
        arrivalTime: null,
        routeMode: RouteMode.unselected,
        routeFrom: "2", 
        routeTo: "3",
        routeTotalTime: 30,
        routeTotalCost: 20,
        routeTotalDistance: 30, 
        routeDistance: "30 km",
        routeNote: "train leaves at 11.20AM ",
        note: "Note for place 1",
      ); 

      allRoutes.add(trip);
    }
  }
}
