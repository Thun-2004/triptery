
import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:triptery/data/mock/mock_places.dart';
import 'package:triptery/domain/entities/place/place.dart';
import 'package:triptery/domain/entities/trip/trip.dart';
import 'package:triptery/domain/usecases/trip/get_trips.dart';
import 'package:triptery/constant/transport_modes.dart';

class TripController extends GetxController {
  final GetTripByDayId? getTripByDayId;
  final GetTripByPlanId? getTripByPlanId;
  var isLoading = true.obs;
  RxList<Trip?> trips = <Trip?>[].obs; //NOTE: can't initialize list with null

  final Rx<bool> _isEditingTripInfo = Rx<bool>(false);
  bool get isEditingTripInfo => _isEditingTripInfo.value;

  final Rx<bool> _isEditingPlaceOrder = Rx<bool>(false);
  Rx<bool> get isEditingPlaceOrderObs => _isEditingPlaceOrder;

  final Rx<bool> isEditingDay = Rx<bool>(false);

  Rx<int> selectedIndex = (-1).obs; // Reactive selected index

  // int day = 0;
  Rx<int> day = 0.obs; // Reactive day variable

  RxList<int> deletedItems = <int>[].obs;
  RxList<int> get deletedItemsObs => deletedItems;

  RxList<Map<String, dynamic>> selectedPlaces = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> get addedItemsObs => selectedPlaces;

  RxList<Map<String, dynamic>> recommendedPlaces = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> get recommendedPlacesObs => recommendedPlaces;

  RxList<Map<String, dynamic>> bookmarkedPlaces = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> get bookmarkedPlacesObs => bookmarkedPlaces;

  RxList<Place> allPlaces = mockPlaces.obs;

  RxList<Map<String, dynamic>> places_temp =
      [
        {
          "id": 1,
          "placeId": 1,
          "placeName": "Pattaya Floating Market",
          "placeImageUrl":
              "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/11/53/6d/b7/pattaya-floating-market.jpg?w=1400&h=-1&s=1",
          "activities": ["Buy food", "Swim", "Eat fish"],
        },
        {
          "id": 2,
          "placeId": 2,
          "placeName": "Jomtien Beach",
          "placeImageUrl":
              "https://i.pinimg.com/736x/6e/bd/aa/6ebdaa58bc13a33a76f9beb560111da2.jpg",
          "activities": [
            "See Mermaids",
            "Fishing at night",
            "Drunk with fine shyts",
          ],
        },
        {
          "id": 3,
          "placeId": 3,
          "placeName": "Sanctuary of Truth",
          "placeImageUrl":
              "https://i.pinimg.com/736x/e3/8c/10/e38c109f5cb9d2de547f5125b44f4912.jpg",
          "activities": ["See Mermaids", "Fishing at night"],
        },
        {
          "id": 4,
          "placeId": 4,
          "placeName": "Central Pattaya",
          "placeImageUrl":
              "https://i.pinimg.com/736x/62/6d/50/626d50fba92b0607bf5416c48f4641d2.jpg",
          "activities": null,
        },

        //temp
        {
          "id": 5,
          "placeId": 5,
          "placeName": "Place 1 in Phuket",
          "placeImageUrl":
              "https://i.pinimg.com/736x/62/6d/50/626d50fba92b0607bf5416c48f4641d2.jpg",
          "activities": null,
        },
        {
          "id": 6,
          "placeId": 6,
          "placeName": "Chiang Mai Old Town",
          "placeImageUrl":
              "https://i.pinimg.com/736x/62/6d/50/626d50fba92b0607bf5416c48f4641d2.jpg",
          "activities": null,
        },
        {
          "id": 7,
          "placeId": 7,
          "placeName": "Ayutthaya Historical Park",
          "placeImageUrl":
              "https://i.pinimg.com/736x/62/6d/50/626d50fba92b0607bf5416c48f4641d2.jpg",
          "activities": null,
        },
        {
          "id": 8,
          "placeId": 8,
          "placeName": "Wat Arun",
          "placeImageUrl":
              "https://i.pinimg.com/736x/62/6d/50/626d50fba92b0607bf5416c48f4641d2.jpg",
          "activities": null,
        },
      ].obs;

