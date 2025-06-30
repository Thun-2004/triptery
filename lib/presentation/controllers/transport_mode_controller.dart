
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:triptery/constant/transport_modes.dart';
import 'package:triptery/utils/datetime.dart';

class TransportModeController extends GetxController {
  RxList<Map<String, dynamic>> tempModes = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // tempModes.add(
    //   {
    //     "mode": TransportMode.walk,
    //     "station": null,
    //     "time_taken": "00:21",
    //     "distance": 21,
    //     "distance_unit": "km",
    //     "cost": 47,
    //     "cost_unit": "THB",
    //     "note": "Walk to MRT Huai Kwang", //FIXME : fix overflow text
    //   } as Map<String, dynamic>,
    // );
  }

  void addMode(TransportMode mode) {
    tempModes.add(
      {
        "mode": mode,
        "station": null,
        "time_taken": "00:00",
        "distance": 0,
        "distance_unit": "km",
        "cost": 0,
        "cost_unit": "THB",
        "note": "",
      }
    );
  }

  void clearModes() {
    tempModes.clear();
    log("Transport modes cleared");
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

  void setTransportMode(int modeIndex, TransportMode mode) {
    if (tempModes.isNotEmpty) {
      tempModes[modeIndex]["mode"] = mode;
    }
    log("Transport mode set to: ${ tempModes[modeIndex]["mode"]}");
  }

  void setModeDuration(int modeIndex, String timeTaken){
    //NOTE: timeTaken is in HH:MM format
    if (timeTaken.isEmpty || !RegExp(r'^\d{2}:\d{2}$').hasMatch(timeTaken)) {
      throw ArgumentError("Invalid time format. Use HH:MM.");
    }

    //check if timeTaken is valid
    final parts = timeTaken.split(':');
    final hours = int.parse(parts[0]);
    final minutes = int.parse(parts[1]);
    if (hours < 0 || minutes < 0 || minutes >= 60) {
      throw ArgumentError("Invalid time format. Use HH:MM.");
    }

    if (tempModes.isNotEmpty) {
      tempModes[modeIndex]["time_taken"] = timeTaken;
    }
    tempModes.refresh(); 
    log("Mode duration set to: ${tempModes[modeIndex]["time_taken"]}");
  }

  void setDistance(int modeIndex, int distance){
    //NOTE: distance is in km
    if (distance < 0) {
      throw ArgumentError("Distance cannot be negative");
    }
    // Assuming the first mode is the one to set the distance for
    if (tempModes.isNotEmpty) {
      tempModes[modeIndex]["distance"] = distance;
    }
    tempModes.refresh();
    log("Distance set to: ${tempModes[modeIndex]["distance"]}");
    
  }

  void setDistanceUnit(int modeIndex, String unit){
    if (tempModes.isNotEmpty) {
      tempModes[modeIndex]["distance_unit"] = unit;
    }
    tempModes.refresh();
    log("Distance unit set to: ${tempModes[modeIndex]["distance_unit"]}");
  }

  void setCost(int modeIndex, int cost){
    if (cost < 0) {
      throw ArgumentError("Cost cannot be negative");
    }

    if (tempModes.isNotEmpty) {
      tempModes[modeIndex]["cost"] = cost;
    }
    tempModes.refresh();
    log("Cost set to: ${tempModes[modeIndex]["distance_unit"]}");
  }

  void setCostUnit(int modeIndex, String unit){
    if (tempModes.isNotEmpty) {
      tempModes[modeIndex]["cost_unit"] = unit;
    }
    tempModes.refresh();
    log("Cost unit set to: ${tempModes[modeIndex]["cost_unit"]}");
  }

  void addNote(int modeIndex, String note) {
    if (tempModes.isNotEmpty) {
      tempModes[modeIndex]["note"] = note;
    }
    tempModes.refresh();
    log("Note added: $note at index $modeIndex");
  }

  void editTag(int modeIndex, String msg) {
    if (tempModes.isNotEmpty) {
      tempModes[modeIndex]["station"] = msg;
    }
    tempModes.refresh();
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