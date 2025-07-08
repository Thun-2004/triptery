import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;

class PlanDataSource {
  final supabase = Supabase.instance.client;

  Map<String, Object> getPlanbyId() {
    // final response = await http.get(
    //   Uri.parse('$baseUrl/movie/popular?api_key=$apiKey')
    // );
    // if (response.statusCode == 200) {
    //   final data = json.decode(response.body);
    //   return data['results'];
    // } else {
    //   throw Exception('Failed to load movies');
    // }
    final mock_response = {
      "id": "1",
      "name": "Chill Beach at Samui",
      "ownerId": "1",
      "ownerName": "Levi",
      "ownerProfilePictureUrl": "assets/images/user.jpg",
      "coverImageUrl":
          "/Users/benn/Library/Developer/CoreSimulator/Devices/F307C51E-8567-4F8F-903B-D11B2BA3042A/data/Containers/Data/Application/AD341946-D0A8-498B-90DF-2A32379EC16D/tmp/image_picker_35B50F82-1EB9-4A3D-85AB-A4007A7379E1-51737-00000FA5292A3D62.jpg",
      "totalCopied": 50,
      "totalLikes": 20,
      "dayStart": "2025-07-01T00:00:00.000",
      "dayEnd": "2025-07-05T00:00:00.000",
      "dayCount": 2,
      "location": "Pattaya, Thailand",
      "note": "A fun trip to Pattaya with friends.",
      "visibility": "public",
      "budget": "cheap",
      "party": "friends",
      "createdAt": "2025-02-01T00:00:00.000",
    };
    return mock_response;
  }

  List<Map<String, Object>> getPlanReviews() {
    final mock_response = [
      {
        "id": "1",
        "userId": "1",
        "username": "Levi",
        "userProfilePictureUrl": "assets/images/user.jpg",
        "planId": "1",
        "rating": 5,
        "description": "Very good no titan",
        "createdAt": 1729113623000,
      },
      {
        "id": "1",
        "userId": "2",
        "username": "Eren",
        "userProfilePictureUrl": "assets/images/user.jpg",
        "planId": "1",
        "rating": 4,
        "description": "Great trip, I love it",
        "createdAt": 1729113623000,
      },
    ];
    return mock_response;
  }
}