  RxList<Map<String, dynamic>> trips_temp = 
      [
        {
          "id": 1,
          "userId": "user123",
          "planId": 1,
          "day": 1,
          "placeId": 1,
          "routeId": 1,
          "arrivalTime": "08:00 AM",
          "timeSpent": "00:30",
          "moneySpent": 100,
          "note": "don't eat the fish",
        },
        {
          "id": 2,
          "userId": "user123",
          "planId": 1,
          "day": 1,
          "placeId": 2,
          "routeId": 2,
          "arrivalTime": "09:00 AM",
          "timeSpent": "00:30",
          "moneySpent": 100,
          "note": "bring sunscreen",
        },
        {
          "id": 3,
          "userId": "user123",
          "planId": 1,
          "day": 1,
          "placeId": 3,
          "routeId": 3,
          "arrivalTime": "10:00 AM",
          "timeSpent": "00:30",
          "moneySpent": 100,
          "note": null,
        },
        {
          "id": 4,
          "userId": "user123",
          "planId": 1,
          "day": 2,
          "placeId": 4,
          "routeId": null,
          "arrivalTime": "11:00 AM",
          "timeSpent": "00:30",
          "moneySpent": 100,
          "note": null,
        },
      ].obs;

  RxList<Map<String, dynamic>> routes_temp =
      [
        {
          "id": 1,
          "planId": "1",
          "day": 1,
          "fromPlaceId": 1,
          "toPlaceId": 2,
          "createdAt": DateTime.now().toIso8601String(),
          "note": null
        },
        {
          "id": 2,
          "planId": "1",
          "day": 1,
          "fromPlaceId": 2,
          "toPlaceId": 3,
          "createdAt": DateTime.now().toIso8601String(),
          "note": null
        },
        {
          "id": 3,
          "planId": "1",
          "day": 1,
          "fromPlaceId": 2,
          "toPlaceId": 1,
          "createdAt": DateTime.now().toIso8601String(),
          "note": null
        },
        {
          "id": 4,
          "planId": "1",
          "day": 1,
          "fromPlaceId": 3,
          "toPlaceId": 2,
          "createdAt": DateTime.now().toIso8601String(),
          "note": null
        },
        {
          "id": 5,
          "planId": "1",
          "day": 1,
          "fromPlaceId": 3,
          "toPlaceId": 1,
          "createdAt": DateTime.now().toIso8601String(),
          "note": null
        },
        {
          "id": 6,
          "planId": "1",
          "day": 1,
          "fromPlaceId": 1,
          "toPlaceId": 3,
          "createdAt": DateTime.now().toIso8601String(),
          "note": null
        },
      ].obs;

