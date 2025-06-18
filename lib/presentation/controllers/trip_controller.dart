import 'dart:developer';
import 'package:get/get.dart';
import 'package:triptery/domain/entities/trip/trip.dart';
import 'package:triptery/domain/usecases/trip/get_trips.dart'; 

//strategy = trip gradually add when day card is clicked  
class TripController extends GetxController{
  final GetTripByDayId getTripById;
  var isLoading = true.obs;
  RxList<Trip?> trips = <Trip?>[].obs; //NOTE: can't initialize list with null
  
  final Rx<bool> _isEditingTripInfo = Rx<bool>(false); 
  bool get isEditingTripInfo => _isEditingTripInfo.value; 

  final Rx<bool> _isEditingPlaceOrder = Rx<bool>(false); 
  bool get isEditingPlaceOrder => _isEditingPlaceOrder.value;

  TripController({required this.getTripById}); 

  @override
  void onInit(){
    super.onInit();
    log("🚀 TripController initialized");
  }

  Future<void> fetchTripsbyDay(int planId, int day) async {
    try{
      isLoading(true); 
      final result = await getTripById.execute(1, 1); 
      trips.value.add(result);
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
  //FIXME: create day flow(add button -> add new route -> if no route/trip exists = add button)
  
}
