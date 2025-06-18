
import 'package:triptery/data/repositories/trip_repository.dart';
import 'package:triptery/domain/entities/trip/trip.dart';

class GetTripByDayId {
  final TripRepositoryImpl tripRepository;
  GetTripByDayId({required this.tripRepository});

  Trip execute(int day, int planId) {
    return tripRepository.getTripByDayId(day, planId);
  }
}