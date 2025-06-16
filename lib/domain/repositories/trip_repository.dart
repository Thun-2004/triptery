
import '../entities/trip/trip.dart'; 

abstract class TripRepository {
  Future<List<Trip>> getAllTrips(int planId);
  Future<Trip> getTripByDayId(int day, int planId);
}




