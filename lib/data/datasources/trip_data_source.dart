import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;

class TripDataSource {
  final supabase = Supabase.instance.client;

  List<Map<String, Object?>> getAllTrips() {
    // final response = await http.get(
    //   Uri.parse('$baseUrl/movie/popular?api_key=$apiKey')
    // );
    // if (response.statusCode == 200) {
    //   final data = json.decode(response.body);
    //   return data['results'];
    // } else {
    //   throw Exception('Failed to load movies');
    // }
    final List<Map<String, Object?>> mockTrips = [
      {
        "id": "1",
        "planId": "1",
        "day": 1,
        "type": "dest",
        "placeId": "1",
        "placeName": "Pattaya walking street",
        "placeDescription":
            "a vibrant entertainment area in Pattaya that has gained notoriety for its go-go bars and adult shows, as well as karaoke bars and nightclubs",
        "placeImageUrl": "assets/images/pattaya.jpg",
        "arrivalTime": "10:00 AM",
        "routeMode": "car",
        "routeFrom": "1",
        "routeTo": "2",
        "routeTotalTime": 60,
        "routeTotalCost": 20,
        "routeTotalDistance": 30,
        "routeDistance": "30 km",
        "routeNote": "use highway",
        "note": null,
      },
      {
        "id": "2",
        "planId": "1",
        "day": 1,
        "type": "route",
        "placeId": "2",
        "placeName": "Jomtien Beach",
        "placeDescription":
            "a popular tourist destination located in Pattaya, Thailand, known for its long stretch of sand, vibrant atmosphere, and variety of activities.",
        "placeImageUrl": "assets/images/sea.jpeg",
        "arrivalTime": "11:00 AM",
        "routeMode": "publicTransit",
        "routeFrom": "2",
        "routeTo": "3",
        "routeTotalTime": 30,
        "routeTotalCost": 20,
        "routeTotalDistance": 30,
        "routeDistance": "30 km",
        "routeNote": "train leaves at 11.20AM ",
        "note": "Note for place 1",
      },
      {
        "id": "3",
        "planId": "1",
        "day": 1,
        "type": "dest",
        "placeId": "3",
        "placeName": "Sanctuary of Truth",
        "placeDescription":
            "an unfinished museum in Pattaya, Thailand designed by Thai businessman Lek Viriyaphan. The museum structure is a hybrid of a temple and a castle that is themed on the Ayutthaya Kingdom and of Buddhist and Hindu beliefs.",
        "placeImageUrl": "assets/images/sanctuary.jpg",
        "arrivalTime": "12:00 PM",
        "routeMode": "publicTransit",
        "routeFrom": null,
        "routeTo": null,
        "routeTotalTime": null,
        "routeTotalCost": null,
        "routeTotalDistance": null,
        "routeDistance": null,
        "routeNote": null,
        "note": null,
      },
      {
        "id": "4",
        "planId": "1",
        "day": 2,
        "type": "dest",
        "placeId": "3",
        "placeName": "Sanctuary of Truth",
        "placeDescription":
            "an unfinished museum in Pattaya, Thailand designed by Thai businessman Lek Viriyaphan. The museum structure is a hybrid of a temple and a castle that is themed on the Ayutthaya Kingdom and of Buddhist and Hindu beliefs.",
        "placeImageUrl": "assets/images/sanctuary.jpg",
        "arrivalTime": "12:00 PM",
        "routeMode": "publicTransit",
        "routeFrom": null,
        "routeTo": null,
        "routeTotalTime": null,
        "routeTotalCost": null,
        "routeTotalDistance": null,
        "routeDistance": null,
        "routeNote": null,
        "note": null,
      },
    ];
    return mockTrips;
  }
}
