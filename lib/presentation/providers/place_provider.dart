
import 'package:flutter/material.dart';
import 'package:triptery/data/mock/mock_places.dart';
import 'package:triptery/domain/entities/place/place.dart';
import 'dart:developer';

class PlaceProvider with ChangeNotifier{

  List<Place> selectedPlaces = [];
  List<Place> recommendedPlaces = [];
  List<Place> bookmarkedPlaces = [];
  List<Place> allPlaces = mockPlaces;

  void init(){
    if (recommendedPlaces.isEmpty && allPlaces.isNotEmpty) {
      recommendedPlaces =
          allPlaces.where((place) => int.parse(place.id) < 8).toList();
    }
    if (allPlaces.isNotEmpty) {
      bookmarkedPlaces =
          allPlaces.where((place) => int.parse(place.id) > 7).toList();
    }
    notifyListeners();
  }

  void addPlace(int placeId) {
    selectedPlaces.add(
      allPlaces.firstWhere((place) => int.parse(place.id) == placeId),
    );
    notifyListeners();
  }

  void removePlace(int placeId) {
    selectedPlaces.removeWhere((place) => place.id == placeId.toString()); 
    notifyListeners();
  }
}