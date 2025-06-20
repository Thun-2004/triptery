import 'dart:developer';
import 'package:get/get.dart';
import 'package:triptery/domain/entities/trip/trip.dart';
import 'package:triptery/domain/usecases/trip/get_trips.dart';

//strategy = trip gradually add when day card is clicked
class TripController extends GetxController {
  final GetTripByDayId? getTripByDayId;
  final GetTripByPlanId? getTripByPlanId;
  var isLoading = true.obs;
  RxList<Trip?> trips = <Trip?>[].obs; //NOTE: can't initialize list with null

  final Rx<bool> _isEditingTripInfo = Rx<bool>(false);
  bool get isEditingTripInfo => _isEditingTripInfo.value;

  final Rx<bool> _isEditingPlaceOrder = Rx<bool>(false);
  bool get isEditingPlaceOrder => _isEditingPlaceOrder.value;

  //added
  int day = 0;

  RxList<Trip> places = <Trip>[].obs;
  List<Trip> get getPlaces =>
      places.whereType<Trip>().toList(); // Getter for places

  RxList<Trip> routes = <Trip>[].obs;
  List<Trip> get getRoutes => routes.whereType<Trip>().toList();

  RxList<int> deletedItems = <int>[].obs;
  List<int> get getDeletedItems => routes.whereType<int>().toList();

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
    log("🚀 TripController initialized");
  }

  void test() {
    //print item in places
    for (Trip place in places) {
      log("TripController: Place - ${place.placeName}, ID - ${place.id}");
    }
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
            day: day,
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

  void addPlace(index) {
    Trip newPlace = Trip(
      id: "1",
      planId: "1",
      day: 1,
      type: TripType.dest,
      placeId: "5",
      placeName: "Pattaya Floating Market",
      placeDescription:
          "Established since 2008, Pattaya Floating Market is riverside attraction in Pattaya displaying and showcasing the beautiful ancient Thai riverside living community and authentic ways of life",
      placeImageUrl:
          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/11/53/6d/b7/pattaya-floating-market.jpg?w=1400&h=-1&s=1",
    );

    places.insert(index + 1, newPlace);
    recalculateAllRoutes();
  }

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

  //FIXME: create day flow(add button -> add new route -> if no route/trip exists = add button)
}
