
import '../entities/trip/trip.dart'; 

abstract class TripRepository {
  List<Trip> getAllTrips(int planId);
  Trip getTripByDayId(int day, int planId);
}