  RxList<Map<String, dynamic>> routeOptions_temp =
      [
        {
          "id": 1,
          "routeId": 1,
          "total_time": 20,
          "total_cost": 20,
          "total_distance": 20,
          "isNote": false,
          "note": null,
          "isSelected": true,
          "approved": false,
          "creatorId": "user123",
          "createdAt": DateTime.now().toIso8601String(),
        },
        {
          "id": 2,
          "routeId": 1,
          "total_time": 15,
          "total_cost": 15,
          "total_distance": 15,
          "isNote": false, 
          "note": null,
          "isSelected": false,
          "approved": false,
          "creatorId": "user123",
          "createdAt": DateTime.now().toIso8601String(),
        },

        //user note 
        {
          "id": 3,
          "routeId": 1,
          "total_time": null,
          "total_cost": null,
          "total_distance": null,
          "isNote": true, 
          "note": "User note for route 1",
          "isSelected": false,
          "approved": false,
          "creatorId": "user123",
          "createdAt": DateTime.now().toIso8601String(),
        },
        {
          "id": 4,
          "routeId": 1,
          "total_time": null,
          "total_cost": null,
          "total_distance": null,
          "isNote": false,
          "note": null,
          "isSelected": false,
          "approved": false,
          "creatorId": "google",
          "createdAt": DateTime.now().toIso8601String(),
        },
        {
          "id": 5,
          "routeId": 2,
          "total_time": 15,
          "total_cost": 15,
          "total_distance": 15,
          "isNote": false,
          "note": null,
          "isSelected": true,
          "approved": false,
          "creatorId": "user123",
          "createdAt": DateTime.now().toIso8601String(),
        },
        {
          "id": 6,
          "routeId": 2,
          "total_time": 0,
          "total_cost": 0,
          "total_distance": 0,
          "isNote": true, 
          "note": "User note for route 3",
          "isSelected": true,
          "approved": false,
          "creatorId": "user123",
          "createdAt": DateTime.now().toIso8601String(),
        },
        {
          "id": 7,
          "routeId": 2,
          "total_time": 0,
          "total_cost": 0,
          "total_distance": 0,
          "isNote": false, 
          "note": null,
          "isSelected": true,
          "approved": false,
          "creatorId": "google",
          "createdAt": DateTime.now().toIso8601String(),
        },
        {
          "id": 8,
          "routeId": 3,
          "total_time": 15,
          "total_cost": 15,
          "total_distance": 15,
          "isNote": false, 
          "note": null,
          "isSelected": true,
          "approved": false,
          "creatorId": "user123",
          "createdAt": DateTime.now().toIso8601String(),
        },
        {
          "id": 9,
          "routeId": 3,
          "total_time": 0,
          "total_cost": 0,
          "total_distance": 0,
          "isNote": true,
          "note": "User note for route 3",
          "isSelected": false,
          "approved": false,
          "creatorId": "user123",
          "createdAt": DateTime.now().toIso8601String(),
        },
        {
          "id": 10,
          "routeId": 3,
          "total_time": 0,
          "total_cost": 0,
          "total_distance": 0,
          "isNote": false,
          "note": null,
          "isSelected": false,
          "approved": false,
          "creatorId": "google",
          "createdAt": DateTime.now().toIso8601String(),
        },
        {
          "id": 11,
          "routeId": 6,
          "total_time": 15,
          "total_cost": 15,
          "total_distance": 15,
          "isNote": false,
          "note": null,
          "isSelected": true,
          "approved": false,
          "creatorId": "user123",
          "createdAt": DateTime.now().toIso8601String(),
        },
      ].obs;

  RxList<Map<String, dynamic>> routeSegments_temp =
      [
        {
          "id": 1,
          "optionId": 1,
          "mode": TransportMode.car,
          "station": null,
          "time_taken": "00:20",
          "distance": 15,
          "distance_unit": "km",
          "cost": 20,
          "cost_unit": "THB",
          "note": "ride from pattay floating market to bus101 ",
        },
        {
          "id": 2,
          "optionId": 1,
          "mode": TransportMode.train,
          "station": "Huai Kwang",
          "time_taken": "00:20",
          "distance": 20,
          "distance_unit": "km",
          "cost": 20,
          "cost_unit": "THB",
          "note": "arrive at bus101 and go across the street to bus 102",
        },
        {
          "id": 3,
          "optionId": 2,
          "mode": TransportMode.walk,
          "station": null,
          "time_taken": "00:20",
          "distance": 20,
          "distance_unit": "km",
          "cost": 20,
          "cost_unit": "THB",
          "note": null,
        },
        {
          "id": 4,
          "optionId": 5,
          "mode": TransportMode.skyTrain,
          "station": "Ladprao",
          "time_taken": "00:20",
          "distance": 20,
          "distance_unit": "km",
          "cost": 20,
          "cost_unit": "THB",
          "note": null,
        },
        {
          "id": 5,
          "optionId": 5,
          "mode": TransportMode.taxi,
          "station": null,
          "time_taken": "00:20",
          "distance": 20,
          "distance_unit": "km",
          "cost": 20,
          "cost_unit": "THB",
          "note": null,
        },
        {
          "id": 6,
          "optionId": 8,
          "mode": TransportMode.taxi,
          "station": null,
          "time_taken": "00:20",
          "distance": 20,
          "distance_unit": "km",
          "cost": 20,
          "cost_unit": "THB",
          "note": null,
        },
        {
          "id": 7,
          "optionId": 8,
          "mode": TransportMode.taxi,
          "station": null,
          "time_taken": "00:20",
          "distance": 20,
          "distance_unit": "km",
          "cost": 20,
          "cost_unit": "THB",
          "note": null,
        },
        {
          "id": 8,
          "optionId": 8,
          "mode": TransportMode.taxi,
          "station": null,
          "time_taken": "00:20",
          "distance": 20,
          "distance_unit": "km",
          "cost": 20,
          "cost_unit": "THB",
          "note": null,
        },
        {
          "id": 9,
          "optionId": 10,
          "mode": TransportMode.taxi,
          "station": null,
          "time_taken": "00:20",
          "distance": 20,
          "distance_unit": "km",
          "cost": 20,
          "cost_unit": "THB",
          "note": null,
        },
        {
          "id": 9,
          "optionId": 11,
          "mode": TransportMode.taxi,
          "station": null,
          "time_taken": "00:20",
          "distance": 20,
          "distance_unit": "km",
          "cost": 20,
          "cost_unit": "THB",
          "note": null,
        },
      ].obs;

