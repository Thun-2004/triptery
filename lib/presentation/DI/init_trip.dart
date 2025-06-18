
import 'package:get/get.dart';
import 'package:triptery/data/datasources/trip_data_source.dart';
import 'package:triptery/data/repositories/trip_repository.dart';
import 'package:triptery/domain/usecases/trip/get_trips.dart';
import 'package:triptery/presentation/controllers/trip_controller.dart';

class TripDI{
  static void init() {
    final tripDataSource = TripDataSource(); 
    final tripRepository = TripRepositoryImpl(tripDataSource: tripDataSource); 
    final getTripById = GetTripByDayId(tripRepository: tripRepository); 
    Get.put(TripController(getTripById: getTripById)); 
  }
}