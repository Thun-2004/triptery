import 'package:triptery/data/mock/mock_plan.dart';
import 'package:triptery/domain/entities/trip/trip.dart';
import 'dart:developer';

//NOTE: _varname = private variable
//FIXME: change to provider
class TripService {
  //state var
  int day = 0;
  List<Trip> places = [];
  List<Trip> routes = [];
  List<int> deletedItems = [];
  List<Trip> trips = mockTrips;
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

  TripService(this.day) {
    //label day
    log("TripService initialized");
  }

  void init() {
    // if (places.isEmpty && trips.isNotEmpty) {
    //   places = trips.where((trip) => trip.type == TripType.dest).toList();
    // }

    if (trips.isNotEmpty) {
      // routes = trips.where((trip) => trip.type == TripType.route).toList();
      for (Trip trip in trips) {
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

  List<Trip> getPlaces() {
    return places;
  }

  List<Trip> getRoutes() {
    return routes;
  }

  List<int> getDeletedItems() {
    return deletedItems;
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

  // void recalculateAllRoutes() {
  //   // Calculate how many routes we should have based on places
  //   int expectedRouteCount = 0;
  //   for (int i = 0; i < places.length - 1; i++) {
  //     if (places[i].placeId != null && places[i + 1].placeId != null) {
  //       expectedRouteCount++;
  //     }
  //   }

  //   // Resize routes list if needed
  //   if (routes.length > expectedRouteCount) {
  //     routes = routes.sublist(0, expectedRouteCount);
  //   }

  //   // Update existing routes or add new ones
  //   int routeIndex = 0;
  //   for (int i = 0; i < places.length - 1; i++) {
  //     if (places[i].placeId != null && places[i + 1].placeId != null) {
  //       // Create or update route
  //       if (routeIndex < routes.length) {
  //         // Update existing route
  //         routes[routeIndex] = Trip(
  //           id: routes[routeIndex].id,
  //           planId: routes[routeIndex].planId,
  //           day: day,
  //           type: TripType.route,
  //           routeMode: routes[routeIndex].routeMode ?? RouteMode.unselected,
  //           routeFrom: places[i].placeId,
  //           routeTo: places[i + 1].placeId,
  //           routeTotalTime: routes[routeIndex].routeTotalTime,
  //           routeTotalCost: routes[routeIndex].routeTotalCost,
  //           routeTotalDistance: routes[routeIndex].routeTotalDistance,
  //           routeDistance: routes[routeIndex].routeDistance,
  //           routeNote: routes[routeIndex].routeNote,
  //           note: routes[routeIndex].note,
  //         );
  //       } else {
  //         // Add new route
  //         routes.add(
  //           Trip(
  //             id: places[i].id,
  //             planId: places[i].planId,
  //             day: day,
  //             type: TripType.route,
  //             routeMode: RouteMode.unselected,
  //             routeFrom: places[i].placeId,
  //             routeTo: places[i + 1].placeId,
  //             routeTotalTime: null,
  //             routeTotalCost: null,
  //             routeTotalDistance: null,
  //             routeDistance: null,
  //             routeNote: null,
  //             note: null,
  //           ),
  //         );
  //       }
  //       routeIndex++;
  //     }

  //     print(
  //       'route options: ${findRouteOptions(places[i].id, places[i + 1].id)}',
  //     );
  //   }
  // }
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
        print(
          "🔁 Regenerated route from ${fromPlace.placeId} → ${toPlace.placeId}: ${matched.length} option(s)",
        );
      }
    }

    print("✅ Total routes regenerated: ${routes.length}");
  }

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
      // arrivalTime: null,
      // routeMode: null,
      // routeTotalTime: null,
      // routeTotalCost: null,
      // routeTotalDistance: null,
      // routeDistance: null,
      // routeNote: null,
      // note: null,
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
}