  TripController({this.getTripByDayId, this.getTripByPlanId});

  @override
  void onInit() {
    super.onInit();
    fetchTripsbyPlanId(1);
    fetchRecommendedPlaces(); //FIXME: shouldn't be here, but for testing
    fetchBookmarkedPlaces(); //FIXME: shouldn't be here, but for testing
    log("🚀 TripController initialized");
  }

  void toggleEditDay(){
    isEditingDay.value = !isEditingDay.value;
  }

  void addDay(){
    
  }

  void deleteDay(int dayId){
    //show pop up window
  }

  Future<void> fetchTripsbyDay(int planId, int day) async {
    try {
      isLoading(true);
      if (getTripByDayId != null) {
        final result = await getTripByDayId!.execute(1, 1);
        trips.value.add(result);
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
          places_temp.where((place) => place["id"] > 4 && place["id"] < 7).toList();
      log("Recommended places initialized: ${recommendedPlaces.length}");
    }
  }

  Future<void> fetchBookmarkedPlaces() async {
    if (allPlaces.isNotEmpty) {
      bookmarkedPlaces.value =
          places_temp.where((place) => place["id"] > 6).toList();
      log("Recommended places initialized: ${bookmarkedPlaces.length}");
    }
  }

  void toggleEditTripInfo() {
    _isEditingTripInfo.value = !_isEditingTripInfo.value;
  }

  void toggleEditPlaceOrder() {
    _isEditingPlaceOrder.value = !_isEditingPlaceOrder.value;
    log("isEditingPlaceOrder: ${_isEditingPlaceOrder.value}");
  }

  void populateRouteOptionDefaultValues(int routeId){
    routeOptions_temp.addAll([
      {
        "id": routeOptions_temp.length + 1,
        "routeId": routeId,
        "total_time": 0,
        "total_cost": 0,
        "total_distance": 0,
        "isNote": false,
        "note": null,
        "isSelected": true,
        "approved": false,
        "creatorId": "google",
        "createdAt": DateTime.now().toIso8601String(),
      },
      {
        "id": routeOptions_temp.length + 2,
        "routeId": routeId,
        "total_time": 0,
        "total_cost": 0,
        "total_distance": 0,
        "isNote": true, 
        "note": null,
        "isSelected": false,
        "approved": false,
        "creatorId": "user123",
        "createdAt": DateTime.now().toIso8601String(),
      },
    ]);
  }

  void selectRouteOption(int routeId, int optionId) {
    for (var option in routeOptions_temp) {
      if (option["routeId"] == routeId) {
        option["isSelected"] = false;
      }
    }

    // Select the specified option
    var selectedOption = routeOptions_temp.firstWhere(
      (option) => option["id"] == optionId && option["routeId"] == routeId,
      orElse: () => {},
    );

    if (selectedOption.isNotEmpty) {
      selectedOption["isSelected"] = true;
      log("Selected option ID: $optionId for route ID: $routeId");
    } else {
      log("No matching option found for ID: $optionId and route ID: $routeId");
    }
  }

  //done
  List<Map<String, dynamic>> findRouteOptions(int? matchingRouteId) {
    List<Map<String, dynamic>> routeOptions =
        routeOptions_temp
            .where((routeOption) => routeOption["routeId"] == matchingRouteId)
            .toList();
    if (routeOptions != null) {
      return routeOptions;
    } else {
      log("No route options found for route ID: $matchingRouteId");
      return [];
    }
  }

  void onCardSelected(int index, int selectedIndex) {
    if (selectedIndex == index) {
      selectedIndex = -1;
    } else {
      selectedIndex = index;
    }
  }

  //done
  void recalculateAllRoutes(int newIndex) {
    int startInd = (newIndex > 0) ? newIndex - 1: 0;
    int endInd = (newIndex < trips_temp.length - 1) ? newIndex + 1 : trips_temp.length - 1;

    for(int i = startInd; i < endInd - 1; i++) {
      final fromPlaceId = trips_temp[i]["placeId"];
      final toPlaceId = trips_temp[i + 1]["placeId"];

      var matchingRoutes = routes_temp.firstWhereOrNull((route) =>
          route["fromPlaceId"] == fromPlaceId &&
          route["toPlaceId"] == toPlaceId);

      if (matchingRoutes != null) {
        trips_temp[i]["routeId"] = matchingRoutes["id"];
      }else{
        //crete new route if not found
        routes_temp.add({
          "id": routes_temp.length + 1,
          "planId": trips_temp[i]["planId"],
          "day": trips_temp[i]["day"],
          "fromPlaceId": fromPlaceId,
          "toPlaceId": toPlaceId,
          "createdAt": DateTime.now().toIso8601String(),
        });
        trips_temp[i]["routeId"] = routes_temp.last["id"];
      }
    }
  }

  //done
  void handleReorder(int oldIndex, int newIndex, int selectedIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final Map<String, dynamic> item = trips_temp.removeAt(oldIndex);
    trips_temp.insert(newIndex, item);

    //swap place
    adjustTimeWithDurations();

    //recalculate routes
    selectedIndex = -1;
    recalculateAllRoutes(newIndex);
  }

  //done
  void adjustTimeWithDurations() {
    //sort time list
    //filled places_arrival
    List<dynamic> arrivalTimes = trips_temp.map((trip) => trip["arrivalTime"] ?? '').toList();
    arrivalTimes.sort((a, b) {
      final format = DateFormat('hh:mm a');
      try {
        final timeA = format.parseStrict(a.trim());
        final timeB = format.parseStrict(b.trim());
        return timeA.compareTo(timeB);
      } catch (e) {
        return 0;
      }
    });

    //change places arrival time to the sorted time
    for (int i = 0; i < trips_temp.length; i++) {
      if (i < arrivalTimes.length) {
        trips_temp[i]["arrivalTime"] = arrivalTimes[i];
      }
    }
  }

  //done
  void sortPlacebyTimes(int placeIndex, String finalTime) {
    trips_temp[placeIndex]["arrivalTime"] = finalTime;
    
    //reorder trips_temp based on arrival time
    for (int i = 0; i < trips_temp.length; i++) {
      //compare arrival times
      if (i > 0 && trips_temp[i]["arrivalTime"] != null && trips_temp[i - 1]["arrivalTime"] != null) {
        final format = DateFormat('hh:mm a');
        try {
          final timeA = format.parseStrict(trips_temp[i]["arrivalTime"].trim());
          final timeB = format.parseStrict(trips_temp[i - 1]["arrivalTime"].trim());
          if (timeA.isBefore(timeB)) {
            //swap places
            final temp = trips_temp[i];
            trips_temp[i] = trips_temp[i - 1];
            trips_temp[i - 1] = temp;   
          }
        } catch (e) {
          log("Error parsing time: $e");
        }
      }
    }
  }

  //done
  void deleteAllPlaceCards() {
    for (int ind in deletedItems) {
      if (ind < 0 || ind >= trips_temp.length) {
        log("Index $ind is out of bounds for places list.");
        continue;
      } else {
        trips_temp.removeAt(ind);
        recalculateAllRoutes(ind);
      }
    }
    for (int i = 0; i < routes_temp.length; i++) {
      log("log: routes_temp[$i]: ${routes_temp[i]}"); 
    }
    for (int i = 0; i < trips_temp.length; i++) {
      log("log: trips_temp[$i]: ${trips_temp[i]}"); 
    }

    deletedItems.clear();
    // recalculateAllRoutes();
  }

  void deleteRouteOption(int index) {
    if (index >= 0 && index < routeOptions_temp.length) {
      routeOptions_temp.removeAt(index);
      routeOptions_temp.refresh(); // ensures UI updates
      log("Removed mode at index $index");
    } else {
      log("❌ Index $index is out of bounds");
    }
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
      places_temp.firstWhere((place) => place["id"] == placeId),
    );
    log("Added place with ID $placeId to selected places.");
  }

