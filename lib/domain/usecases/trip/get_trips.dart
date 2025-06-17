
import 'package:triptery/data/repositories/trip_repository.dart';
import 'package:triptery/domain/entities/trip/trip.dart';

class GetTrips {
  final TripRepositoryImpl repository; 
  GetTrips({required this.repository}); 

  List<Trip> execute() {
    return repository.getAllTrips(1);
  }
}

class GetTripByDayId {
  final TripRepositoryImpl repository;
  GetTripByDayId({required this.repository});

  Trip execute(int day, int planId) {
    return repository.getTripByDayId(day, planId);
  }
}