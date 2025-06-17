

import 'package:triptery/data/datasources/trip_data_source.dart';
import 'package:triptery/data/models/trip_model.dart';
import 'package:triptery/domain/entities/trip/trip.dart';
import 'package:triptery/domain/repositories/trip_repository.dart';


class TripRepositoryImpl implements TripRepository {
  final TripDataSource tripDataSource;
  TripRepositoryImpl({required this.tripDataSource});

  //FIXME: change to future later on cuz this is a mock repository
  @override
  Trip getTripByDayId(int day, int planId){
    final List<Map<String, Object?>> result = tripDataSource.getAllTrips();
    final List<Trip> trips = result
        .map((trip) => TripModel.fromJson(trip).toEntity())
        .where((trip) => trip.day == day && trip.planId == planId)
        .toList();
    final Trip trip = trips.firstWhere(
      (trip) => trip.day == day && trip.planId == planId,
      orElse: () => TripModel(
        id: '',
        planId: '',
        day: day,
        type: TripType.dest,
        placeId: null,
        placeName: null,
        placeDescription: null,
        placeImageUrl: null,
        arrivalTime: null,
        routeMode: RouteMode.unselected,
        routeFrom: null,
        routeTo: null,
        routeTotalTime: null,
        routeTotalCost: null,
        routeTotalDistance: null,
        routeDistance: null,
        routeNote: null,
        note: null
      ).toEntity(),
    ); 

    return trip;
  }

  //FIXME: change to future later on cuz this is a mock repository
  @override
  List<Trip> getAllTrips(int planId){
    final result = tripDataSource.getAllTrips();
    final trips = result.map((review) => TripModel.fromJson(review).toEntity()).toList();
    return trips;
  }
}

