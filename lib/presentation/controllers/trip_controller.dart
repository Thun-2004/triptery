import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:triptery/data/mock/mock_places.dart';
import 'package:triptery/domain/entities/place/place.dart';
import 'package:triptery/domain/entities/trip/trip.dart';
import 'package:triptery/domain/usecases/trip/get_trips.dart';
import 'package:triptery/utils/datetime.dart';

//strategy = trip gradually add when day card is clicked
class TripController extends GetxController {
  final GetTripByDayId? getTripByDayId;
  final GetTripByPlanId? getTripByPlanId;
  var isLoading = true.obs;
  RxList<Trip?> trips = <Trip?>[].obs; //NOTE: can't initialize list with null

  final Rx<bool> _isEditingTripInfo = Rx<bool>(false);
  bool get isEditingTripInfo => _isEditingTripInfo.value;

  final Rx<bool> _isEditingPlaceOrder = Rx<bool>(false);
  Rx<bool> get isEditingPlaceOrderObs => _isEditingPlaceOrder;

  // int day = 0;
  Rx<int> day = 0.obs; // Reactive day variable

  RxList<Trip> places = <Trip>[].obs;
  List<Trip> get getPlaces =>
      places.whereType<Trip>().toList(); // Getter for places

  RxList<Trip> routes = <Trip>[].obs;
  List<Trip> get getRoutes => routes.whereType<Trip>().toList();

  RxList<int> deletedItems = <int>[].obs;
  RxList<int> get deletedItemsObs => deletedItems;

  RxList<Place> selectedPlaces = <Place>[].obs;
  RxList<Place> get addedItemsObs => selectedPlaces;

  RxList<Place> recommendedPlaces = <Place>[].obs;
  RxList<Place> get recommendedPlacesObs => recommendedPlaces;

  RxList<Place> bookmarkedPlaces = <Place>[].obs;
  RxList<Place> get bookmarkedPlacesObs => bookmarkedPlaces;

  RxList<Place> allPlaces = mockPlaces.obs;

  List<Map<String, String>> routeChoices = [
    {
      // 1- 2
      //dest : placeId
      "Dest1": "1",
      "Dest2": "2",
      "mode": "Car -> Train -> Bus",
      "time": "21mins",
      "price": "100THB",
    },
    {
      //dest : placeId
      "Dest1": "1",
      "Dest2": "2",
      "mode": "Bus -> Train",
      "time": "16mins",
      "price": "140THB",
    },
    {
      //dest : placeId
      "Dest1": "1",
      "Dest2": "2",
      "mode": "Train -> Walk",
      "time": "22mins",
      "price": "130THB",
    },
    //2 -> 1
    {
      //dest : placeId
      "Dest1": "2",
      "Dest2": "1",
      "mode": "Bus -> Train",
      "time": "30mins",
      "price": "140THB",
    },
    {
      //dest : placeId
      "Dest1": "2",
      "Dest2": "1",
      "mode": "Train -> Walk",
      "time": "2mins",
      "price": "130THB",
    },

    // 2 - 3
    {
      //dest : placeId
      "Dest1": "2",
      "Dest2": "3",
      "mode": "Walk -> Train",
      "time": "40mins",
      "price": "130THB",
    },
    // 3 - 2
    {
      //dest : placeId
      "Dest1": "3",
      "Dest2": "2",
      "mode": "Train -> Walk",
      "time": "2mins",
      "price": "130THB",
    },
    // 3 - 1
    {
      //dest : placeId
      "Dest1": "3",
      "Dest2": "1",
      "mode": "Train -> Bus",
      "time": "25mins",
      "price": "130THB",
    },
    {
      //dest : placeId
      "Dest1": "1",
      "Dest2": "3",
      "mode": "Walk -> Bus",
      "time": "2mins",
      "price": "10THB",
    },
    {
      //dest : placeId
      "Dest1": "1",
      "Dest2": "5",
      "mode": "Walk -> Bus",
      "time": "2mins",
      "price": "10THB",
    },
    {
      //dest : placeId
      "Dest1": "5",
      "Dest2": "2",
      "mode": "Walk -> Bus",
      "time": "2mins",
      "price": "10THB",
    },
    {
      //dest : placeId
      "Dest1": "2",
      "Dest2": "5",
      "mode": "Walk -> Bus",
      "time": "2mins",
      "price": "10THB",
    },
    {
      //dest : placeId
      "Dest1": "5",
      "Dest2": "3",
      "mode": "Walk -> Bus",
      "time": "2mins",
      "price": "10THB",
    },
    {
      //dest : placeId
      "Dest1": "3",
      "Dest2": "5",
      "mode": "Walk -> Bus",
      "time": "2mins",
      "price": "10THB",
    },
  ];

