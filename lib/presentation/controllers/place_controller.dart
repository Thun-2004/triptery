import 'package:triptery/data/mock/mock_places.dart';
import 'package:triptery/domain/entities/place/place.dart';
import 'package:get/get.dart';
import 'dart:developer';

class PlaceController extends GetxController {
  RxList<Place> selectedPlaces = <Place>[].obs;
  RxList<Place> recommendedPlaces = <Place>[].obs;
  RxList<Place> bookmarkedPlaces = <Place>[].obs;
  RxList<Place> allPlaces = mockPlaces.obs;

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
}
