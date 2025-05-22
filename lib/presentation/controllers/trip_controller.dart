import 'package:flutter/material.dart'; 
import 'package:get/get.dart'; 


class TripController extends GetxController{
  final Rx<bool> _isEditingTripInfo = Rx<bool>(false); 
  bool get isEditingTripInfo => _isEditingTripInfo.value; 

  final Rx<bool> _isEditingPlaceOrder = Rx<bool>(false); 
  bool get isEditingPlaceOrder => _isEditingPlaceOrder.value; 


  void toggleEditTripInfo() {
    _isEditingTripInfo.value = !_isEditingTripInfo.value;
  }

  void toggleEditPlaceOrder() {
    _isEditingPlaceOrder.value = !_isEditingPlaceOrder.value;
  }
}
