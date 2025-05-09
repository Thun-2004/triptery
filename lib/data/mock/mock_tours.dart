import '../../domain/entities/place/place.dart';
import '../../presentation/widgets/destination_card.dart';
import 'mock_places.dart';

final topBangkokTours = mockPlaces
    .where((place) => place.city == 'Bangkok')
    .take(4)
    .map((place) => DestinationCard(place: place))
    .toList();

final popularActivities = mockPlaces
    .where((place) => place.city != 'Bangkok')
    .take(2)
    .map((place) => DestinationCard(place: place))
    .toList();
