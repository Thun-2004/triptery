
import 'package:triptery/data/repositories/trip_repository.dart';
import 'package:triptery/domain/entities/trip/trip.dart';

class GetTripByDayId {
  final TripRepositoryImpl tripRepository;
  GetTripByDayId({required this.tripRepository});

  Trip execute(int planId, int day) {
    return tripRepository.getTripByDayId(planId, day);
  }
}

class GetTripByPlanId {
  final TripRepositoryImpl tripRepository;
  GetTripByPlanId({required this.tripRepository});

  List<Trip> execute(int planId) {
    return tripRepository.getAllTrips(planId);
  }
}