  void removePlaceFromSelected(int placeId) {
    selectedPlaces.removeWhere((place) => place["id"] == placeId);
  }

  void clearSelectedPlaces() {
    selectedPlaces.clear();
  }

  void setRouteNote(int routeId, String text){
    for (int i = 0; i < routes_temp.length; i++) {
      if (routes_temp[i]["id"] == routeId) {
        routes_temp[i]["note"] = text;
        log("Route note updated for route ID $routeId: $text");
        break;
      }
    }
    routes_temp.assignAll([...routes_temp]);
  }

  //new
  void addPlaceToTripRoute(int prevPlaceIndex) {
    log('Adding places after index: $prevPlaceIndex');

    for (var place in selectedPlaces) {
      int newId = trips_temp.length + 1;

      // Get previous place arrival time
      String prevArrival = trips_temp[prevPlaceIndex]["arrivalTime"];
      final format = DateFormat('hh:mm a');
      DateTime prevTime = format.parseStrict(prevArrival);
      DateTime newTime = prevTime.add(Duration(hours: 1));
      String newArrivalTime = format.format(newTime);

      // Create new trip
      Map<String, dynamic> newTrip = {
        "id": newId,
        "userId": "user123",
        "planId": trips_temp[prevPlaceIndex]["planId"],
        "day": trips_temp[prevPlaceIndex]["day"],
        "placeId": place["placeId"],
        "routeId": null,
        "arrivalTime": newArrivalTime,
        "timeSpent": "00:30",
        "moneySpent": 0,
        "note": "Added to trip",
      };

      // Create route from previous place to new place
      Map<String, dynamic> newRoute = {
        "id": routes_temp.length + 1,
        "planId": trips_temp[prevPlaceIndex]["planId"],
        "day": trips_temp[prevPlaceIndex]["day"],
        "fromPlaceId": trips_temp[prevPlaceIndex]["placeId"],
        "toPlaceId": place["placeId"],
        "createdAt": DateTime.now().toIso8601String(),
        "note": null,
      };
      routes_temp.add(newRoute);

      // Update trip routeId of prev trip
      trips_temp[prevPlaceIndex]["routeId"] = newRoute["id"];

      // Insert new trip after prevPlaceIndex
      trips_temp.insert(prevPlaceIndex + 1, newTrip);

      // If there is a next place after inserted place, create route from new place to next place
      if (prevPlaceIndex + 2 < trips_temp.length && trips_temp[prevPlaceIndex + 2]["placeId"] != null) {
        Map<String, dynamic> nextTrip = trips_temp[prevPlaceIndex + 2];
        Map<String, dynamic> routeToNext = {
          "id": routes_temp.length + 1,
          "planId": newTrip["planId"],
          "day": newTrip["day"],
          "fromPlaceId": place["placeId"],
          "toPlaceId": nextTrip["placeId"],
          "createdAt": DateTime.now().toIso8601String(),
          "note": null,
        };
        routes_temp.add(routeToNext);

        // newTrip["routeId"] = routeToNext["id"];
        trips_temp[prevPlaceIndex+1]["routeId"] = routeToNext["id"];
      }

      // Adjust arrival time of subsequent trips
      for (int i = prevPlaceIndex + 2; i < trips_temp.length; i++) {
        String arrival = trips_temp[i]["arrivalTime"];
        DateTime time = format.parseStrict(arrival);
        time = time.add(Duration(hours: 1));
        trips_temp[i]["arrivalTime"] = format.format(time);
      }
      prevPlaceIndex++; // update prevPlaceIndex for next inserted place
    }

    selectedPlaces.clear();
    trips_temp.assignAll([...trips_temp]);
    routes_temp.assignAll([...routes_temp]);
    log("✅ Added places to trip route. Total trips: ${trips_temp.length}, routes: ${routes_temp.length}");
    
  }

  //FIXME: create day flow(add button -> add new route -> if no route/trip exists = add button)
}