  TripController({this.getTripByDayId, this.getTripByPlanId});

  @override
  void onInit() {
    super.onInit();
    fetchTripsbyPlanId(1);
    fetchRecommendedPlaces(); //FIXME: shouldn't be here, but for testing
    fetchBookmarkedPlaces(); //FIXME: shouldn't be here, but for testing
    log("🚀 TripController initialized");
  }

  Future<void> fetchTripsbyDay(int planId, int day) async {
    try {
      isLoading(true);
      if (getTripByDayId != null) {
        final result = await getTripByDayId!.execute(1, 1);
        trips.value.add(result);
        populatePlaceAndRouteLists();
      }
    } catch (e) {
      log("Error fetching trips by day: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchTripsbyPlanId(int planId) async {
    try {
      isLoading(true);
      trips
          .clear(); //clean previous trips in case user click day card before all card
      if (getTripByPlanId != null) {
        final result = await getTripByPlanId!.execute(planId);
        trips.value = result;
        populatePlaceAndRouteLists();
      }
    } catch (e) {
      log("Error fetching trips: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchRecommendedPlaces() async {
    if (recommendedPlaces.isEmpty && allPlaces.isNotEmpty) {
      recommendedPlaces.value =
          allPlaces.where((place) => int.parse(place.id) < 8).toList();
      log("Recommended places initialized: ${recommendedPlaces.length}");
    }
  }

  Future<void> fetchBookmarkedPlaces() async {
    if (allPlaces.isNotEmpty) {
      bookmarkedPlaces.value =
          allPlaces.where((place) => int.parse(place.id) > 7).toList();
      log("Recommended places initialized: ${bookmarkedPlaces.length}");
    }
  }

  void toggleEditTripInfo() {
    _isEditingTripInfo.value = !_isEditingTripInfo.value;
  }

  void toggleEditPlaceOrder() {
    _isEditingPlaceOrder.value = !_isEditingPlaceOrder.value;
    print("isEditingPlaceOrder: ${_isEditingPlaceOrder.value}");
  }

  void populatePlaceAndRouteLists() {
    //clear previous data
    routes.clear();
    places.clear();

    if (trips.isNotEmpty) {
      for (Trip trip in trips.whereType<Trip>().toList()) {
        places.add(
          Trip(
            id: trip.id,
            planId: trip.planId,
            day: trip.day,
            type: trip.type,
            placeId: trip.placeId,
            placeName: trip.placeName,
            placeDescription: trip.placeDescription,
            placeImageUrl: trip.placeImageUrl,
            arrivalTime: trip.arrivalTime,
            note: trip.note,
          ),
        );
        log("TripService: Added place ${trip.placeName} with id ${trip.id}");

        if (trip.routeFrom != null) {
          routes.add(
            Trip(
              id: trip.id,
              planId: trip.planId,
              day: trip.day,
              type: trip.type,
              routeMode: trip.routeMode,
              routeFrom: trip.routeFrom,
              routeTo: trip.routeTo,
              routeTotalTime: trip.routeTotalTime,
              routeTotalCost: trip.routeTotalCost,
              routeTotalDistance: trip.routeTotalDistance,
              routeDistance: trip.routeDistance,
              routeNote: trip.routeNote,
            ),
          );
          log(
            "TripService: Added route from ${trip.routeFrom} to ${trip.routeTo} with mode ${trip.routeMode}",
          );
        }
      }
    }
  }

  List<Map<String, String>> findRouteOptions(String placeId1, String placeId2) {
    return routeChoices
        .where(
          (route) => (route["Dest1"] == placeId1 && route["Dest2"] == placeId2),
        )
        .toList();
  }

  void onCardSelected(int index, int selectedIndex) {
    if (selectedIndex == index) {
      selectedIndex = -1;
    } else {
      selectedIndex = index;
    }
  }

  void recalculateAllRoutes() {
    // Clear all old routes
    routes.clear();

    for (int i = 0; i < places.length - 1; i++) {
      final fromPlace = places[i];
      final toPlace = places[i + 1];

      if (fromPlace.placeId != null && toPlace.placeId != null) {
        routes.add(
          Trip(
            id: "${fromPlace.id}-${toPlace.id}", // generate unique route id
            planId: fromPlace.planId,
            day: day.value,
            type: TripType.route,
            routeMode: RouteMode.unselected,
            routeFrom: fromPlace.placeId,
            routeTo: toPlace.placeId,
            routeTotalTime: null,
            routeTotalCost: null,
            routeTotalDistance: null,
            routeDistance: null,
            routeNote: null,
            note: null,
          ),
        );

        final matched = findRouteOptions(fromPlace.placeId!, toPlace.placeId!);
        log(
          "🔁 Regenerated route from ${fromPlace.placeId} → ${toPlace.placeId}: ${matched.length} option(s)",
        );
      }
    }

    log("✅ Total routes regenerated: ${routes.length}");
  }
  // void recalculateAllRoutes() {
  //   final List<Trip> newRoutes = [];

  //   for (int i = 0; i < places.length - 1; i++) {
  //     final fromPlace = places[i];
  //     final toPlace = places[i + 1];

  //     final fromId = fromPlace.placeId;
  //     final toId = toPlace.placeId;

  //     if (fromId == null || toId == null) continue;

  //     final routeId = "${fromPlace.id}-${toPlace.id}";
  //     final matchedRoutes = findRouteOptions(fromId, toId);

  //     newRoutes.add(
  //       Trip(
  //         id: routeId,
  //         planId: fromPlace.planId,
  //         day: day,
  //         type: TripType.route,
  //         routeMode: RouteMode.unselected,
  //         routeFrom: fromId,
  //         routeTo: toId,
  //       ),
  //     );

  //     log("🔁 Regenerated route from $fromId → $toId: ${matchedRoutes.length} option(s)");
  //   }

  //   routes.assignAll(newRoutes);
  //   log("✅ Total routes regenerated: ${newRoutes.length}");
  // }

  void handleReorder(int oldIndex, int newIndex, int selectedIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    //swap time
    String tempTime = places[newIndex].arrivalTime ?? '';
    places[newIndex].arrivalTime = places[oldIndex].arrivalTime;
    places[oldIndex].arrivalTime = tempTime;

    //swap place
    final Trip item = places.removeAt(oldIndex);
    places.insert(newIndex, item);

    //recalculate routes
    selectedIndex = -1;
    recalculateAllRoutes();

    print('Updated route: ${routes[0].routeMode} , ${routes[1].routeMode}');
  }

  void sortPlacebyTimes() {
    final format = DateFormat('hh:mm a');
    places.sort((a, b) {
      final timeA = format.parse(a.arrivalTime!);
      final timeB = format.parse(b.arrivalTime!);
      return timeA.compareTo(timeB);
    });
    
  }

  // void addPlace(index) {
  //   Trip newPlace = Trip(
  //     id: "1",
  //     planId: "1",
  //     day: 1,
  //     type: TripType.dest,
  //     placeId: "5",
  //     placeName: "Pattaya Floating Market",
  //     placeDescription:
  //         "Established since 2008, Pattaya Floating Market is riverside attraction in Pattaya displaying and showcasing the beautiful ancient Thai riverside living community and authentic ways of life",
  //     placeImageUrl:
  //         "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/11/53/6d/b7/pattaya-floating-market.jpg?w=1400&h=-1&s=1",
  //   );

  //   places.insert(index + 1, newPlace);
  //   recalculateAllRoutes();
  // }

  void deleteAllPlaceCards() {
    for (int ind in deletedItems) {
      if (ind < 0 || ind >= places.length) {
        log("Index $ind is out of bounds for places list.");
        continue;
      } else {
        places.removeAt(ind);
        routes.removeAt(ind); 
      }
    }
    deletedItems.clear();
    recalculateAllRoutes();
  }

  void addDeletedPlaceCards(int selectedIndex) {
    if (!deletedItems.contains(selectedIndex)) {
      deletedItems.add(selectedIndex);
    } else {
      deletedItems.remove(selectedIndex);
    }
    log("Deleted items: $deletedItems");
  }

  void addPlaceToSelected(int placeId) {
    selectedPlaces.add(
      allPlaces.firstWhere((place) => int.parse(place.id) == placeId),
    );
    log("Added place with ID $placeId to selected places.");
  }

  void removePlaceFromSelected(int placeId) {
    selectedPlaces.removeWhere((place) => place.id == placeId.toString());
  }

  void clearSelectedPlaces() {
    selectedPlaces.clear();
  }

  void addPlaceToTripRoute(int prevPlaceIndex) {
    log('day index: ${day.value}');
    for(Place place in selectedPlaces) {
      Trip _place = Trip(
        id: place.id,
        planId: "1",
        day:1,
        // day:day.value,
        type: TripType.dest,
        placeId: place.id,
        placeName: place.name,
        placeDescription: place.description,
        placeImageUrl: place.imageUrl,
        arrivalTime: incrementHour(places[prevPlaceIndex].arrivalTime!) ,
      );
      Trip _route = Trip(
        id: place.id,
        planId: "1",
        day:1,
        //day:day.value,
        type: TripType.dest,
        routeMode: RouteMode.unselected,
        routeFrom: places[prevPlaceIndex].placeId.toString(), 
        routeTo: place.id.toString(),  
        routeTotalTime: null,
        routeTotalCost: null,
        routeTotalDistance: null,
        routeDistance: null,
        routeNote: null,
        note: "Added to trip",
      );

      Trip _route2 = Trip(
        id: place.id,
        planId: "1",
        day: 1,
        //day:day.value,
        type: TripType.dest,
        routeMode: RouteMode.unselected,
        routeFrom: place.id.toString(),
        routeTo: places[prevPlaceIndex + 1].placeId.toString(),
        routeTotalTime: null,
        routeTotalCost: null,
        routeTotalDistance: null,
        routeDistance: null,
        routeNote: null,
        note: "Added to trip",
      );
      
      places.insert(prevPlaceIndex + 1, _place);
      routes.insert(prevPlaceIndex + 1, _route);

      //card after = time of added places + 1 
      if(prevPlaceIndex > 0 && prevPlaceIndex < places.length - 1) {
        routes.insert(prevPlaceIndex + 2, _route2);
        for(int i = prevPlaceIndex + 2; i < places.length; i++) {
          places[i].arrivalTime = incrementHour(places[i].arrivalTime!); 
        }
      }
    }
    selectedPlaces.clear(); 
    places.assignAll([...places]);
    routes.assignAll([...routes]);
  }

  //FIXME: create day flow(add button -> add new route -> if no route/trip exists = add button)
  
}
