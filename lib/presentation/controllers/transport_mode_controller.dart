
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:triptery/constant/transport_modes.dart';
import 'package:triptery/utils/datetime.dart';

class TransportModeController extends GetxController {
  var tempModes = <Map<String, dynamic>>[].obs; 

  @override
  void onInit() {
    super.onInit();
    tempModes.add(
      {
        "mode": TransportMode.walk,
        "station": null,
        "time_taken": "00:21",
        "distance": 21,
        "distance_unit": "km",
        "cost": 47,
        "cost_unit": "THB",
        "note": "Walk to MRT Huai Kwang", //FIXME : fix overflow text
      } as Map<String, dynamic>,
    );

    tempModes.add(
      {
        "mode": TransportMode.car,
        "station": null,
        "time_taken": "00:21",
        "distance": 21,
        "distance_unit": "km",
        "cost": 47,
        "cost_unit": "THB",
        "note": "Walk to MRT Huai Kwang",
      } as Map<String, dynamic>,
    );
    
    tempModes.add(
      {
        "mode": TransportMode.car,
        "station": null,
        "time_taken": "00:21",
        "distance": 21,
        "distance_unit": "km",
        "cost": 47,
        "cost_unit": "THB",
        "note": "Walk to MRT Huai Kwang",
      } as Map<String, dynamic>,
    );
  }

  void addMode(TransportMode mode) {
    tempModes.add(
      {
        "mode": mode,
        "station": null,
        "time_taken": "00:21",
        "distance": 21,
        "distance_unit": "km",
        "cost": 47,
        "cost_unit": "THB",
        "note": "Walk to MRT Huai Kwang",
      }
    );
  }

  int calcTotalTime() {
    int totalTime = 0;
    for (var mode in tempModes) {
      if (mode["time_taken"] != null) {
        totalTime += convertToMinutes(mode["time_taken"]);
      }
    }
    return totalTime;
  }

  //NOTE: num = both int/float
  num calcTotalDistance() {
    num totalDistance = 0;
    for (var mode in tempModes) {
      if (mode["distance"] != null) {
        if (mode["distance_unit"] == "km") {
          totalDistance += mode["distance"];
        } else if (mode["distance_unit"] == "meters") {
          totalDistance += mode["distance"] / 1000; // Convert meters to km
        } 
      }
    }
    return totalDistance;
  }

  num calcTotalCost() {
    num totalCost = 0;
    for (var mode in tempModes) {
      if (mode["cost"] != null) {
        totalCost += mode["cost"]; //NOTE: int.parse() to convert string to int
      } 
    }
    return totalCost;
  }

}

// List<Map<String, dynamic>> tempModes = [
  //   {
  //     "planId": 1,
  //     "day": 1,
  //     "total_time": 21,
  //     "total_cost": 47,
  //     "total_distance": 21,
  //     "fromPlaceId": "placeId1",
  //     "toPlaceId": "placeId2",
  //     "tripDetail" : [
  //       {
  //         "name": TransportMode.unSelected,
  //         "station": "Ratchada Market",
  //         "time_taken": "00:21",
  //         "distance": 21,
  //         "distance_unit": "km",
  //         "cost": 47,
  //         "cost_unit" : "THB",
  //         "note": "Walk to MRT Huai Kwang",
  //       }
  //     ],
  //     "createdAt": DateTime.now().toIso8601String(),
  //     "approved": false,
  //   },
  // ];